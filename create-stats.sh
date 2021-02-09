#!/bin/bash
cp -R /usr/local/bin/assembly-stats-17.02 .
mkdir -p json
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