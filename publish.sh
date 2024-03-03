pushd your_extension_web_app

flutter pub get
dart run devtools_extensions build_and_copy --source=. --dest=../keyframe/extension/devtools

popd

pushd your_pub_package
flutter pub publish
popd