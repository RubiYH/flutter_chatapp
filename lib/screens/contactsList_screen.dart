import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/ContactListCard.dart';
import 'package:flutter_chatapp/components/FilterPopUpMenu.dart';
import 'package:flutter_chatapp/components/SwipeUpPageRouteBuilder.dart';
import 'package:flutter_chatapp/models/user_contact_model.dart';
import 'package:flutter_chatapp/modules/getListFromPrefs_module.dart';
import 'package:flutter_chatapp/modules/updateListToPrefs_module.dart';
import 'package:flutter_chatapp/screens/add_contact_screen.dart';
import 'package:flutter_chatapp/screens/contact_detail_screen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsList extends StatefulWidget {
  final bool showAddButton, showActions, newChat;

  const ContactsList(
      {super.key,
      this.showAddButton = true,
      this.showActions = true,
      this.newChat = false});

  @override
  State<ContactsList> createState() => _ContactsState();
}

class _ContactsState extends State<ContactsList> {
  final _focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();

  late List<UserContactModel> UpdatedList = [];
  late List<UserContactModel> ContactsList = [];
  late List<UserContactModel> SearchList = [];

  @override
  void initState() {
    super.initState();

    if (ContactsList.isEmpty) {
      getListFromPrefs("Contacts", (item) {
        ContactsList.add(UserContactModel.fromJson(item));
      }).then((_) {
        UpdatedList = ContactsList;
        setState(() {});
      }).then((_) {
        textController.addListener(() {
          var searchValue = textController.text.trim();

          if (searchValue.isEmpty) {
            UpdatedList = ContactsList;
            return;
          }

          SearchList = ContactsList.where((u) =>
                  u.username.toLowerCase().contains(searchValue.toLowerCase()))
              .toList();
          UpdatedList = SearchList;

          setState(() {});
        });
      });
    }
  }

  void onFilterChange(filterContactMenu item) {
    switch (item) {
      case filterContactMenu.latest:
        UpdatedList.sort((a, b) {
          if (a.addedAt == null && b.addedAt == null) {
            return 0;
          } else if (b.addedAt == null) {
            return -1;
          } else if (a.addedAt == null) {
            return 1;
          } else {
            return DateTime.parse(b.addedAt!)
                .compareTo(DateTime.parse(a.addedAt!));
          }
        });
        break;

      case filterContactMenu.oldest:
        UpdatedList.sort((a, b) {
          if (a.addedAt == null && b.addedAt == null) {
            return 0;
          } else if (b.addedAt == null) {
            return -1;
          } else if (a.addedAt == null) {
            return 1;
          } else {
            return a.addedAt!.compareTo(b.addedAt!);
          }
        });
        break;

      case filterContactMenu.alphabetic:
      default:
        UpdatedList.sort(
          (a, b) => a.username.compareTo(b.username),
        );
        break;
    }

    updateListToPrefs("Contacts", UpdatedList);
    setState(() {});
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
                FilterPopupMenu(onChange: onFilterChange, type: "Contact"),
                if (widget.showAddButton)
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
          height: 10,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (UpdatedList.isNotEmpty)
                  for (var data in UpdatedList)
                    ContactListCard(
                      id: data.id,
                      username: data.username,
                      avatarURL: data.avatarURL,
                      nickname: data.nickname,
                      lastChatAt: data.lastChatAt,
                      showActions: widget.showActions,
                      newChat: widget.newChat,
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
            ),
          ),
        )
      ],
    );
  }
}
