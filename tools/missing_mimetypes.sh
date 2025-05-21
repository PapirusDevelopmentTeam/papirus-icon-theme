#!/usr/bin/env bash
#: Use this computer's shared-mime-info database to find missing MIME type
#: icons in Papirus. This script can also be used to discover which icon
#: would be used for a given MIME type, and why.
#:
#: usage: __SCRIPT__ [OPTIONS]

set -euo pipefail

SRCDIR=$(realpath "../Papirus")
AVAILABLE_ICONS_CACHE="x-srcdir-icons"
MIME_DIRS_CACHE="x-mimedirs"
MIME_TYPES_CACHE="types"
MIME_ICONS_CACHE="icons"
MIME_GENERIC_ICONS_CACHE="generic-icons"

# Command line option vars and default behaviour
VERBOSITY=1
SHOW_HEADER=1
SCAN_PERSONAL_MIMEDIR=0


show_usage () {
    script=$(basename "$0")
    sed -Ee 's/^\s*#:\s?//p;d' "$0" | sed -Ee 's/__SCRIPT__/'"$script"'/' >&2
}


# Get all MIME dirs on the system.

get_mime_dirs () {
    local data_dirs=${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}
    if [[ $SCAN_PERSONAL_MIMEDIR -gt 0 ]]; then
        data_dirs="${XDG_DATA_HOME:-$HOME/.local/share}:${data_dirs}"
    fi
    local IFS=:
    for d in $data_dirs; do
        local m="$d/mime"
        [ -d "$m" ] || continue
        printf "%s\n" "$m"
    done
}


# Gathers a list of all available icon names in $SRCDIR.
# This is not limited to just icons in the mimetypes subfolders,
# because explicit <icon/> and <generic-icon/> dirctives
# may name icons in any context.

get_available_icons () {
    find "$SRCDIR/"*'x'* \( -type f -o -type l \) -name '*.svg' \
        | sed -e 's!.*/!!;s![.]svg$!!' \
        | sort | uniq
}



# Collects a line-oriented cache file from all shared-mime-info MIME dirs.
# Expects to be run inside the working tempdir.

get_mimedirs_cache () {
    local cache="$1"
    while read -r d; do
        local c="$d/$cache"
        [ -f "$c" ] || continue
        cat "$c"
    done < "$MIME_DIRS_CACHE" | sort | uniq
}



# Display a header for the lines check_mimetype outputs.

show_header () {
    ((SHOW_HEADER)) || return 0
    cat <<"__END_HEADER__"
┌─────── E=Exact icon found, as named in the mimetype’s <icon/> directive.
│┌────── e=Exact icon found using the default “replace / with -” strategy.
││┌───── G=Generic icon found, as named in the mimetype’s <generic-icon/>.
│││┌──── g=Generic icon found using the default “<type>/x-generic” strategy.
││││ ┌── Match quality (filtered by --output-level).
││││ │ ┌ MIME type + any named matches from E and G.
││││ │ │
__END_HEADER__
}


# Check one MIME type has a valid icon in the theme.
# Expects to be run inside the working tempdir.

check_mimetype () {
    local mimetype="$1"
    local mimetype_re
    mimetype_re=$(sed -Ee 's!(\W)!\\\1!g' <<< "$mimetype")

    local icon
    local match_quality
    local named_matches=""
    local flag_char
    local flags_str=""
    local color

    # First possibility is that it has an explicit icon override
    # defined in MIMEDIRS/icons. This falls through to the tests below
    # if there's no icon, or if there's no override defined.
    flag_char="-"
    icon=$(sed -Ee "s#^${mimetype_re}:##g; tL; d; :L q" "$MIME_ICONS_CACHE")
    if [ -n "$icon" ]; then
        if grep -q -x -F "$icon" -- "$AVAILABLE_ICONS_CACHE"; then
            match_quality=${match_quality:-4}  # best
            [[ VERBOSITY -lt match_quality ]] && return 0
            flag_char="E"
            color=${color:-2} # green
            named_matches="${named_matches}, ${icon}"
        fi
    fi
    flags_str="${flags_str}${flag_char}"

    # Second possibility is that we can form an icon name by
    # substituting "-" for "/" in the mimetype.
    flag_char="-"
    icon=$(sed -Ee 's#/#-#g' <<< "$mimetype")
    if grep -q -x -F "$icon" -- "$AVAILABLE_ICONS_CACHE"; then
        match_quality=${match_quality:-3}  # good
        [[ VERBOSITY -lt match_quality ]] && return 0
        flag_char="e"
        color=${color:-2} # green
    fi
    flags_str="${flags_str}${flag_char}"

    # Third chance for the mimetype is that there's a generic icon defined as
    # a fallback in MIMEDIRS/generic-icons. The syntax of these files is the
    # same as MIMEDIRS/icons
    flag_char="-"
    icon=$(sed -Ee "s#^${mimetype_re}:##g; tL; d; :L q" \
           "$MIME_GENERIC_ICONS_CACHE")
    if [ -n "$icon" ]; then
        if grep -q -x -F "$icon" -- "$AVAILABLE_ICONS_CACHE"; then
            match_quality=${match_quality:-2}  # reasonable
            [[ VERBOSITY -lt match_quality ]] && return 0
            flag_char="G"
            color=${color:-3}  # yellow
            named_matches="${named_matches}, ${icon}"
        fi
    fi
    flags_str="${flags_str}${flag_char}"

    # Final chance!
    # Try to form an icon name as if the subtype was "x-generic" instead.
    flag_char="-"
    icon=$(sed -Ee 's#/.*#-x-generic#g' <<< "$mimetype")
    if grep -q -x -F "$icon" -- "$AVAILABLE_ICONS_CACHE"; then
        match_quality=${match_quality:-1}  # poor, but sometimes acceptable
        [[ VERBOSITY -lt match_quality ]] && return 0
        flag_char="g"
        color=${color:-1}  # red
    fi
    flags_str="${flags_str}${flag_char}"

    # Format the summary line.
    color=${color:-1}  # red
    match_quality=${match_quality:-0}   # worst
    if [[ VERBOSITY -ge match_quality ]]; then
        local style_on=""
        local style_off=""
        if [[ -t 1 ]]; then
            printf -v style_on '\033[3%dm' "$color"
            printf -v style_off '\033[0m'
        fi
        printf '%s%s %d %s' \
            "$style_on" "$flags_str" "$match_quality" "$mimetype"
        if [[ -n $named_matches ]]; then
            printf ' → {%s}' \
                "$(sed -Ee 's!^,\s*!!' <<< "$named_matches")"
        fi
        printf '%s\n' "$style_off"
    fi
}


