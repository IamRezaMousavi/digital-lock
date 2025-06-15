import 'package:another_telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> sendSms(String to, String message) async {
  final telephony = Telephony.instance;
  // ignore: unused_local_variable
  final permission = await telephony.requestSmsPermissions;
  await telephony.sendSms(
    to: to,
    message: message,
    statusListener: (SendStatus status) async {
      await Fluttertoast.showToast(msg: 'Message $status');
    },
  );
  await Vibration.vibrate(duration: 500);
}

void reciveSms(Function(SmsMessage) onNewMessage) {
  Telephony.instance.listenIncomingSms(
    onNewMessage: (SmsMessage message) async {
      onNewMessage(message);
      await Fluttertoast.showToast(msg: 'Sms Recived');
    },
    onBackgroundMessage: backgroundMessageHandler,
  );
}

Future<void> backgroundMessageHandler(SmsMessage message) async {
  // Handle background message

  // Use plugins
  await Vibration.vibrate(duration: 500);
}
