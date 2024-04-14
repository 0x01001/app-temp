ifeq ($(OS),Windows_NT)
    BUILD_CMD=.\build_and_run_app.bat 
else
    BUILD_CMD=./build_and_run_app.sh 
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
	cd tools && $(BUILD_CMD) dev run 

run_qa:
	cd tools && $(BUILD_CMD) qa run

run_stg:
	cd tools && $(BUILD_CMD) stg run
	
run_prod:
	cd tools && $(BUILD_CMD) prod run

build_dev_apk:
	cd tools && $(BUILD_CMD) dev build apk

build_qa_apk:
	cd tools && $(BUILD_CMD) qa build apk

build_stg_apk:
	cd tools && $(BUILD_CMD) stg build apk

build_prod_apk:
	cd tools && $(BUILD_CMD) prod build apk

build_dev_bundle:
	cd tools && $(BUILD_CMD) dev build appbundle

build_qa_bundle:
	cd tools && $(BUILD_CMD) qa build appbundle

build_stg_bundle:
	cd tools && $(BUILD_CMD) stg build appbundle

build_prod_bundle:
	cd tools && $(BUILD_CMD) prod build appbundle

build_dev_ios:
	cd tools && $(BUILD_CMD) dev build ios

build_qa_ios:
	cd tools && $(BUILD_CMD) qa build ios

build_stg_ios:
	cd tools && $(BUILD_CMD) stg build ios

build_prod_ios:
	cd tools && $(BUILD_CMD) prod build ios

build_dev_ipa:
	cd tools && $(BUILD_CMD) dev build ipa --export-options-plist=ios/exportOptions.plist

build_qa_ipa:
	cd tools && $(BUILD_CMD) qa build ipa --export-options-plist=ios/exportOptions.plist

build_stg_ipa:
	cd tools && $(BUILD_CMD) stg build ipa --export-options-plist=ios/exportOptions.plist

build_prod_ipa:
	cd tools && $(BUILD_CMD) prod build ipa --export-options-plist=ios/exportOptions.plist

build_shorebird_dev_android:
	cd tools && $(BUILD_CMD) dev shorebird release android

patch_shorebird_dev_android:
	cd tools && $(BUILD_CMD) dev shorebird patch android

dart_fix:	
	dart fix --apply
