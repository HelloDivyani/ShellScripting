#Argument Supply Check
if [ -z "$1" ]
then
echo "Please supply the start time in format YYYYMMDDHHMMSSMMM"
exit 1
fi
if [ -z "$2" ]
then
echo "Please supply the end time in format YYYYMMDDHHMMSSMMM"
exit 1
fi
if [ -z "$3" ]
then
echo "Please supply phone number to be Searched for :"
exit 1
fi
if [ -z "$4" ]
then
echo "Please supply the location of report file to be stored :"
exit 1
fi

#Arguments
start=$1
end=$2
pno=$3
location=$4


#Suppose inside cluster 1
#Log into Payload1 
#For each payload we have log file and report file

for folder in `ls -d ~/project_btas/cluster1/* | sed -r 's/^.+\///'`
do

echo $folder
#folder variable complete path till payload1

log="log"
report="report"

#Log File Generated Path :  cd ~/project_btas
if [ ! -f ~/project_btas/Logs/$folder$log.txt ]
then
#Log File not present Create it
touch ~/project_btas/Logs/$folder$log.txt
fi


#Generating Final Report File :
if [ ! -f $location/$folder$report.txt ]
then
touch $location/$folder$report.txt
fi


#myFile is variable looped for multiple files in 1 blade
for i in `ls *.csv`
do
myFile=$i


echo "CDR Analysis in File : $myFile " >> ~/project_btas/Logs/$folder$log.txt

mylist=`grep -n -c $pno  $myFile`
mylines=`grep -n $pno $myFile`


#Log File writing

echo "Total Number of Lines Phone found : $mylist" >> ~/project_btas/Logs/$folder$log.txt
echo "Lines Containing the phone number :\n $mylines" >> ~/project_btas/Logs/$folder$log.txt

echo "Call Details -------------------------------------------------------------------------------" >> ~/project_btas/Logs/$folder$log.txt


#Check pno present or not 

if [ $mylist -eq 0 ]
then
#pno not present
echo "Number of occurence of $pno  in  $myFile : 0 \t\t\t  NOT FOUND" >> $location/$folder$report.txt
echo " $myFile Analysis Closed $pno not found " >> ~/project_btas/Logs/$folder$log.txt
#Continue with next iteration

else

# Phone Number Found Analysis Logic 

#Getting Only Call End Parameter -  3rd Parameter
echo "File $myFile Analysis : ---------------------------------------------------------------------------------------------------" >> $location/$folder$report.txt
cnt=0

echo $mylines |  sed -n 1'p' | tr ',' '\n'| while read word; do

#Extract each word from mylines and calculate Length

len=`echo $word |awk '{print length}'`

if [ $len -eq 17 ]
then

#Check only for digits : 

case $word in 
[0-9]*)

#Increment Loop Parameter

cnt=`expr $cnt + 1`


if [ $cnt -eq 3 ] 
then

#This is Call End Parameter in format MMDDYYYYHHMMSSMMM
cnt=0

year=`echo $word | awk '{print substr($word,5,4)}'`
mon=`echo $word | awk '{print substr($word,1,2)}'`
day=`echo $word | awk '{print substr($word,3,2)}'`
t=`echo $word | awk '{print substr($word,9,9)}'`

#Changed Format to YYYYMMDDHHMMSSMMM for comparison

wordEg=$year$mon$day$t
echo "Call End Time Noted Format YYYYMMDDHHMMSSMMM   \t\t : $wordEg " >> ~/project_btas/Logs/$folder$log.txt

if [ $wordEg -le $end -a $wordEg -ge $start ]
then
echo "Yes This call ongoing  Call End Time : $wordEg" >> ~/project_btas/Logs/$folder$log.txt
echo "Call ONGOING : \n Call End Time in format YYYYMMDDHHMMSSMMM : $wordEg" >> $location/$folder$report.txt
#Extra Information Can be Added
else
echo "No This Call not ongoing : $wordEg" >> ~project_btas/Logs/$folder$log.txt
fi
fi
;;
esac
fi
done
fi
done
done
