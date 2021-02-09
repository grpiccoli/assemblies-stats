#!/bin/bash
mkdir -p json css js
cmd="cat /usr/local/bin/assembly-stats-17.02/assembly-stats.html | sed -r"
for (( i= 0; i <= $#; i++))
do
    name=`basename $1`
    name=${name//./_}
    echo "var $name = " > json/$name.json
    asm2stats.pl $1 >> json/$name.json
    echo "localStorage.setItem('$name',JSON.stringify($name))" >> json/$name.json
    cmd="$cmd -e 's%<!--add_jsons_here-->%& <script type=\"text/javascript\" src=\"json/$name.json\"></script>%'"
    shift
done
eval $cmd
cat /usr/local/bin/assembly-stats-17.02/css/circle-plot.css > css/circle-plot.css
cat /usr/local/bin/assembly-stats-17.02/css/square-plot.css > css/square-plot.css
cat /usr/local/bin/assembly-stats-17.02/css/table.css > css/table.css
cat /usr/local/bin/assembly-stats-17.02/js/circle-plot.js > js/circle-plot.js
cat /usr/local/bin/assembly-stats-17.02/js/square-plot.js > js/square-plot.js
cat /usr/local/bin/assembly-stats-17.02/js/table.js > js/table.js
cat /usr/local/bin/assembly-stats-17.02/js/d3.js > js/d3.js
cat /usr/local/bin/assembly-stats-17.02/js/jquery.min.js > js/jquery.min.css
