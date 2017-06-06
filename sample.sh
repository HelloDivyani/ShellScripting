dbtimestamp=20120306142400
secondsDiff=$(( `date '+%Y%m%d%H%M%S'` - $dbtimestamp ))
if [ $secondsDiff -gt 600 ] 
then
#exit 1
echo $secondsDiff
echo "IN if cond"
else
#  exit 0
echo "IN else cond"
fi
