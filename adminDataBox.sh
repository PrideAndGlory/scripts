#!/bin/bash
Time=$1
File=/acm/Databoxes/Main/admin_$Time.xml
tipe=$2
mesage=""

#Msages for data box..............

case $tipe in
1)
  message=" �� ����×���� $Time �×���� ���� ��×��¨��  " ;;
2)
  message=" $Time �×���� �¢���� ����©�����×��¨��  " ;;
3)
  message="$Time ����©����� �¨�¢� �� ��¨�©���× ��×��¨�� " ;;
esac

#Build Databox file..................
exec 3>$File
echo '<?xml version="1.0" encoding="UTF-8"?>' >&3
echo '<databox>' >&3
echo '   <Application></Application> '>&3
echo '  <SystemParameter>' >&3
echo '    <Key>' >&3
echo '      <SYPMNA value="GUI.ADMINISTRATOR.MESSAGE"/>' >&3
echo '    </Key>' >&3
echo '    <Data>' >&3
echo '      <SYPMVA value="'$message'"/>' >&3
echo '    </Data>' >&3
echo '    <Header>' >&3
echo '      <Action value="Update"/>' >&3
echo '    </Header>' >&3
echo '  </SystemParameter>' >&3
echo '</databox>' >&3

#Load data box ..................


$JRT_HOME/bin/jrtstar -node 'AdminMessage' -i $INSTANCE -machine $HOSTNAME -s ac lcs-loader -filein $File -threads 10 -fileout /acm/ALGO_TOP/load_logs_output/adminBox.xml -maxerror 5
err=$?
if [ $err -eq 0 ] ; then
    exit 0
fi
if [ $err -eq 17 ] ; then
   exit 17
fi
exit 2
