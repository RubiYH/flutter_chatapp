import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatapp/screens/chatsList_screen.dart';
import 'package:flutter_chatapp/screens/contactsList_screen.dart';
import 'package:flutter_chatapp/screens/myaccount_screen.dart';
import 'package:ionicons/ionicons.dart';

void main() {
  runApp(const App(
    index: 0,
  ));
}

class App extends StatefulWidget {
  final int index;

  const App({super.key, this.index = 0});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _index = 0;
  static const title = ["채팅", "연락처", "내 계정"];

  @override
  void initState() {
    super.initState();
    _index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
          ),
          title: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                title[_index],
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: null,
          centerTitle: false,
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: IndexedStack(
                  index: _index,
                  children: const [
                    ChatsList(),
                    ContactsList(),
                    MyAccount(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            canvasColor: Colors.white,
          ),
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
            selectedItemColor: Colors.lightBlue.shade600,
            selectedFontSize: 14,
          ),
        ),
      ),
    );
  }
}
