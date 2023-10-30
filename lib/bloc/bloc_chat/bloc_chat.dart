import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_states.dart';
import 'package:dictionary_app_1110/bloc/data_in_cubit.dart';
import 'package:dictionary_app_1110/data/dummy_chat_data.dart';
import 'package:dictionary_app_1110/repositories/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  bool isLoading = false;
  late MessageCubit messageCubit;
  ChatBloc() : super(const ChatInitialState()) {
    on<ChatInitialEvent>(chatInitialEvent);
    on<ChatSendButtonEvent>(chatSendButtonEvent);
    on<ChatCleanEvent>(chatCleanEvent);
  }

  FutureOr<void> chatInitialEvent(
      ChatInitialEvent event, Emitter<ChatState> emit) {
    messageCubit = MessageCubit();
    emit(ChatLoaddedState(chatMessages: messageCubit.state));
  }

  FutureOr<void> chatSendButtonEvent(
      ChatSendButtonEvent event, Emitter<ChatState> emit) async {
    final sender = ChatMessage(
        messageContent: event.content, messageType: MessageType.sender);
    messageCubit.add(message: sender);
    emit(ChatLoaddedState(chatMessages: messageCubit.state));
    isLoading = true;
    final receiverMessage = await getAnswer(content: event.content);
    messageCubit.add(message: receiverMessage);
    emit(ChatLoaddedState(chatMessages: messageCubit.state));
    isLoading = false;
    emit(const MessageLoadded());
  }

  FutureOr<void> chatCleanEvent(ChatCleanEvent event, Emitter<ChatState> emit) {
    messageCubit.reset();
    emit(ChatLoaddedState(chatMessages: messageCubit.state));
  }
}
