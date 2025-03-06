import 'package:flutter/material.dart';
import 'package:swift_aid/Screens/Main_Screens/main_home.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:swift_aid/components/responsive_sized_box.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Map<String, dynamic>> messages = [
    {"text": "Rorem ipsum dolor sit adipiscing elit.", "isMe": false},
    {"text": "Rorem ipsum dolor sit adipiscing elit.", "isMe": true},
    {"text": "Rorem ipsum dolor sit adipiscing elit.", "isMe": false},
    {"text": "Rorem ipsum dolor sit adipiscing elit.", "isMe": true},
    {"text": "Rorem adipiscing elit.", "isMe": true},
    {"text": "Rorem ipsum dolor sit adipiscing elit.", "isMe": false},
    {"text": "Rorem ipsum dolor sit adipiscing elit.", "isMe": true},
    {"text": "Rorem ipsum dolor sit adipiscing elit.", "isMe": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      child: Column(
        children: [
          7.heightBox,
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainHome()),
                      (route) => false);
                },
              ),
              20.widthBox,
              const Text("SwiftBot",
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  )),
              const Spacer()
            ],
          ),
          4.heightBox,
          Expanded(
              child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Chats(
                message: messages[index]["text"],
                isMe: messages[index]["isMe"],
              );
            },
          )),
          Row(
            children: [
              3.widthBox,
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.75,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 221, 220, 220),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Color.fromARGB(255, 138, 138, 138),
                    ),
                    2.widthBox,
                    const Text("Write Here",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              3.widthBox,
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              )
            ],
          ),
          1.heightBox
        ],
      ),
    );
  }
}

class Chats extends StatelessWidget {
  final String message;
  final bool isMe;

  const Chats({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.primaryColor
              : const Color.fromARGB(255, 221, 220, 220),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
