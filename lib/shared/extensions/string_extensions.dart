// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((String str) => str.toCapitalized())
      .join(' ');

  String removeLastCharacter() {
    if (length > 0) {
      return substring(0, length - 1);
    } else {
      return this;
    }
  }

  String removeFirstCharacter() {
    if (length > 0) {
      return substring(1);
    } else {
      return this;
    }
  }

  String separateIfUnderscored() {
    if (!contains('_')) {
      return this;
    } else {
      return split('_').join(' ');
    }
  }

  String toCurrencyFormat({String prefix = '', int decimalDigits = 2}) {
    try {
      return NumberFormat.simpleCurrency(
        name: prefix,
        decimalDigits: decimalDigits,
      ).format(double.parse(this));
    } catch (e) {
      return this;
    }
  }

  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }

  String get toDate {
    final DateTime date = DateTime.parse(this);
    final DateFormat newFormat = DateFormat('yMMMd');
    final String updatedDt = newFormat.format(date);
    return updatedDt;
  }

  String get toTime {
    final DateTime date = DateTime.parse(this);
    final DateFormat newFormat = DateFormat('jm');
    final String updatedDt = newFormat.format(date);
    return updatedDt;
  }

  String get parseToDate {
    try {
      return DateTime.parse(this)
          .toUtc()
          .toString()
          .replaceAll(RegExp('Z'), ' ');
    } catch (e) {
      return '** *** **';
    }
  }

  // bool isProfane(String text) {
  //   final String lowerCaseStringToTest = text.toLowerCase();
  //   return wordList
  //       .where((String word) => lowerCaseStringToTest.contains(word))
  //       .isNotEmpty;
  // }

  String bullet() {
    return '•   $this';
  }
}
