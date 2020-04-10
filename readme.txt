This repo holds all the CUCC expo cave drawings.
It was originally called 'tunneldata' and was managed with mercurial.

It was renamed 'drawings' when it was converted to git by Wookey
on 8th July 2019.

Install
-------
Choose a directory where you will keep 'drawings', and git clone 'drawings' into it using the following command:

git clone git://expo.survex.com/drawings
or more reliably
git clone ssh://expo@expo.survex.com/home/expo/drawings

-----------------
finding bad svx references inside tunnel files
look for <pctext> ... </pctext> tag
see check-xml.sh for what happens next
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

