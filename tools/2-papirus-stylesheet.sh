#!/bin/bash

PARSED_OPTIONS=$(getopt -n "$0"  -o hf: --long "file:,TextFrom:,TextTo:,HighlightFrom:,HighlightTo:,ButtonBackgroundFrom:,ButtonBackgroundTo:"  -- "$@")

if [ $? -ne 0 ];
then
  exit 1
fi

eval set -- "$PARSED_OPTIONS"

textFrom=\#5c616c
highlightFrom=\#5294e2
buttonBackgroundFrom=\#d3dae3

textTo=\#5c616c
highlightTo=\#5294e2
buttonBackgroundTo=\#d3dae3

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
      echo " --HighlightFrom=color html encoded color to replace with the ColorScheme-Highlight from the stylesheet"
      echo " --HighlightTo=color html encoded that the ColorScheme-Highlight class will have"
      echo
      echo " --ButtonBackgroundFrom=color html encoded color to replace with the ColorScheme-ButtonBackground from the stylesheet"
      echo " --ButtonBackgroundTo=color html encoded that the ColorScheme-ButtonBackground class will have"
      echo
      echo "All the colors have default values conformant to the Papirus color palette"
      echo
      exit
     shift;;
 
    --TextFrom)
      textFrom=$2
      shift 2;;
    --TextTo)
      textTo=$2
      shift 2;;

    --HighlightFrom)
      highlightFrom=$2
      shift 2;;
    --HighlightTo)
      highlightTo=$2
      shift 2;;

    --ButtonBackgroundFrom)
      buttonBackgroundFrom=$2
      shift 2;;
    --ButtonBackgroundTo)
      buttonBackgroundTo=$2
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
      .ColorScheme-Highlight {
        color:$highlightTo;
      }
      .ColorScheme-ButtonBackground {
        color:$buttonBackgroundTo;
      }
      "
colors=($textFrom $highlightFrom $buttonBackgroundFrom)
colorNames=(ColorScheme-Text ColorScheme-Highlight ColorScheme-ButtonBackground)

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
