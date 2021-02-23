import 'package:age/age.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DateHelper {
  final day = DateTime.now().day;

  String getTodayDate() {
    var ret = '${dayOfTheWeek()}, ${monthOfTheYear()} ${DateTime.now().day}';
    return ret;
  }

  String dayOfTheWeek() {
    switch (DateTime.now().weekday) {
      case 1:
        return 'Monday';
        break;
      case 2:
        return 'Tuesday';
        break;
      case 3:
        return 'Wednesday';
        break;
      case 4:
        return 'Thursday';
        break;
      case 5:
        return 'Friday';
        break;
      case 6:
        return 'Saturday';
        break;
      case 7:
        return 'Sunday';
        break;
      default:
        return 'Unable to return day of the week';
    }
  }

  String monthOfTheYear() {
    switch (DateTime.now().month) {
      case 1:
        return 'January';
        break;
      case 2:
        return 'February';
        break;
      case 3:
        return 'March';
        break;
      case 4:
        return 'April';
        break;
      case 5:
        return 'May';
        break;
      case 6:
        return 'June';
        break;
      case 7:
        return 'July';
        break;
      case 8:
        return 'August';
        break;
      case 9:
        return 'September';
        break;
      case 10:
        return 'October';
        break;
      case 11:
        return 'November';
        break;
      case 12:
        return 'December';
        break;
      default:
        return 'Unable to return month of the year';
    }
  }

  String getAge(Timestamp ts) {
    var birthDate = ts.toDate();
    var today = DateTime.now();

    AgeDuration age;

    // Find out your age
    age = Age.dateDifference(
        fromDate: birthDate, toDate: today, includeToDate: false);
    return age.years.toString();
  }
}
