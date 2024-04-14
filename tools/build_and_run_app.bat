@echo off
set "parent_path=%cd%"
set "root_project_path=%parent_path%\.."
set "env_path=%root_project_path%\config\"
set "app_path=%root_project_path%"

cd %env_path%
set dart_define=
for /f "tokens=1,* delims== " %%i in (./%1.env) do (
    call set "dart_define=%%dart_define%%--dart-define=%%i=%%j "
)

cd %app_path%
:: %1: dev
:: %2: build/run - shorebird
:: %3 (optional): apk/appbundle/ios/ipa - patch/preview/release
:: %4 (optional): --export-options-plist=ios/exportOptions.plist - android/ios
set cmd=flutter %2 %3 %4 -t lib\main.dart --flavor %1 %dart_define%
if %2%==shorebird (
    set cmd=shorebird %3 %4 -t lib\main.dart --flavor %1 '--' %dart_define%
)
echo %cmd%
%cmd%
 