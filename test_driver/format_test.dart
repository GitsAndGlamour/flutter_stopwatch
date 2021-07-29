import 'dart:math';

import 'package:test/test.dart';
import '../lib/format.dart';

void main() {
  /* Formatting */
  test('whenFormattingANumberLessThan10_thenReturnNumberWithPrefixedZero', () {
    int value = 5;
    expect(format(value), equals('05'));
  });

  test('whenFormattingANumberMoreThan10_thenReturnNumberWithoutPrefixedZero', () {
    int value = 15;
    expect(format(value), equals('15'));
  });

  test('whenFormattingANumber10_thenReturnNumberWithoutPrefixedZero', () {
    int value = 10;
    expect(format(value), equals('10'));
  });

  test('whenFormattingADoubleLessThan10_thenReturnNumberWithPrefixedZero_AndPrecisionOfThree', () {
    double value = 5.2938;
    expect(format(value), equals('05.294'));
  });

  test('whenFormattingADoubleMoreThan10_thenReturnNumberWithoutPrefixedZero_AndPrecisionOfThree', () {
    double value = 15.2932;
    expect(format(value), equals('15.293'));
  });

  test('whenFormattingADoubleOf59.99951_thenReturnNumberWithoutPrefixedZero_AndWithPrecisionOfThree', () {
    double value = 59.99951;
    expect(format(value), equals('60.000'));
  });

  /* Seconds */

  test('whenGivenDurationOf150centiseconds_thenReturn1.5seconds_WithPrefixedZero_AndWIthPrecisionOfThree', () {
    int value = 150;
    expect(seconds(value), equals('01.500'));
  });

  test('whenGivenDurationOf200centiseconds_thenReturn2seconds_WithPrefixedZero_AndWIthPrecisionOfThree', () {
    int value = 200;
    expect(seconds(value), equals('02.000'));
  });

  test('whenGivenDurationOf6,000centiseconds_thenReturn0seconds_WithPrefixedZero_AndWIthPrecisionOfThree', () {
    int value = 6000;
    expect(seconds(value), equals('00.000'));
  });

  test('whenGivenDurationOf6,100centiseconds_thenReturn1second_WithPrefixedZero_AndWIthPrecisionOfThree', () {
    int value = 6100;
    expect(seconds(value), equals('01.000'));
  });

  test('whenGivenDurationOf1,100centiseconds_thenReturn11seconds_WithoutPrefixedZero_AndWIthPrecisionOfThree', () {
    int value = 1100;
    expect(seconds(value), equals('11.000'));
  });

  /* Minutes */

  test('whenGivenDurationOf150centiseconds_thenReturn0minutes_WithPrefixedZero', () {
    int value = 150;
    expect(minutes(value), equals('00'));
  });

  test('whenGivenDurationOf70,00centiseconds_thenReturn1minute_WithPrefixedZero', () {
    int value = 7000;
    expect(minutes(value), equals('01'));
  });

  test('whenGivenDurationOf13,000centiseconds_thenReturn2minutes_WithPrefixedZero', () {
    int value = 13000;
    expect(minutes(value), equals('02'));
  });

  test('whenGivenDurationOf78,000centiseconds_thenReturn13minutes_WithoutPrefixedZero', () {
    int value = 78000;
    expect(minutes(value), equals('13'));
  });

  test('whenGivenDurationOf360,0000centiseconds_thenReturn0minutes_WithPrefixedZero', () {
    int value = 360000;
    expect(minutes(value), equals('00'));
  });

  test('whenGivenDurationOf366,0000centiseconds_thenReturn1minute_WithPrefixedZero', () {
    int value = 366000;
    expect(minutes(value), equals('01'));
  });

  test('whenGivenDurationOf438,0000centiseconds_thenReturn13minutes_WithoutPrefixedZero', () {
    int value = 438000;
    expect(minutes(value), equals('13'));
  });

  /* Hours */

  test('whenGivenDurationOf100centiseconds_thenReturn0hours_WithPrefixedZero', () {
    int value = 100;
    expect(hours(value), equals('00'));
  });

  test('whenGivenDurationOf200,000centiseconds_thenReturn1hour_WithPrefixedZero', () {
    int value = 200000;
    expect(hours(value), equals('01'));
  });

  test('whenGivenDurationOf400,000centiseconds_thenReturn2hours_WithPrefixedZero', () {
    int value = 400000;
    expect(hours(value), equals('02'));
  });

  test('whenGivenDurationOf1,800,000centiseconds_thenReturn12hours_WithoutPrefixedZero', () {
    int value = 1800000;
    expect(hours(value), equals('12'));
  });

  test('whenGivenDurationOf18,000,000centiseconds_thenReturn125hours_WithoutPrefixedZero', () {
    int value = 18000000;
    expect(hours(value), equals('125'));
  });

  /* Elapsed Time */

  test('whenGivenDurationOf150centiseconds_thenReturn00:00:1.500', () {
    int value = 150;
    expect(elapsedTime(value), equals('00:00:01.500'));
  });

  test('whenGivenDurationOf1500centiseconds_thenReturn00:00:15.000', () {
    int value = 1500;
    expect(elapsedTime(value), equals('00:00:15.000'));
  });

  test('whenGivenDurationOf16265centiseconds_thenReturn00:02:42.650', () {
    int value = 16265;
    expect(elapsedTime(value), equals('00:02:42.650'));
  });

  test('whenGivenDurationOf162650centiseconds_thenReturn01:27:06.500', () {
    int value = 162650;
    expect(elapsedTime(value), equals('01:27:06.500'));
  });

  test('whenGivenDurationOf162650centiseconds_thenReturn11:31:05.000', () {
    int value = 1626500;
    expect(elapsedTime(value), equals('11:31:05.000'));
  });
}