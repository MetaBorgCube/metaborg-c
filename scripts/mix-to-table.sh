#!/bin/bash

if [ $# == 2 ] ;
then
  PROJECT_PATH=$1
  MIX_FILE=$2
else
  echo "usage [project path] [mix file]"
  exit 1
fi


pack-sdf -i $PROJECT_PATH/syntax/$MIX_FILE.sdf -o $MIX_FILE.def -Idef $PROJECT_PATH/lib/StrategoMix.def --Include $PROJECT_PATH/src-gen/syntax
sdf2table -t -i $MIX_FILE.def -m $MIX_FILE -o $MIX_FILE.tbl
# echo $PROJECT_PATH
# echo $MIX_FILE


#pack-sdf -i syntax/js/StrategoJS.sdf -o lib/StrategoJS.def -Idef lib/StrategoMix.def --Include src-gen/syntax
#sdf2table -t -i lib/StrategoJS.def -m js/StrategoJS -o lib/StrategoJS.tbl
