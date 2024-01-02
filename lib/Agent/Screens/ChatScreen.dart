import 'dart:convert';
import 'package:feedback_agent/Agent/Models/DataModel.dart';
import 'package:feedback_agent/Services/Bloc/ChatBloc.dart';
import 'package:feedback_agent/Services/Bloc/ChatState.dart';
import 'package:feedback_agent/Widgets/ChatInputWidget.dart';
import 'package:feedback_agent/Widgets/ChatMessageWidget.dart';
import 'package:feedback_agent/Widgets/ChatWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String welcomeString="Hi Welcome to CentraLogic Feedback Agent! Thank-you for your interest in CentraLogic!";
  final TextEditingController _textEditingController =TextEditingController();
  List<ChatMessage> chatMessages=[];
  int step=0;
  String _type="";
  String _message="";
  late DataModel dataModel;
  late String conversationDate;

  @override
  void initState() {
    DataModel dataModel=DataModel(type: _type, message: _message);
    super.initState();
    // Add initial greeting message from the bot
    _addBotMessage(welcomeString);
    _getInitialBotMessage();
    // conversationDate=_getFormattedDate(DateTime.now());
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  String _getFormattedDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _getInitialBotMessage() async{
    var url = Uri.parse(
        "https://sapdos-api-v2.azurewebsites.net/api/Credentials/FeedbackJoiningBot");

    var requestBody=jsonEncode({"step":step});

    try{
      var response = await http.post(
        url,
        body: requestBody,
        headers: {
          "Content-Type":"application/json"
        },
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          String prompt= responseData["type"];
          String initialMsg= responseData["message"];
          _addBotMessage(initialMsg);
        });
      } else {
        throw Exception("Failed to load data");
      }
    }catch(e){
      print(e);
    }
  }

  void _sendMessage(String userMessage,int step) async {

    var url = Uri.parse(
        "https://sapdos-api-v2.azurewebsites.net/api/Credentials/FeedbackJoiningBot");

    var requestBody=jsonEncode({"step":step+1});

    try{
      var response = await http.post(
        url,
        body: requestBody,
        headers: {
          "Content-Type":"application/json"
        },
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          _type= responseData["type"];
          _message = responseData["message"];
        });
        // print(_message);
        // print(_type);
      } else {
        throw Exception("Failed to load data");
      }
    }catch(e){
      print(e);
    }

    setState(() {
      _addUserMessage(userMessage);
      if(step<=3){
        _addBotMessage(_message);
      }
      else{
        _addBotMessage("Thank You for your responses");
      }
    });
    _textEditingController.clear();
  }

  void _addBotMessage(String message) {
    setState(() {
      chatMessages.add(ChatMessage(message, MessageType.bot));
    });
  }

  void _addUserMessage(String userMessage){
    setState(() {
      chatMessages.add(ChatMessage(userMessage, MessageType.user));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to CentraLogic",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 8,),
              Text("Hi Charles!",style: TextStyle(fontSize: 15),),
              Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.5,
              )
            ],
          )
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 220,right: 220,bottom: 10),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 65,
                            child: Image.asset('assets/chatBot.png'),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            "CentraLogic Bot",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            "Hi! I am CentraLogic Bot, your onboarding agent",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 45,
                    height: 22,
                    decoration: BoxDecoration(
                      color: const Color(0xffE9ECF4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text("Today",style: TextStyle(fontSize: 15),),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) {
                      return ChatWidget(message: chatMessages[index]);
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffE7E7E9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Color(0xffE7E7E9)),
                          ),
                          prefixIcon: Icon(
                            Icons.insert_link_outlined,
                            color: Colors.black,
                          ),
                          hintText: "Type your message",

                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          String userMessage = _textEditingController.text.trim();
                          if (userMessage.isNotEmpty) {
                            _sendMessage(userMessage,step);
                            setState(() {
                              step++;
                            });
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor:  MaterialStatePropertyAll<Color>(Color(0xff1B489B)),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          )),
                          // maximumSize: MaterialStatePropertyAll(Size(10,10))
                        ),
                        child: const Text("Send",style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

}

// class ChatScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ChatBot App'),
//       ),
//       body: BlocBuilder<ChatBloc, ChatState>(
//         builder: (context, state) {
//           if (state is ChatInitialState) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is ChatLoadedState) {
//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     reverse: true,
//                     itemCount: state.messages.length,
//                     itemBuilder: (context, index) {
//                       final message = state.messages[index];
//                       return ChatMessageWidget(message: message);
//                     },
//                   ),
//                 ),
//                 ChatInputWidget(),
//               ],
//             );
//           } else {
//             return Center(
//               child: Text('Error loading chat'),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
