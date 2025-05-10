import 'package:swift_aid/components/responsive_sized_box.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Swift Bot',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01),
        child: Column(
          children: [
            3.heightBox,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 220, 220),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: 5), // Adjust spacing
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                            hintText: "Write here ...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                3.widthBox,
                GestureDetector(
                  onTap: () {
                    //! Functionality Here ---->
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            1.heightBox
          ],
        ),
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
