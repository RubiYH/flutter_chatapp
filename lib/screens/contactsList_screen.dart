import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/ContactListCard.dart';
import 'package:flutter_chatapp/components/SwipeUpPageRouteBuilder.dart';
import 'package:flutter_chatapp/models/user_model.dart';
import 'package:flutter_chatapp/modules/getContact_module.dart';
import 'package:flutter_chatapp/screens/add_contact_screen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsState();
}

class _ContactsState extends State<ContactsList> {
  final _focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();

  late List<UserModel> ValidatedList = [];
  late List<UserModel> ContactsList = [];
  late List<UserModel> SearchList = [];

  @override
  void initState() {
    super.initState();

    if (ContactsList.isEmpty) {
      getContact(ContactsList).then((_) {
        ValidatedList = ContactsList;
        setState(() {});
      }).then((_) {
        textController.addListener(() {
          var searchValue = textController.text.trim();

          if (searchValue.isEmpty) {
            ValidatedList = ContactsList;
            return;
          }

          SearchList = ContactsList.where((u) =>
                  u.username.toLowerCase().contains(searchValue.toLowerCase()))
              .toList();
          ValidatedList = SearchList;

          setState(() {});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.filter_outline,
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      SwipeUpPageRouteBuilder(
                        const AddContactScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Ionicons.add_outline,
                    size: 24,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 180,
              height: 40,
              child: TextField(
                controller: textController,
                focusNode: _focusNode,
                cursorHeight: 20,
                autocorrect: false,
                onTapOutside: (event) => _focusNode.unfocus(),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "검색",
                  prefixIcon: const Icon(Ionicons.search_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.075),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            if (ValidatedList.isNotEmpty)
              for (var data in ValidatedList)
                ContactListCard(
                  id: data.id,
                  username: data.username,
                  avatarURL: data.avatarURL,
                  nickname: data.nickname,
                  lastChatAt: data.lastChatAt,
                )
            else
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  "연락처가 없습니다.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
          ],
        )
      ],
    );
  }
}
