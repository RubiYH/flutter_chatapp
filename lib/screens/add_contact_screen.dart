import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:flutter_chatapp/components/SwipeUpPageRouteBuilder.dart';
import 'package:flutter_chatapp/globals.dart';
import 'package:flutter_chatapp/main.dart';
import 'package:flutter_chatapp/models/user_memo_model.dart';
import 'package:flutter_chatapp/models/user_list_model.dart';
import 'package:flutter_chatapp/modules/getListFromPrefs_module.dart';
import 'package:flutter_chatapp/modules/updateListToPrefs_module.dart';
import 'package:flutter_chatapp/modules/addUserByID.dart';
import 'package:flutter_chatapp/screens/contactsList_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';

class AddContactScreen extends StatefulWidget {
  final Function afterAdded;

  const AddContactScreen({
    super.key,
    required this.afterAdded,
  });

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameText = TextEditingController();
  final nicknameText = TextEditingController();
  final IDText = TextEditingController();

  String? errorText;

  List<UserMemoModel> MemoList = [];
  late UserMemoModel newMemoList;

  List<UsersListModel> UsersList = [];
  late UsersListModel newUsersList;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await getListFromPrefs("Memo", (item) {
      MemoList.add(UserMemoModel.fromJson(item));
    });

    await getListFromPrefs("Users", (item) {
      UsersList.add(UsersListModel.fromJson(item));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "새 연락처",
        actions: [
          IconButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final getUserByID = await addUserByID(IDText.text);

                if (!mounted) return;

                switch (getUserByID["status"]) {
                  case true:
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (ctx) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          scrollable: true,
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "이 연락처를\n추가하시겠습니까?",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    nameText.text.isNotEmpty
                                        ? nameText.text
                                        : getUserByID["username"],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      getUserByID["avatarURL"] ??
                                          globals_default_avatar,
                                    ),
                                    radius: 40,
                                  )
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    var createdAt = DateTime.now().toString();

                                    Map<String, dynamic> newMemoList = {
                                      "username": nameText.text.isEmpty
                                          ? getUserByID["username"]
                                          : nameText.text,
                                      "id": getUserByID["id"],
                                      "nickname": nicknameText.text.isEmpty
                                          ? null
                                          : nicknameText.text,
                                      "memo": null,
                                    };

                                    MemoList.add(UserMemoModel.fromJson(
                                      newMemoList,
                                    ));

                                    await updateListToPrefs("Memo", MemoList);

                                    Map<String, dynamic> newUsersList = {
                                      "username": nameText.text.isEmpty
                                          ? getUserByID["username"]
                                          : nameText.text,
                                      "id": getUserByID["id"],
                                      "nickname": nicknameText.text.isEmpty
                                          ? null
                                          : nicknameText.text,
                                      "avatarURL": getUserByID["avatarURL"],
                                      "lastChatAt": null,
                                      "addedAt": createdAt
                                    };

                                    UsersList.add(UsersListModel.fromJson(
                                      newUsersList,
                                    ));

                                    await updateListToPrefs("Users", UsersList);

                                    await widget.afterAdded();

                                    Fluttertoast.showToast(
                                      msg: "연락처를 추가하였습니다.",
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_SHORT,
                                    );

                                    if (ctx.mounted) {
                                      Navigator.of(ctx).popUntil(
                                        (route) => route.isFirst,
                                      );
                                    }
                                  },
                                  child: const Text("추가"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text("취소"),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    );

                    errorText = null;
                    break;

                  case false:
                    errorText = "${IDText.text}의 연락처를 찾을 수 없습니다.";
                    break;

                  case "alreadyExists":
                    errorText = "이미 저장한 연락처입니다.";
                    break;

                  default:
                    errorText = "오류가 발생하였습니다.";
                    break;
                }
                setState(() {});
              }
            },
            icon: const Icon(Ionicons.checkmark_outline),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                ContactInputField("이름", nameText),
                const SizedBox(
                  height: 20,
                ),
                ContactInputField("별명", nicknameText),
                const SizedBox(
                  height: 20,
                ),
                ContactInputField("ID*", IDText, Colors.red.shade300, true),
                const SizedBox(
                  height: 20,
                ),
                const Text("* 는 필수 입력란입니다.", style: TextStyle(fontSize: 12))
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField ContactInputField(String name, TextEditingController controller,
      [Color? color, bool required = false]) {
    return TextFormField(
      validator: (value) {
        if (required) {
          if (value!.trim().isEmpty) {
            return "필수 입력란입니다.";
          }
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters:
          required ? [FilteringTextInputFormatter.deny(RegExp('[ ]'))] : null,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1.3, color: Colors.grey.shade500),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1.3, color: Colors.grey.shade500),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1.3, color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1.3, color: Colors.red.shade300),
        ),
        hintText: name,
        hintStyle: TextStyle(
          fontSize: 16,
          color: color,
        ),
        errorText: required ? errorText : null,
      ),
    );
  }
}
