import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> sendSms(String to, String message) async {
  final Telephony telephony = Telephony.instance;
  // ignore: unused_local_variable
  bool? permission = await telephony.requestSmsPermissions;
  await telephony.sendSms(
    to: to,
    message: message,
    statusListener: (SendStatus status) {
      Fluttertoast.showToast(msg: 'Message $status');
    },
  );
  Vibration.vibrate(duration: 500);
}

reciveSms(dynamic Function(SmsMessage) onNewMessage) {
  final Telephony telephony = Telephony.instance;
  telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        onNewMessage(message);
        Fluttertoast.showToast(msg: 'Sms Recived');
      },
      onBackgroundMessage: backgroundMessageHandler);
}

backgroundMessageHandler(SmsMessage message) {
  // Handle background message

  // Use plugins
  Vibration.vibrate(duration: 500);
}
