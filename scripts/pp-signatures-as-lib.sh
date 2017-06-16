#!/bin/bash

libfolder="lib"

if [ $# == 2 ] ;
then
  PROJECT_PATH=$1
  MIX_FILE=$2
else
  echo "usage [project path] [mix file]"
  exit 1
fi


./mix-to-table.sh $1 $2

#copy signatures and pretty printer
for file in $(find $PROJECT_PATH/src-gen/signatures $PROJECT_PATH/src-gen/pp -name *.str)
do
  stripped=$(echo $file | sed -e "s/\/js//")
  outfile="$libfolder/$(dirname $stripped | xargs basename)/$(basename $stripped)"
  echo $outfile
  mkdir -p $(dirname $outfile)
  sed -e "s/\(pp\|signatures\)\(\/js\)\?[^-]/js\/\1\//" $file | tee $outfile
done

#copy util file
cp $PROJECT_PATH/trans/js-util.str $libfolder/
