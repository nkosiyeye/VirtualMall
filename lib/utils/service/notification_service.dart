import 'dart:convert';
import 'package:flutter_store/utils/service/get_service_key.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  GetServiceKey getServiceKey = GetServiceKey();
  static const String _fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  static const String _serverKey = 'YOUR_SERVER_KEY'; // Replace with your FCM server key

  Future<void> sendPushNotification({
    required String targetToken,
    required String title,
    required String body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_fcmUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=${await getServiceKey.getServiceKey()}',
        },
        body: jsonEncode({
          'to': targetToken,
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}