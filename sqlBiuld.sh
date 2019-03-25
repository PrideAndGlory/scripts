#1/bin/bash
new=$1
file=buld.sql
old=$2
if [ -z $old  ] ;then
 old=" "
fi

#build dml file................
exec 3>$file
echo "UPDATE IC_PPCA_T" >&3
echo "SET DOCTMPL='$new'"  >&3
echo "WHERE DOCTMPL='$old'" >&3

#Run DML file..................

JRT_HOME//bin/jrtstart -i  $INSTANCE -s run-sql/acm/Databoxes/$file
