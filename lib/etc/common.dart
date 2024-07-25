import 'package:intl/intl.dart';

class Common {
  static String formatDateTime(DateTime dateTime) {
    // String daySuffix(int day) {
    //   if (day >= 11 && day <= 13) {
    //     return 'th';
    //   }
    //   switch (day % 10) {
    //     case 1:
    //       return 'st';
    //     case 2:
    //       return 'nd';
    //     case 3:
    //       return 'rd';
    //     default:
    //       return 'th';
    //   }
    // }

    final dayFormat = DateFormat('d');
    final monthFormat = DateFormat('MMM');
    final yearFormat = DateFormat('yyyy');
    final timeFormat = DateFormat('hh:mm a');

    String day = dayFormat.format(dateTime);
    // String suffix = daySuffix(dateTime.day);
    String month = monthFormat.format(dateTime);
    String year = yearFormat.format(dateTime);
    String time = timeFormat.format(dateTime);

    return '$day $month $year, $time';
  }

  static String formatDouble(double value, {int fixedDecimalPlaces = 1}) {
    String str = value.toStringAsFixed(1);

    str = str.replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');

    return str;
  }

  static String scoringLabel(double score) {
    String ratingLabel;
    if (score < 3) {
      ratingLabel = "Very Bad";
    } else if (score < 5) {
      ratingLabel = "Bad";
    } else if (score < 8) {
      ratingLabel = "Good";
    } else if (score > 8) {
      ratingLabel = "Very Good";
    } else {
      ratingLabel = "?";
    }

    return ratingLabel;
  }

  static String timeFormat(int number) {
    if (number < 10) {
      return '0$number';
    } else {
      return '$number';
    }
  }

  static bool isDateSame(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}
