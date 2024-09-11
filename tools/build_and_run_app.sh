#!/bin/zsh
# $1: dev/stg/prod
# $2: build/run
# $3 (optional): apk/appbundle/ios/ipa
# $4 (optional): --export-options-plist=ios/exportOptions.plist
cmd="flutter $2 $3 $4 -t lib/main.dart --flavor $1 --dart-define-from-file=config/$1.json"
echo $cmd
eval $cmd
