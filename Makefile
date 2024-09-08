ifeq ($(OS),Windows_NT)
    BUILD_CMD=.\tools\build_and_run_app.bat 
else
    BUILD_CMD=./tools/build_and_run_app.sh 
endif

update_app_icon:
	dart run flutter_launcher_icons -f config/app-icon.yaml 

update_splash:
	dart run flutter_native_splash:create --path=config/splash.yaml

remove_splash:
	dart run flutter_native_splash:remove --path=config/splash.yaml
 
test: 
	flutter test

upgrade: 
	flutter pub upgrade

patch_version:
	cider bump patch --keep-build
 
clean:
	flutter clean 

get:
	flutter pub get
 
gen_env:
	dart run tools/gen_env.dart
 
gen_lang:
	dart run intl_utils:generate

gen_model:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/data/repository/model/*.dart"
gen_entity:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/domain/entity/*.dart"	
gen_di:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/app/di/*.dart"	
gen_data:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/data/*.dart"		
gen_domain:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/domain/*.dart"		
gen_shared:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/shared/*.dart"	
gen_app:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/app/*.dart"			
gen_all:
	dart run build_runner build --delete-conflicting-outputs
  
gen:
	dart run tools/gen_env.dart
	dart run intl_utils:generate
	dart run build_runner build --delete-conflicting-outputs
 	 
run_dev:
	$(BUILD_CMD) dev run 
 
run_stg:
	$(BUILD_CMD) stg run
	
run_prod:
	$(BUILD_CMD) prod run

build_dev_apk:
	$(BUILD_CMD) dev build apk
 
build_stg_apk:
	$(BUILD_CMD) stg build apk

build_prod_apk:
	$(BUILD_CMD) prod build apk

build_dev_bundle:
	$(BUILD_CMD) dev build appbundle

build_qa_bundle:
	$(BUILD_CMD) qa build appbundle

build_stg_bundle:
	$(BUILD_CMD) stg build appbundle

build_prod_bundle:
	$(BUILD_CMD) prod build appbundle

build_dev_ios:
	$(BUILD_CMD) dev build ios

build_qa_ios:
	$(BUILD_CMD) qa build ios

build_stg_ios:
	$(BUILD_CMD) stg build ios

build_prod_ios:
	$(BUILD_CMD) prod build ios

build_dev_ipa:
	$(BUILD_CMD) dev build ipa --export-options-plist=ios/export_options_dev.plist

build_qa_ipa:
	$(BUILD_CMD) qa build ipa --export-options-plist=ios/export_options_dev.plist

build_stg_ipa:
	$(BUILD_CMD) stg build ipa --export-options-plist=ios/export_options_pro.plist

build_prod_ipa:
	$(BUILD_CMD) prod build ipa --export-options-plist=ios/export_options_pro.plist

# not working using "shorebird release android..." instead of "make build_shorebird_dev_android"
build_shorebird_dev_android:
	$(BUILD_CMD) dev shorebird release android
 
patch_shorebird_dev_android:
	$(BUILD_CMD) dev shorebird patch android

build_shorebird_prod_android:
	$(BUILD_CMD) prod shorebird release android
 
patch_shorebird_prod_android:
	$(BUILD_CMD) prod shorebird patch android

dart_fix:	
	dart fix --apply
