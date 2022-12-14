import 'package:country/country.dart';
import 'package:intl/intl.dart';

class Utils {
  static String? birthDateValidator(String? value) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    String str1 = value ?? "";
    List<String> str2 = str1.split('/');
    String day = str2.isNotEmpty ? str2[0] : '';
    String month = str2.length > 1 ? str2[1] : '';
    String year = str2.length > 2 ? str2[2] : '';

    if (value != null) {
      if (value.isEmpty) {
        return 'BirthDate is Empty';
      } else if (day.isNotEmpty && int.parse(day) > 32) {
        return 'Day is invalid';
      } else if (month.isNotEmpty && int.parse(month) > 13) {
        return 'Month is invalid';
      } else if (year.isNotEmpty && (int.parse(year) > int.parse(formatted))) {
        return 'Year is invalid';
      } else if (year.isNotEmpty && (int.parse(year) < 1920)) {
        return 'Year is invalid';
      }
    }

    return null;
  }

  static Country? getCountryFromAlpha2(String alpha2) {
    for (var country in Countries.values) {
      if (country.alpha2 == alpha2) return country;
    }
  }
}

extension IsAtLeastYearsOld on DateTime {
  bool isAtLeastYearsOld(int years) {
    var now = DateTime.now();
    var boundaryDate = DateTime(now.year - years, now.month, now.day);

    // Discard the time from [this].
    var thisDate = DateTime(year, month, day);

    // Did [thisDate] occur on or before [boundaryDate]?
    return thisDate.compareTo(boundaryDate) <= 0;
  }
}
