import 'package:flutter/material.dart';
import 'package:cpn_us/dependency_injection.dart' as di;
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("f4ba2ba0-0208-40df-8284-47dec3c135e3");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]);
  await di.init();
  runApp(MyApp());
}