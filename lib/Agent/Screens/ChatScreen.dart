import 'dart:convert';
import 'package:feedback_agent/Agent/Models/DataModel.dart';
import 'package:feedback_agent/Services/ApiService.dart';
import 'package:feedback_agent/Services/Bloc/ChatBloc.dart';
import 'package:feedback_agent/Services/Bloc/ChatEvent.dart';
import 'package:feedback_agent/Services/Bloc/ChatState.dart';
import 'package:feedback_agent/Widgets/ChatInputWidget.dart';
import 'package:feedback_agent/Widgets/ChatMessageWidget.dart';
import 'package:feedback_agent/Widgets/ChatWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String welcomeString =
      "Hi Welcome to CentraLogic Feedback Agent! Thank-you for your interest in CentraLogic!";
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChatBloc chatBloc = BlocProvider.of<ChatBloc>(context);
    return Scaffold(
        appBar: AppBar(
            title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to CentraLogic",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Hi Charles!",
              style: TextStyle(fontSize: 15),
            ),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0.5,
            )
          ],
        )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffE7E7E9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Color(0xffE7E7E9)),
                    ),
                    prefixIcon: Icon(
                      Icons.attachment,
                      color: Colors.black,
                    ),
                    hintText: "Type your message",
                  ),
                  // onChanged: (value) {
                  //   BlocProvider.of<ChatBloc>(context).add(
                  //       TextInputEvent(number: (textEditingController.text)));
                  // },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    chatBloc.add(SendMessageEvent(textEditingController.text));
                    textEditingController.clear();
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(0xff1B489B)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                    // maximumSize: MaterialStatePropertyAll(Size(10,10))
                  ),
                  child: const Text(
                    "Send",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 220, right: 220, bottom: 10),
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
                    child: const Text(
                      "Today",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocConsumer<ChatBloc, ChatState>(
                  bloc: chatBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ChatLoadedState) {
                      final chatMessages = state.chatBotList;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: chatMessages?.length,
                          itemBuilder: (context, index) {
                            final data = chatMessages?[index];
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          'assets/chatBot.png',
                                          height: 30,
                                          width: 30,
                                        )),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                            color: Color(0xffE9ECF4),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(8))),
                                        child: Text(
                                          data?.message ?? "",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w200),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // CircleAvatar(
                                    //     backgroundColor: Colors.white,
                                    //     child: Image.asset(
                                    //       'assets/chatBot.png',
                                    //       height: 30,
                                    //       width: 30,
                                    //     )),
                                    // const SizedBox(width: 8),
                                    Flexible(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                49,
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                            color: Color(0xffE9ECF4),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                            )),
                                        child: Text(
                                          data?.answer ?? "",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w200),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
