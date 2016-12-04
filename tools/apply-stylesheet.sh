#!/bin/bash

PARSED_OPTIONS=$(getopt -n "$0"  -o hf: --long "file:,TextFrom:,TextTo:,BackgroundFrom:,BackgroundTo:,HighlightFrom:,HighlightTo:,ViewTextFrom:,ViewTextTo:,ViewBackgroundFrom:,ViewBackgroundTo:,ViewHoverFrom:,ViewHoverTo:,ViewFocusFrom:,ViewFocusTo:,ButtonTextFrom:,ButtonTextTo:,ButtonBackgroundFrom:,ButtonBackgroundTo:,ButtonHoverFrom:,ButtonHoverTo:,ButtonFocusFrom:,ButtonFocusTo:"  -- "$@")

if [ $? -ne 0 ];
then
  exit 1
fi

eval set -- "$PARSED_OPTIONS"

textFrom=\#31363b
backgroundFrom=\#eff0f1
highlightFrom=\#3daee9
viewTextFrom=\#31363b
viewBackgroundFrom=\#fcfcfc
viewHoverFrom=\#93cee9
viewFocusFrom=\#3daee9
buttonTextFrom=\#31363b
buttonBackgroundFrom=\#eff0f1
buttonHoverFrom=\#93cee9
buttonFocusFrom=\#3daee9

textTo=\#31363b
backgroundTo=\#eff0f1
highlightTo=\#3daee9
viewTextTo=\#31363b
viewBackgroundTo=\#fcfcfc
viewHoverTo=\#93cee9
viewFocusTo=\#3daee9
buttonTextTo=\#31363b
buttonBackgroundTo=\#eff0f1
buttonHoverTo=\#93cee9
buttonFocusTo=\#3daee9

file=''

while true;
do
  case "$1" in
 
    -h|--help)
      echo "usage $0 [-h|options] -f file.svgz"
      echo "Where options can be:"
      echo " --TextFrom=color html encoded color to replace with the ColorScheme-Text from the stylesheet"
      echo " --TextTo=color html encoded that the ColorScheme-Text class will have"
      echo
      echo " --BackgroundFrom=color html encoded color to replace with the ColorScheme-Background from the stylesheet"
      echo " --BackgroundTo=color html encoded that the ColorScheme-Background class will have"
      echo
      echo " --HighlightFrom=color html encoded color to replace with the ColorScheme-Highlight from the stylesheet"
      echo " --HighlightTo=color html encoded that the ColorScheme-Highlight class will have"
      echo
      echo " --ViewTextFrom=color html encoded color to replace with the ColorScheme-ViewText from the stylesheet"
      echo " --ViewTextTo=color html encoded that the ColorScheme-ViewText class will have"
      echo
      echo " --ViewBackgroundFrom=color html encoded color to replace with the ColorScheme-ViewBackground from the stylesheet"
      echo " --ViewBackgroundTo=color html encoded that the ColorScheme-ViewBackground class will have"
      echo
      echo " --ViewHoverFrom=color html encoded color to replace with the ColorScheme-ViewHover from the stylesheet"
      echo " --ViewHoverTo=color html encoded that the ColorScheme-ViewHover class will have"
      echo
      echo " --ViewFocusFrom=color html encoded color to replace with the ColorScheme-ViewFocus from the stylesheet"
      echo " --ViewFocusTo=color html encoded that the ColorScheme-ViewFocus class will have"
      echo
      echo " --ButtonTextFrom=color html encoded color to replace with the ColorScheme-ButtonText from the stylesheet"
      echo " --ButtonTextTo=color html encoded that the ColorScheme-ButtonText class will have"
      echo
      echo " --ButtonBackgroundFrom=color html encoded color to replace with the ColorScheme-ButtonBackground from the stylesheet"
      echo " --ButtonBackgroundTo=color html encoded that the ColorScheme-ButtonBackground class will have"
      echo
      echo " --ButtonHoverFrom=color html encoded color to replace with the ColorScheme-ButtonHover from the stylesheet"
      echo " --ButtonHoverTo=color html encoded that the ColorScheme-ButtonHover class will have"
      echo
      echo " --ButtonFocusFrom=color html encoded color to replace with the ColorScheme-ButtonFocus from the stylesheet"
      echo " --ButtonFocusTo=color html encoded that the ColorScheme-ButtonFocus class will have"
      echo
      echo "All the colors have default values conformant to the Breeze color palette"
      echo
      exit
     shift;;
 
    --TextFrom)
      textFrom=$2
      shift 2;;
    --TextTo)
      textTo=$2
      shift 2;;
 
    --BackgroundFrom)
      backgroundFrom=$2
      shift 2;;
    --BackgroundTo)
      backgroundTo=$2
      shift 2;;

    --HighlightFrom)
      highlightFrom=$2
      shift 2;;
    --HighlightTo)
      highlightTo=$2
      shift 2;;

    --ViewTextFrom)
      viewTextFrom=$2
      shift 2;;
    --ViewTextTo)
      viewTextTo=$2
      shift 2;;

    --ViewBackgroundFrom)
      viewBackgroundFrom=$2
      shift 2;;
    --ViewBackgroundTo)
      viewBackgroundTo=$2
      shift 2;;

    --ViewHoverFrom)
      viewHoverFrom=$2
      shift 2;;
    --ViewHoverTo)
      viewHoverTo=$2
      shift 2;;

    --ViewFocusFrom)
      viewFocusFrom=$2
      shift 2;;
    --ViewFocusTo)
      viewFocusTo=$2
      shift 2;;

    --ButtonTextFrom)
      buttonTextFrom=$2
      shift 2;;
    --ButtonTextTo)
      buttonTextTo=$2
      shift 2;;

    --ButtonBackgroundFrom)
      buttonBackgroundFrom=$2
      shift 2;;
    --ButtonBackgroundTo)
      buttonBackgroundTo=$2
      shift 2;;

    --ButtonHoverFrom)
      buttonBackgroundFrom=$2
      shift 2;;
    --ButtonHoverTo)
      buttonHoverTo=$2
      shift 2;;

    --ButtonFocusFrom)
      buttonFocusFrom=$2
      shift 2;;
    --ButtonFocusTo)
      buttonFocusTo=$2
      shift 2;;

    -f|--file)
      file=`echo $2 | cut -d'.' --complement -f2-`
      shift 2;;

    --)
      shift
      break;;
  esac
