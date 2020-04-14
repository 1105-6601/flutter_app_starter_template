import 'dart:math';

import 'package:faker/faker.dart';

class MockUtil
{
  static bool select({double threshold: 0.5})
  {
    return Random().nextDouble() > threshold;
  }

  static int randomInt(int max, {int min: 0, int ignoreNum})
  {
    int num = Faker().randomGenerator.integer(max, min: min);

    if (ignoreNum == null) {
      return num;
    }

    if (num == ignoreNum) {
      return randomInt(max, min: min, ignoreNum: ignoreNum);
    }

    return num;
  }
}