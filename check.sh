Date1="Wed Oct 21 13:05:14 2012"
Date2="Wed Nov 21 12:55:30 2010"
Date3="Wed Nov 21 14:22:30 2012"

ts1=`date -d"${Date1}" +%Y%m%d%H%M%S`
ts2=`date -d"${Date2}" +%Y%m%d%H%M%S`
ts3=`date -d"${Date3}" +%Y%m%d%H%M%S`

latest=ts1

if [ $ts2 -gt $ts1 ]; then
    latest=ts2
fi

if [ $ts3 -gt $ts1 ]; then
    latest=ts3
fi

echo "Latest date is ${latest}"
