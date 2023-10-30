import 'package:flutter/material.dart';

@immutable
abstract class ChatEvent {
  const ChatEvent();
}

class ChatInitialEvent implements ChatEvent {
  const ChatInitialEvent();
}

class ChatCleanEvent implements ChatEvent {
  const ChatCleanEvent();
}

class ChatSendButtonEvent implements ChatEvent {
  final String content;
  const ChatSendButtonEvent({required this.content});
}

class ChatMoreDetailButton implements ChatEvent {
  final String content;
  const ChatMoreDetailButton({required this.content});
}

class CheckGrammarButton implements ChatEvent {
  final String content;
  const CheckGrammarButton({required this.content});
}

class AskFromMainPage implements ChatEvent {
  final String content;
  const AskFromMainPage({
    required this.content,
  });
}
