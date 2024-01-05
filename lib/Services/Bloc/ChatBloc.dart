import 'dart:async';
import 'dart:convert';
import 'package:feedback_agent/Agent/Models/DataModel.dart';
import 'package:feedback_agent/Widgets/ChatWidget.dart';
import 'package:http/http.dart' as http;

import 'package:feedback_agent/Services/ApiService.dart';
import 'package:feedback_agent/Services/Bloc/ChatEvent.dart';
import 'package:bloc/bloc.dart';
import 'package:feedback_agent/Services/Bloc/ChatState.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<DataModel> data = [];
  int step = 0;

  ChatBloc() : super(ChatBotInitialState()) {
    on<ChatBotInitialEvent>(chatBotInitialEvent);
    on<SendMessageEvent>(sendMessageEvent);
    add(ChatBotInitialEvent());

    on<TextInputEvent>((event, emit) {
      if (event.runtimeType is String) {
        emit(ChatErrorState("Enter valid input"));
      } else {
        emit(ValidState());
      }
    });
  }

  Future<void> chatBotInitialEvent(
      ChatBotInitialEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      var response = await ApiService().fetchData(step);
      DataModel? chatBot = DataModel.fromJson(response);
      data.add(chatBot);
      emit(ChatLoadedState(data));
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessageEvent(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    data?[step].answer = event.message;
    step++;
    add(ChatBotInitialEvent());
  }
}
