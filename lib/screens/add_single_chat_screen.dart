import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:flutter_chatapp/globals.dart';
import 'package:flutter_chatapp/screens/contactsList_screen.dart';

class AddSingleChat extends StatefulWidget {
  const AddSingleChat({
    super.key,
  });

  @override
  State<AddSingleChat> createState() => _AddSingleChatState();
}

class _AddSingleChatState extends State<AddSingleChat> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: "새 1:1 채팅",
      ),
      backgroundColor: globals_background_color,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ContactsList(
          showAddButton: false,
          showActions: false,
          newChat: true,
        ),
      ),
    );
  }
}
