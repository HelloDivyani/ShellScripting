
echo "CDR Analysis in  : "
#Time Format MMDDYYYYHHMMSSMMM
#Caller Tel Phone : sip:+ 12 digits phone number
# Enter Duration of time you want to find Calls ongoing
# Ongoing Calls 
# End Time between given duration That means it is ongoing


echo "Enter the Caller phone number : \c"
read pno
#echo "Enter Start time in format MMDDYYYYHHMMSSMMM : \c"
#read start
#echo "Enter End time in format MMDDYYYYHHMMSSMMM : \c"
#read end


mylist=`grep -n -c sip:+$pno  first.csv`
echo $mylist
echo "Total Number of Lines Phone found : $mylist"
mylines=`grep -n sip:+$pno first.csv`
echo "Lines Containing the phone number :\n $mylines"
echo "--------------------------------------------------------------------------------------"
echo "Set Duration : "
#echo "Enter Start Date : in format YYYY-MM-DD"
#read startDate
#echo "Enter Start Time : HH:MM:SS"
#read startTime
#echo "Enter End Date : in format YYYY-MM-DD"
#read endDate
#echo "Enter End Time : HH:MM:SS"
#read endTime
#Extract call End Time from mylines the end date 
#out=awk 'length($1) > 18' $mylines
#echo $out
echo "Enter Start Date in Format YYYYMMDDHHMMSSMMM : \c"
read start
echo "Enter End Date in format YYYYMMDDHHMMSSMMM : \c"
read end
cnt=0
echo $mylines |  sed -n 1'p' | tr ',' '\n'| while read word; do
#len=`expr length $word`
len=`echo $word |awk '{print length}'`
if [ $len -eq 17 ]
then
case $word in 
[0-9]*)
cnt=`expr $cnt + 1`
#Comparison Logic
#extract end date 3rd parameter
if [ $cnt -eq 3 ] 
then
echo $word
cnt=0
year=`echo $word | awk '{print substr($word,5,4)}'`
mon=`echo $word | awk '{print substr($word,1,2)}'`
day=`echo $word | awk '{print substr($word,3,2)}'`
t=`echo $word | awk '{print substr($word,9,9)}'`
#hour=`echo $word | awk '{print substr($word,9,2)}'`
#min=`echo $word | awk '{print substr($word,11,2)}'`
#sec=`echo $word | awk '{print substr($word,13,2)}'`
#millsec=`echo $word | awk '{print substr($word,15,3)}'`
wordEg=$year$mon$day$t
#if [ $mon=01 -o $mon=03 -o $mon=05 -o $mon=07 -o $mon=09 -o $mon=11 ]
#then
#days=31
#elif [ $mon=02 ]
#then
#ch=`expr $year % 4`
#if [ $ch -eq 0 ]
#then
#days=29
#else
#days=28
#fi
#else
#days=30
#fi
#echo "Calculations"
startEg="01012015000000000"
endEg="12312016000000000"
#curr=`date +"%M%D%Y%H%M%S%MM"
#var=$(date +%x_%H:%M:%S:%N | sed 's/\(:[0-9][0-9]\)[0-9]*$/\1/')
#compare whether word lies in the duration
#Date sec convert real arithmetic compare
#Date1="Wed Oct 21 13:05:14 2012"
#ts1=`date -d"${Date1}" +%m%d%Y%H%M%S%3N`
if [ $wordEg -le $end -a $wordEg -ge $start ]
then
echo "Yes This call ongoing : $word"
fi
fi
;;
esac
fi
done
#IFS=","
#while read word
#do
#echo $word
#done
