import 'package:dio/dio.dart';
import 'package:feedback_agent/Services/Bloc/ChatEvent.dart';
import 'package:feedback_agent/Services/Bloc/ChatState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Dio dio = Dio();
  List<String> _messages = [];

  ChatBloc(super.initialState);

  ChatState get initialState => ChatInitialState();

  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is SendMessageEvent) {
      yield ChatLoadingState();

      try {
        Response response = await dio.post(
          "https://sapdos-api.azurewebsites.net/api/Credentials/FeedbackJoiningBot",
          data: {"step": "0"},
        );

        String botReply = response.data["message"];
        _messages.insert(0, "Bot: $botReply");

        int currentStep = int.parse(response.data["step"]);
        if (currentStep < 5) {
          _messages.insert(
            0,
            "Bot: What's your answer for step ${currentStep + 1}?",
          );
        } else {
          _messages.insert(0, "Bot: Interaction complete. Thank you!");
        }

        yield ChatLoadedState(List.from(_messages));
      } catch (e) {
        yield ChatErrorState("Sorry, something went wrong.");
      }
    }
  }
}