# Show a summary of all known MIME types that don't have an icon in SRCDIR.
# Expects to be run inside the working tempdir.

find_missing_mimetype_icons () {
    # Start by caching lots of info
    get_mime_dirs > "$MIME_DIRS_CACHE"
    get_available_icons > "$AVAILABLE_ICONS_CACHE"
    for cache in \
        "$MIME_ICONS_CACHE" "$MIME_TYPES_CACHE" \
        "$MIME_GENERIC_ICONS_CACHE"
    do
        get_mimedirs_cache "$cache" > "./$cache"
    done

    show_header
    while read -r type; do
        check_mimetype "$type" </dev/null
    done < "$MIME_TYPES_CACHE"
}


# Convert a single Boolean argument to 0 or 1.

boolify () {
    local arg
    arg=$(tr '[:lower:]' '[:upper:]' <<< "$1")
    case "$arg" in
        1|TRUE|Y|YES)
            printf "%s\n" 1
            return 0
            ;;
        0|FALSE|N|NO)
            printf "%s\n" 0
            return 0
            ;;
    esac
    printf >&2 "ERROR: %s\n" \
        "boolean value must be 1/true/yes or 0/false/no"
    exit 2
}


# Parse args and dispatch commands

parse_args () {
    #:
    #: Options:
    #:
    local flag value
    while [ $# -gt 0 ]; do
        case "$1" in
            # The "--" symbol indicates no further options.
            --)
                shift
                break
                ;;
            #: --help, -h
            #:      Show this help message, then exit.
            --help|-h)
                shift
                show_usage
                exit 0
                ;;
            #: --output-level INT, -l INT       (default: 1)
            #:      How much output to show. Smaller values show less info,
            #:      larger values show more info about successful lookups.
            --output-level|-l)
                shift
                value="${1:?No value for --output-level}"
                shift
                VERBOSITY=$((value + 0))
                ;;
            #: --verbose, -v
            #:      Increase output verbosity.
            --verbose|-v)
                shift
                VERBOSITY=$((VERBOSITY + 1))
                ;;
            #: --quiet, -q
            #:      Decrease output verbosity.
            --quiet|-q)
                shift
                VERBOSITY=$((VERBOSITY - 1))
                ;;
            #: --personal-mimedir BOOL          (default: 0)
            #:      Load mimetypes etc. from ~/.local/share/mime too.
            --personal-mimedir)
                shift
                flag="${1:?No value for --personal-mimedir}"
                shift
                SCAN_PERSONAL_MIMEDIR=$(boolify "$flag")
                ;;
            -*)
                printf 'Unrecognised option: "%s"\n' "$1"
                shift
                return 1
                ;;
            *)
                break
                ;;
        esac
    done

    #:
    #: By default, at output level 1, this script shows which MIMEtypes
    #: are falling back to "<type>-x-generic.svg". That's usually the best
    #: place to look for mimetypes which need something more specific.
    #:

    if [ $# -ne 0 ]; then
        printf "%s\n" "This script takes no positional parameters"
        printf "\n"
        return 1
    fi

    return 0
}


# Main script flow.

main () {
    if ! parse_args "$@"; then
        printf >&2 "ERROR: failed to parse command line\n"
        show_usage
        exit 1
    fi
    local tempdir
    tempdir=$(mktemp --directory)
    ( cd "$tempdir" && find_missing_mimetype_icons ) || true
    rm -fr "$tempdir"
}
main "$@"
