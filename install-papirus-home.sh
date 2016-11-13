#!/bin/bash

# Download and install the latest Papirus Icon theme

#set -x
set -e

DL_URL="https://github.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/archive/master.zip"
TARGET_DIR=$HOME/.icons
HASH_FILE=$TARGET_DIR/.papirus-icons.etag

get_remote_hash() {
    curl -i -s -I -L $DL_URL | grep -i '^ETag: '
}

get_local_hash() {
    touch $HASH_FILE
    cat $HASH_FILE
}

extract() {
    if [ -x /usr/bin/7z ]; then
        /usr/bin/7z x "$1" -o"$2"
    else
        /usr/bin/unzip "$1" -d "$2"
    fi
}

echo "Papirus icon theme for GTK"

mkdir -p $TARGET_DIR

echo "Comparing versions ..."
REMOTE_HASH=$(get_remote_hash)
LOCAL_HASH=$(get_local_hash)

if [ "$REMOTE_HASH" == "$LOCAL_HASH" ]
then
    echo "Already using the latest version"
    exit 0
fi

echo "Download new version from GitHub ..."
TEMP_DIR=$(mktemp -d)
curl -L $DL_URL -o $TEMP_DIR/master.zip

echo "Unpack archive ..."
extract $TEMP_DIR/master.zip $TEMP_DIR

echo "Delete old Papirus icon theme ..."
rm -rf $TARGET/{Papirus-GTK,Papirus-Dark-GTK}

echo "Installing ..."
mv $TEMP_DIR/papirus-icon-theme-gtk-master/{Papirus-GTK,Papirus-Dark-GTK} $TARGET

echo -n "$REMOTE_HASH" > $HASH_FILE

echo "Delete cache ..."
rm -rf $TEMP_DIR
echo "Done!"
