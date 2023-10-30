import 'dart:convert';

import 'package:dictionary_app_1110/data/dummy_chat_data.dart';
import 'package:http/http.dart' as http;

const chatApiKey = 'AIzaSyCrDJisRETl_ejeUyKNPqFtNWWnVF47i1o';
const urlChat =
    "https://generativelanguage.googleapis.com/v1beta3/models/text-bison-001:generateText?key=$chatApiKey";

Future<ChatMessage> getAnswer({required String content}) async {
  final uri = Uri.parse(urlChat);
  Map<String, dynamic> request = {
    "prompt": {"text": content}
  };

  final response = await http.post(uri, body: jsonEncode(request));

  try {
    final ans = json.decode(response.body)['candidates'][0]['output'];
    return ChatMessage(messageContent: ans, messageType: MessageType.receiver);
  } catch (e) {
    return ChatMessage(
        messageContent: 'Error. Please try again...',
        messageType: MessageType.receiver);
  }
}