done


if [ -z "$file" ]; 
    then echo missing svg file
    exit 1
fi

isSvgz=0

if [ ! -f $file.svgz ] && [ ! -f $file.svg ]; then
    echo "you must specify a valid svg"
    exit 1
fi

if [ -f $file.svgz ]; then
    isSvgz=1
fi


if [ $isSvgz = 1 ]; then
    mv $file.svgz $file.svg.gz
    gunzip $file.svg.gz
fi

echo Processing $file

stylesheet="
      .ColorScheme-Text {
        color:$textTo;
      }
      .ColorScheme-Background {
        color:$backgroundTo;
      }
      .ColorScheme-Highlight {
        color:$highlightTo;
      }
      .ColorScheme-ViewText {
        color:$viewTextTo;
      }
      .ColorScheme-ViewBackground {
        color:$viewBackgroundTo;
      }
      .ColorScheme-ViewHover {
        color:$viewHoverTo;
      }
      .ColorScheme-ViewFocus{
        color:$viewFocusTo;
      }
      .ColorScheme-ButtonText {
        color:$buttonTextTo;
      }
      .ColorScheme-ButtonBackground {
        color:$buttonBackgroundTo;
      }
      .ColorScheme-ButtonHover {
        color:$buttonHoverTo;
      }
      .ColorScheme-ButtonFocus{
        color:$buttonFocusTo;
      }
      "
colors=($textFrom $backgroundFrom $highlightFrom $viewTextFrom $viewBackgroundFrom $viewHoverFrom $viewFocusFrom $buttonTextFrom $buttonBackgroundFrom $buttonHoverFrom $buttonFocusFrom)
colorNames=(ColorScheme-Text ColorScheme-Background ColorScheme-Highlight ColorScheme-ViewText ColorScheme-ViewBackground ColorScheme-ViewHover ColorScheme-ViewFocus ColorScheme-ButtonText ColorScheme-ButtonBackground ColorScheme-ButtonHover ColorScheme-ButtonFocus)

reorderXslt='
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:svg="http://www.w3.org/2000/svg">
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 <xsl:strip-space elements="*"/>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="svg:defs">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="*">
        <xsl:sort select="name()" data-type="text" order="descending"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
'
echo $reorderXslt > transform.xsl

if grep -q '"current-color-scheme"' $file.svg; then
    echo replacing the stylesheet
    xmlstarlet ed --update "/svg:svg/svg:defs/_:style" -v "$stylesheet" $file.svg > temp.svg
else
    echo adding the stylesheet
xmlstarlet ed --subnode "/svg:svg/svg:defs" -t elem -n "style" -v "$stylesheet"\
       --subnode "/svg:svg/svg:defs/style" -t attr -n "type" -v "text/css"\
       --subnode "/svg:svg/svg:defs/style" -t attr -n "id" -v "current-color-scheme" $file.svg > temp.svg
fi

xmlstarlet tr transform.xsl temp.svg > temp2.svg
mv temp2.svg temp.svg

for i in {0..4}
do
  xmlstarlet ed --subnode "//*/*[contains(@style, '${colors[i]}') and not (@class)]" -t attr -n "class" -v "${colorNames[i]}" temp.svg > temp2.svg

  mv temp2.svg temp.svg

  sed -i 's/\(style=".*\)fill:'${colors[i]}'/\1fill:currentColor/g' temp.svg
  sed -i 's/\(style=".*\)stop-color:'${colors[i]}'/\1stop-color:currentColor/g' temp.svg
done

rm transform.xsl

mv temp.svg $file.svg
if [ $isSvgz = 1 ]; then
    gzip $file.svg
    mv $file.svg.gz $file.svgz
fi
