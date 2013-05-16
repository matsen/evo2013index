htmlfile=pp.html

cat > index.html <<HEADER
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=us-ascii" />
<link href="http://www.evolutionmeeting.org/engine/botany.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table width="800" border="0" cellspacing="0" cellpadding="0" valign="top">
HEADER


for w in $(cat $htmlfile | grep '</td>' | grep -v '^<' | sed -e 's#</td>##' -e 's/ [^ ]*$//' | grep -v '>' | sed -e 's/ /_/g' | sort | uniq); do
    echo $w
    safew=$(echo $w | sed -e 's#[/:,]#_#g')
    echo $safew
    cat > $safew.html <<HEADER
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=us-ascii" />
<link href="http://www.evolutionmeeting.org/engine/botany.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table width="800" border="0" cellspacing="0" cellpadding="0" valign="top">
HEADER

    grep -B5 -A2 "$(echo $w | sed -e 's/_/ /g')" $htmlfile | grep -v '^\-\-*' >> $safew.html

    cat > $safew.html <<TRAILER
</body>
</html>
TRAILER

    echo "<tr><td><a href=\"$safew.html\">$safew</a></td></tr>" >> index.html

done

cat >> index.html <<TRAILER
</body>
</html>
TRAILER


