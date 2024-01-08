import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/ContactListCard.dart';
import 'package:flutter_chatapp/components/FilterPopUpMenu.dart';
import 'package:flutter_chatapp/components/SwipeUpPageRouteBuilder.dart';
import 'package:flutter_chatapp/models/user_list_model.dart';
import 'package:flutter_chatapp/modules/getListFromPrefs_module.dart';
import 'package:flutter_chatapp/modules/updateListToPrefs_module.dart';
import 'package:flutter_chatapp/screens/add_contact_screen.dart';
import 'package:flutter_chatapp/screens/contact_detail_screen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsList extends StatefulWidget {
  final bool showAddButton, showActions, newChat, groupChat;
  final Map selectedUsersMap;
  final Function? afterSelected;

  const ContactsList({
    super.key,
    this.showAddButton = true,
    this.showActions = true,
    this.newChat = false,
    this.groupChat = false,
    this.selectedUsersMap = const {},
    this.afterSelected,
  });

  @override
  State<ContactsList> createState() => ContactsState();
}

class ContactsState extends State<ContactsList> {
  final _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  late List<UsersListModel> UpdatedList;
  late List<UsersListModel> UsersList = [];
  late List<UsersListModel> SearchList = [];

  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
      var searchValue = _textController.text.trim();

      if (searchValue.isEmpty) {
        UpdatedList = UsersList;
        return;
      }

      SearchList = UsersList.where((u) =>
              u.username.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
      UpdatedList = SearchList;

      setState(() {});
    });
  }

  Future getData() async {
    UsersList = [];
    await getListFromPrefs("Users", (item) {
      UsersList.add(UsersListModel.fromJson(item));
    });
    UpdatedList = UsersList;

    return UsersList;
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
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
        UpdatedList.sort((a, b) {
          // Custom comparator function
          bool isKorean(String name) {
            // You might need a more sophisticated check for Korean names
            // This is just a simple example
            return RegExp(r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$').hasMatch(name);
          }

          // Compare function logic
          bool aIsKorean = isKorean(a.username);
          bool bIsKorean = isKorean(b.username);

          if (aIsKorean && bIsKorean) {
            return a.username
                .compareTo(b.username); // Sort Korean names alphabetically
          } else if (aIsKorean) {
            return -1; // Korean comes first
          } else if (bIsKorean) {
            return 1; // Non-Korean comes later
          } else {
            return a.username
                .compareTo(b.username); // Sort non-Korean names alphabetically
          }
        });
        break;
    }

    updateListToPrefs("Users", UpdatedList);
    setState(() {});
  }

  void onCheckSelected(String id, String username, bool checked) {
    if (checked == true) {
      widget.selectedUsersMap[id] = username;
    } else {
      widget.selectedUsersMap.remove(id);
    }

    widget.afterSelected!();
  }

  void afterAdded() {
    setState(() {
      getData();
    });
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
                FilterPopupMenu(onChange: onFilterChange, type: "Contacts"),
                if (widget.showAddButton)
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        SwipeUpPageRouteBuilder(
                          AddContactScreen(afterAdded: afterAdded),
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
                controller: _textController,
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
        if (widget.groupChat)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "초대할 연락처: ${widget.selectedUsersMap.isNotEmpty ? "${widget.selectedUsersMap.length}명" : ""}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Wrap(
                    children: [
                      for (var i in widget.selectedUsersMap.values)
                        Container(
                          margin: const EdgeInsets.only(
                            right: 8,
                            top: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              i,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
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
                            groupChat: widget.groupChat,
                            selectedUsersMap: widget.selectedUsersMap,
                            onSelected: onCheckSelected,
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
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "오류가 발생하였습니다.",
                      style: TextStyle(
                        fontSize: 20,
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
        )
      ],
    );
  }
}
