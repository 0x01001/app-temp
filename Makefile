ifeq ($(OS),Windows_NT)
    BUILD_CMD=.\tools\build_and_run_app.bat 
else
    BUILD_CMD=./tools/build_and_run_app.sh 
endif

TEST_DART_DEFINE_LIGHT_MODE_AND_JA=--dart-define=IS_DARK_MODE=false --dart-define=LOCALE=ja
TEST_DART_DEFINE_DARK_MODE_AND_EN=--dart-define=IS_DARK_MODE=true --dart-define=LOCALE=en

update_app_id:
	dart run rename setBundleId --targets ios,android --value "com.example.bundleId"

update_app_name:
	dart run rename setAppName --targets ios,android --value "YourAppName"

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
	flutter clean && rm -rf pubspec.lock

pod:
	cd ios && rm -rf Pods && rm -rf Podfile.lock && pod install --repo-update && cd ..

get:
	flutter pub get
 
gen_env:
	dart run tools/gen_env.dart
 
gen_lang:
	dart run intl_utils:generate

gen_asset:
	fluttergen -c pubspec.yaml

gen_route:
	dart run build_runner build --delete-conflicting-outputs --build-filter 'lib/app/navigation/routes/**'
	# dart run build_runner build --delete-conflicting-outputs --build-filter="lib/app/navigation/routes/app_router.dart"

gen_model:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/data/model/*.dart"

gen_app:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/app/*.dart"

gen:
	dart run build_runner clean
	dart run build_runner build --delete-conflicting-outputs --verbose
  
init:  
	make get
	make gen_env
	make gen_lang
	make gen
 	 
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

build_stg_bundle:
	$(BUILD_CMD) stg build appbundle

build_prod_bundle:
	$(BUILD_CMD) prod build appbundle

build_dev_ios:
	$(BUILD_CMD) dev build ios

build_stg_ios:
	$(BUILD_CMD) stg build ios

build_prod_ios:
	$(BUILD_CMD) prod build ios
 
build_dev_ipa:
	$(BUILD_CMD) dev build ipa --export-options-plist=ios/export_options_dev.plist

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

# It is used in CI/CD, so if you rename it, you need to update the CI/CD script
check_pubs:
	dart run tools/check_pubspecs.dart

custom_lint:
	dart run custom_lint

analyze:
	flutter analyze --no-pub --suppress-analytics

# dart_code_metrics:
# 	$(METRICS_CMD)

# It is used in CI/CD, so if you rename it, you need to update the CI/CD script
lint:
	make custom_lint
	make analyze
	# make dart_code_metrics

dart_fix:	
	dart fix --apply

cov_full:
	flutter test --coverage
	lcov --remove coverage/lcov.info \
	'*/*.g.dart' \
	'**/generated/*' \
	-o coverage/lcov.info &
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html

cov:
	flutter test --coverage
	lcov --remove coverage/lcov.info \
	'lib/main.dart' \
	'lib/app_initializer.dart' \
	'lib/app/my_app.dart' \
	'lib/app/index.dart' \
	'lib/app/utils/riverpod_logger.dart' \
	'lib/app/base/base_page.dart' \
	'lib/app/navigation' \
	'lib/app/components' \
	'lib/data/api/client/*_client.dart' \
	'lib/data/api/*_service.dart' \
	'lib/data/api/middleware/custom_log_interceptor.dart' \
	'lib/data/api/middleware/base_interceptor.dart' \
	'lib/data/api/exception_mapper/exception_mapper.dart' \
	'lib/data/database' \
	'lib/data/model/*_model.dart' \
	'lib/data/model/firebase' \
	'lib/data/mapper/base/base_data_mapper.dart' \
	'lib/shared/exception/app_exception.dart' \
	'lib/shared/exception/exception_handler.dart' \
	'lib/shared/helper' \
	'lib/shared/utils/log_utils.dart' \
	'lib/shared/utils/file_util.dart' \
	'lib/shared/extensions/ref_ext.dart' \
	'lib/shared/utils/view_util.dart' \
	'lib/shared/di/di.dart' \
	'lib/shared/di/di.config.dart' \
	'lib/resources' \
	'*/*.g.dart' \
	'**/generated/*' \
	-o coverage/lcov.info &
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html

t1_test:
	flutter drive \
	--driver=test/integration_test/test_driver/integration_driver.dart \
	--target test/integration_test/t1_login_failed.dart \
	--flavor dev --debug --dart-define-from-file=config/dev.json

# CI/CD
cd_dev:
	make cd_dev_android
	make cd_dev_ios 

cd_stg:
	make cd_stg_android
	make cd_stg_ios

cd_dev_android:
	cd android && fastlane increase_version_build_and_up_firebase_develop

cd_stg_android:
	cd android && fastlane increase_version_build_and_up_firebase_staging

cd_dev_ios:
	cd ios && fastlane increase_version_build_and_up_testflight_develop

cd_stg_ios:
	cd ios && fastlane increase_version_build_and_up_testflight_staging

fastlane_update_plugins:
	cd ios && bundle install && fastlane update_plugins
	cd android && bundle install && fastlane update_plugins

# gen certificates
cer: cer_dev cer_stg cer_prod

cer_dev:
	cd config && fastlane match development -a com.flutter.app.dev

cer_stg:
	cd config && fastlane match adhoc -a com.flutter.app.stg

cer_prod:
	cd config && fastlane match appstore -a com.flutter.app