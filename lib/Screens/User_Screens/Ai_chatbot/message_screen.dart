import 'package:swift_aid/components/responsive_sized_box.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:developer' show log;
import 'dart:convert';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendMessage(String text) async {
    log("sendMessage called with text: $text");
    if (text.trim().isEmpty) {
      log("Text is empty, returning");
      return;
    }

    setState(() {
      messages.add({"text": text, "isMe": true});
      _controller.clear();
      isTyping = true;
    });
    log("User message added to list");

    await Future.delayed(const Duration(milliseconds: 100));
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    log("Scrolled to bottom after sending message");

    final payload = {
      "message": text,
      "chat_history": messages
          .map((m) =>
              {"content": m["text"], "role": m["isMe"] ? 'user' : 'assistant'})
          .toList(),
    };
    log("Sending payload: ${jsonEncode(payload)}");

    try {
      final response = await http.post(
        Uri.parse('http://192.168.10.4:3000/api/ai/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      log("API response received with status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          messages.add({"text": data['response'] ?? "No reply", "isMe": false});
          isTyping = false;
        });

        await Future.delayed(const Duration(milliseconds: 100));
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } else {
        log('Server error: ${response.statusCode} - ${response.body}');
        setState(() {
          isTyping = false;
        });
      }
    } catch (e) {
      log('API error occurred: $e');
      setState(() {
        isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swift Bot',
            style: TextStyle(color: AppColors.whiteColor)),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01),
        child: Column(
          children: [
            3.heightBox,
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(10),
                itemCount: messages.isEmpty ? 1 : messages.length,
                itemBuilder: (context, index) {
                  if (messages.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        const SizedBox(
                            height: 100,
                            child: Image(
                                image: AssetImage(
                              'assets/images/bot.png',
                            ))),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        const Text(
                          '👋 Start chatting with Swift Bot!',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Chats(
                      message: messages[index]["text"],
                      isMe: messages[index]["isMe"],
                    );
                  }
                },
              ),
            ),
            if (isTyping)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    SpinKitThreeBounce(
                      color: AppColors.primaryColor,
                      size: 20.0,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'AI is typing...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                3.widthBox,
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.7),
                        AppColors.primaryColor
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.edit, color: Colors.white),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            hintText: "Write here ...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                          style: const TextStyle(color: Colors.white),
                          onSubmitted: (value) {
                            log("User submitted: $value");
                            sendMessage(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                3.widthBox,
                GestureDetector(
                  onTap: () {
                    sendMessage(_controller.text);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.primaryColor
              : const Color.fromARGB(255, 221, 220, 220),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}


//!