import 'package:flutter/material.dart';
import 'package:flutter_chatapp/screens/chat_screen.dart';
import 'package:flutter_chatapp/screens/contacts_screen.dart';
import 'package:flutter_chatapp/screens/myaccount_screen.dart';
import 'package:ionicons/ionicons.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _index = 0;
  static const title = ["Chats", "Contacts", "My Account"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
        appBar: AppBar(
          title: Text(
            title[_index],
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: null,
          centerTitle: false,
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                IndexedStack(
                  index: _index,
                  children: const [Chat(), Contacts(), MyAccount()],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            currentIndex: _index,
            onTap: (value) {
              setState(() {
                _index = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.chatbubble_outline), label: "채팅"),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.people_circle_outline), label: "연락처"),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.person_circle_outline),
                label: "내 계정",
              )
            ],
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.purple.shade300,
            selectedFontSize: 14,
          ),
        ),
      ),
    );
  }
}
