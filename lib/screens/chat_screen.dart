import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/ChatMessage.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:ionicons/ionicons.dart';

class ChatScreen extends StatefulWidget {
  final String username;

  const ChatScreen({
    super.key,
    required this.username,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  String? inputText;

  @override
  void initState() {
    super.initState();

    textController.addListener(_getTextValue);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _getTextValue() {
    setState(() {
      inputText = textController.text.trim();
    });
  }

  void sendText() {
    print("ok");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: CommonAppBar(title: widget.username),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              reverse: true,
              children: const [
                ChatMessage(
                  selfSent: false,
                  message: "test message",
                  sentAt: "t",
                  hasRead: true,
                ),
                ChatMessage(
                  selfSent: true,
                  message: "1",
                  sentAt: "t",
                  hasRead: true,
                ),
                ChatMessage(
                  selfSent: true,
                  message: "1",
                  sentAt: "t",
                  hasRead: true,
                ),
                ChatMessage(
                  selfSent: true,
                  message: "1",
                  sentAt: "t",
                  hasRead: true,
                ),
                ChatMessage(
                  selfSent: false,
                  message: "1",
                  sentAt: "t",
                  hasRead: false,
                ),
                ChatMessage(
                  selfSent: false,
                  message:
                      "123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123",
                  sentAt: "t",
                  hasRead: false,
                ),
                ChatMessage(
                  selfSent: true,
                  message:
                      "123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123",
                  sentAt: "t",
                  hasRead: false,
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "여기에 메시지를 입력하세요.",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      onPressed:
                          (inputText?.isNotEmpty ?? false) ? sendText : null,
                      icon: const Icon(Ionicons.send_outline),
                    ),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
              ),
            ],
          )
        ],
      ),
      endDrawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 130,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text("메뉴"),
              ),
            ),
            ListTile(
              leading: const Icon(
                Ionicons.search_outline,
              ),
              title: const Text("검색"),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
