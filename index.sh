htmlfile=pp.html

cat > index.html <<HEADER
<!DOCTYPE html>
<html>
<head>
<link href="http://www.evolutionmeeting.org/engine/botany.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table width="800" border="0" cellspacing="0" cellpadding="0">
HEADER


for w in $(cat $htmlfile | grep '</td>' | grep -v '^<' | sed -e 's#</td>##' -e 's/ [^ ]*$//' | grep -v '>' | sed -e 's/ /_/g' | sort | uniq); do
    echo $w
    safew=$(echo $w | sed -e 's#[/:,]#_#g')
    echo $safew
    cat > $safew.html <<HEADER
<!DOCTYPE html>
<html>
<head>
<title>$safew</title>
<link href="http://www.evolutionmeeting.org/engine/botany.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table width="800" border="0" cellspacing="0" cellpadding="0">
HEADER

    grep -B7 -A2 "$(echo $w | sed -e 's/_/ /g')" $htmlfile | grep -v '^\-\-*' >> $safew.html

    cat >> $safew.html <<TRAILER
</table>
</body>
</html>
TRAILER

    echo "<tr><td><a href=\"$safew.html\">$safew</a></td></tr>" >> index.html

done

cat >> index.html <<TRAILER
</table>
</body>
</html>
TRAILER


