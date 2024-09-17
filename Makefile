ifeq ($(OS),Windows_NT)
    BUILD_CMD=.\tools\build_and_run_app.bat 
else
    BUILD_CMD=./tools/build_and_run_app.sh 
endif

TEST_DART_DEFINE_LIGHT_MODE_AND_JA=--dart-define=IS_DARK_MODE=false --dart-define=LOCALE=ja
TEST_DART_DEFINE_DARK_MODE_AND_EN=--dart-define=IS_DARK_MODE=true --dart-define=LOCALE=en

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

pod:
	cd ios && pod install && cd ..

get:
	flutter pub get
 
gen_env:
	dart run tools/gen_env.dart
 
gen_lang:
	dart run intl_utils:generate

gen_model:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/data/repository/model/*.dart"
gen_app:
	dart run build_runner build --delete-conflicting-outputs --build-filter="./lib/app/*.dart"			
gen_all:
	dart run build_runner clean
	dart run build_runner build --delete-conflicting-outputs --verbose
  
gen:
	dart run tools/gen_env.dart
	dart run intl_utils:generate
	dart run build_runner build --delete-conflicting-outputs --verbose
 	 
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
