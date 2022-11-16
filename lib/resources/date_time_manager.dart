import 'dart:developer';

extension DateTimeManager on DateTime {
  String get timeAgo {
    DateTime dateTime = this;
    log(dateTime.timeZoneName);
    log(dateTime.timeZoneOffset.inHours.toString());
    log(dateTime.timeZoneOffset.inMinutes.toString());
    log(dateTime.timeZoneOffset.inSeconds.toString());
    dateTime = DateTime(
      dateTime.year, 
      dateTime.month,
      dateTime.day,
      dateTime.hour+5,
      dateTime.minute+45,
       dateTime.second+45,
    );
    Duration duration = DateTime.now().difference(dateTime);

    if (duration.inSeconds < 5) {
      return 'Just now';
    } else if (duration.inSeconds <= 60) {
      return '${duration.inSeconds} seconds ago';
    } else if (duration.inMinutes <= 1) {
      return 'A minute ago';
    } else if (duration.inMinutes <= 60) {
      return '${duration.inMinutes} minutes ago';
    } else if (duration.inHours <= 1) {
      return 'An hour ago';
    } else if (duration.inHours <= 24) {
      return '${duration.inHours} hours ago';
    } else if (duration.inDays <= 1) {
      return 'Yesterday';
    } else if (duration.inDays <= 6) {
      return '${duration.inDays} days ago';
    } else if ((duration.inDays / 7).ceil() <= 1) {
      return 'Last Week';
    } else if ((duration.inDays / 7).ceil() <= 4) {
      return '${duration.inDays} weeks ago';
    } else if ((duration.inDays / 30).ceil() <= 1) {
      return 'Last Month';
    } else if ((duration.inDays / 30).ceil() <= 12) {
      return '${duration.inDays} months ago';
    } else if ((duration.inDays / 365).ceil() <= 1) {
      return 'Last year';
    }
    return '${(duration.inDays / 365).floor()} years ago';
  }
}
