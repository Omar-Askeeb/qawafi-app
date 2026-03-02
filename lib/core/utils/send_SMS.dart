 import 'package:url_launcher/url_launcher.dart';

 void sendSMS(String message, String recipients) async {
    String _sms = 'sms:${recipients+","}?body=$message';
      await launchUrl(Uri.parse(_sms));
   
  }