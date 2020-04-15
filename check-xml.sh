#!/bin/sh
echo Using hand-edited table of xml links to svx files "chk-xml.txt"
# TO DO - replace this hand edited set of links with an automated scanner
# possibly using tunnel code to do the parsing.
# see readme.txt for the horrible collection of sed and grep oneliners I used.
# We can recognise /loser/ and throw away the local PC stuff.
# NB Therion has no references to survex files so we can't do this for therion drawings.
awk '
BEGIN {
    lc = "/mnt/d/CUCC-Expo/"
}
// {
    # both are full paths /home/expo/loser etc.
    xml=$1
    svx=$2
    n=sub(/\/home\/expo\//,"",xml)
    n=sub(/\/home\/expo\//,"",svx)
    lcxml = lc xml
    lcsvx = lc svx
    dxml = xml
    dsvx = svx
    n=sub(/drawings\//,"",dxml)
    n=sub(/loser\//,"",dsvx)
    urlxml = "tunneldataraw/" dxml
    urlsvx = "survexfile/" dsvx
    if (system("test -s " lcsvx)==0) {
        print "<a href=\"/"urlxml"\" download>"dxml"</a>", "->",
            "<a href=\"/"urlsvx"\" target=\"_blank\">"dsvx"</a>" > "xml-refs.ok.tmp"
    } else {
        print "<a href=\"/"urlxml"\" download>"dxml"</a>", "->",
            "<font color=\"red\">" dsvx "</font>" > "xml-refs.err.tmp"
    }
    print xml
}
' chk-xml.txt
#
sort < xml-refs.ok.tmp > xml-refs.ok
rm xml-refs.ok.tmp
sort < xml-refs.err.tmp > xml-refs.err
rm xml-refs.err.tmp
echo "<html><head></head><body><pre>"  >../expoweb/xml-refs.err.html
cat xml-refs.err                      >>../expoweb/xml-refs.err.html
echo "</pre></body></html>"           >>../expoweb/xml-refs.err.html
echo "<html><head></head><body><pre>"  >../expoweb/xml-refs.ok.html
cat xml-refs.ok                       >>../expoweb/xml-refs.ok.html
echo "</pre></body></html>"           >>../expoweb/xml-refs.ok.html

if test -s xml-refs.err ; then true ; else rm xml-refs.err ; fi

exit
-----------------
finding bad svx regferences
cd /home/expo/drawings
grep -ir *file_begin *|sed "s/\&backslash;/\\\\/g" | awk 'BEGIN {FS=";"}; // { for (i = 1; i<=NF; i++) print $1,$i}' | grep svx | awk '// {print $1, $NF}' | sed 's/&quot//g' |sort | uniq

grep -ir *file_begin *| awk 'BEGIN {FS=";"}; // { for (i = 1; i<=NF; i++) print $1,$i}' | grep svx | awk '// {print $1, $NF}' | sed 's/&quot//g' |sort | uniq

sed -i 's;"C:&backslash;Users&backslash;goatchurch&backslash;caving&backslash;loser&backslash;";"/home/expo/loser/";' */*.xml
sed -i 's;C:\\REBECCA\\Tunnel\\CUCCAustria\\loser\\;/home/expo/loser/g;' */*.xml
sed -i 's;/home/martin/expo/loser/;/home/expo/loser/;g' */*.xml
gps17.svx&space
sed -i 's;gps17.svx;/home/expo/loser/fixedpts/gps17.svx;g' */*.xml
sed -i 's;/Users/georgebreley/Documents/Caving/SurveyData/Austria/loser/;/home/expo/loser/;g' */*.xml
sed -i 's;/Users/goatchurch/caving/loser/;/home/expo/loser/;g' */*.xml
sed -i 's;/Users/pjf33/expo/hg/loser/;/home/expo/loser/;g' */*/*.xml
sed -i 's;/home/sam/expo/loser/;/home/expo/loser/;g' */*/*.xml
sed -i 's;/gps17.svx\&space;gps17.svx &space;g' */*/*.xml
sed -i 's;/loser/caves/264/;/loser/caves-1623/264/;g' */*/*.xml
sed -i 's;/loser/caves/;/loser/caves-1623/;g' */*/*.xml

awk '{printf("/home/expo/drawings/%s %s\n",$2,$1)}' xml-chk.txt | tr ':' ' ' |sort >chk-xml.txt