import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:flutter_chatapp/components/SwipeUpPageRouteBuilder.dart';
import 'package:flutter_chatapp/globals.dart';
import 'package:flutter_chatapp/main.dart';
import 'package:flutter_chatapp/models/user_model.dart';
import 'package:flutter_chatapp/modules/getListFromPrefs_module.dart';
import 'package:flutter_chatapp/modules/updateListToPrefs_module.dart';
import 'package:flutter_chatapp/modules/validateUserID.dart';
import 'package:flutter_chatapp/screens/contactsList_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameText = TextEditingController();
  final nicknameText = TextEditingController();
  final IDText = TextEditingController();

  String? errorText;

  late List<UserModel> ContactsList = [];
  late UserModel newContactsList;

  @override
  void initState() {
    super.initState();

    getListFromPrefs("Contacts", (item) {
      ContactsList.add(UserModel.fromJson(item));
    }).then((_) => {});
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
                final validatedData = await validateUserID(IDText.text);

                if (!mounted) return;

                switch (validatedData["status"]) {
                  case true:
                    showDialog(
                      context: context,
                      barrierDismissible: false,
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
                                    validatedData["username"],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      validatedData["avatarURL"] ??
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
                                  onPressed: () {
                                    Map<String, dynamic> newContactsList = {
                                      "username": nameText.text.isEmpty
                                          ? validatedData["username"]
                                          : nameText.text,
                                      "id": validatedData["id"],
                                      "nickname": nicknameText.text.isEmpty
                                          ? null
                                          : nicknameText.text,
                                      "avatarURL": validatedData["avatarURL"],
                                      "lastChatAt": null,
                                      "memo": null,
                                      "addedAt": DateTime.now().toString()
                                    };

                                    ContactsList.add(
                                        UserModel.fromJson(newContactsList));

                                    updateListToPrefs("Contacts", ContactsList)
                                        .then((_) {
                                      setState(() {});
                                    });

                                    Fluttertoast.showToast(
                                      msg: "연락처를 추가하였습니다.",
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_SHORT,
                                    );

                                    Navigator.of(ctx).pushAndRemoveUntil(
                                      SwipeUpPageRouteBuilder(
                                          const App(index: 1)),
                                      (route) => false,
                                    );
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
                    break;

                  case false:
                    errorText = "${IDText.text}의 연락처를 찾을 수 없습니다.";
                    break;

                  case "alreadyExists":
                    errorText = "이미 저장한 연락처입니다.";
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
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
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
