import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../shared/index.dart';

class AppUtils {
  const AppUtils._();

  bool useIsFocused(FocusNode node) {
    final isFocused = useState(node.hasFocus);

    useEffect(
      () {
        void listener() {
          isFocused.value = node.hasFocus;
        }

        node.addListener(listener);
        return () => node.removeListener(listener);
      },
      [node],
    );

    return isFocused.value;
  }

  void showLoading({bool? enableTimeout = true}) {
    EasyLoading.show();
    if (enableTimeout == true) Future.delayed(const Duration(milliseconds: Constant.loadingTimeout), hideLoading);
  }

  void hideLoading() {
    EasyLoading.dismiss();
  }

  void configLoading() {
    //https://github.com/nslogx/flutter_easyloading/issues/135
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 3000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35
      ..textColor = Colors.black
      // ..radius = 20
      ..backgroundColor = Colors.transparent
      ..maskColor = Colors.black54
      ..maskType = EasyLoadingMaskType.black
      ..indicatorColor = Colors.white
      // ..userInteractions = false
      // ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[] // important
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..lineWidth = 3.0;
  }

  static String randomName() {
    final _random = Random();

    const _names = [
      'Dog',
      'Cat',
      'Elephant',
      'Lion',
      'Tiger',
      'Giraffe',
      'Zebra',
      'Bear',
      'Monkey',
      'Horse',
      'Cow',
      'Sheep',
      'Goat',
      'Pig',
      'Rabbit',
      'Deer',
      'Fox',
      'Wolf',
      'Kangaroo',
      'Panda',
      'Dolphin',
      'Whale',
      'Shark',
      'Octopus',
      'Penguin',
      'Seal',
      'Otter',
      'Walrus',
      'Bat',
      'Squirrel',
      'Chipmunk',
      'Raccoon',
      'Beaver',
      'Koala',
      'Platypus',
      'Ostrich',
      'Emu',
      'Parrot',
      'Toucan',
      'Pelican',
      'Hummingbird',
      'Eagle',
      'Hawk',
      'Falcon',
      'Owl',
      'Sparrow',
      'Crow',
      'Swan',
      'Flamingo',
      'Heron',
      'Peacock',
      'Pigeon',
      'Seagull',
      'Albatross',
      'Cockatoo',
      'Macaw',
      'Cockroach',
      'Grasshopper',
      'Ant',
      'Bee',
      'Wasp',
      'Butterfly',
      'Moth',
      'Caterpillar',
      'Dragonfly',
      'Ladybird',
      'Beetle',
      'Scorpion',
      'Spider',
      'Tarantula',
      'Centipede',
      'Millipede',
      'Earthworm',
      'Slug',
      'Snail',
      'Jellyfish',
      'Starfish',
      'Crab',
      'Lobster',
      'Shrimp',
    ];

    return '${_names[_random.nextInt(_names.length)]}${_random.nextInt(100)}';
  }
}
