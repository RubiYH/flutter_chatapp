import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/CircleRippleButton.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:flutter_chatapp/components/ContactListCard.dart';
import 'package:flutter_chatapp/globals.dart';
import 'package:flutter_chatapp/models/user_list_model.dart';
import 'package:flutter_chatapp/models/user_memo_model.dart';
import 'package:flutter_chatapp/modules/getListFromPrefs_module.dart';
import 'package:flutter_chatapp/modules/updateListToPrefs_module.dart';
import 'package:flutter_chatapp/screens/chat_screen.dart';
import 'package:flutter_chatapp/screens/edit_contact_screen.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactDetailScreen extends StatefulWidget {
  final String username, id;

  const ContactDetailScreen({
    super.key,
    required this.username,
    required this.id,
  });

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  late List<UserMemoModel> MemoList = [];
  UserMemoModel? Memo;
  late List<UsersListModel> UsersList = [];
  UsersListModel? User;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  getData() async {
    await getListFromPrefs("Users", (item) {
      UsersList.add(UsersListModel.fromJson(item));
    }).then((_) {
      User = UsersList[UsersList.indexWhere((u) => u.id == widget.id)];
    });

    await getListFromPrefs("Memo", (item) {
      MemoList.add(UserMemoModel.fromJson(item));
    });

    Memo = MemoList[MemoList.indexWhere((u) => u.id == widget.id)];

    final String? getMemo = Memo?.memo;

    if (getMemo != null) {
      _textController.text = getMemo;
    }

    _textController.addListener(() {
      if (Memo?.memo == null && _textController.text.trim().isEmpty ||
          Memo?.memo == _textController.text.trim()) return;

      MemoList[MemoList.indexWhere((u) => u.id == User!.id)].memo =
          _textController.text.trim();

      updateListToPrefs("Memo", MemoList);
    });

    return {User, Memo};
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          User?.avatarURL ?? globals_default_avatar),
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      User!.username,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "@${User!.id}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '별명: ${User?.nickname ?? "없음"}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleRippleButton(
                          destination: ChatScreen(username: User!.username),
                          icon: const Icon(Icons.messenger_outline_rounded),
                          noHistory: true,
                        ),
                        const SizedBox(width: 20),
                        CircleRippleButton(
                          destination:
                              EditContactScreen(username: User!.username),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "추가한 날짜",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              User?.addedAt != null
                                  ? DateFormat("yyyy년 MM월 dd일 hh시 mm분 ss초")
                                      .format(
                                      DateTime.parse(User!.addedAt!),
                                    )
                                  : "알 수 없음.",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "메모",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Scrollbar(
                            child: TextField(
                              controller: _textController,
                              scrollController: _scrollController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "여기에 메모를 입력하세요.",
                              ),
                              maxLines: 10,
                              keyboardType: TextInputType.multiline,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "연락처 정보가 없습니다.",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
