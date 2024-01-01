import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/ContactListCard.dart';
import 'package:flutter_chatapp/screens/add_contact_screen.dart';
import 'package:ionicons/ionicons.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddContactScreen(),
                  ),
                );
              },
              icon: const Icon(
                Ionicons.add_outline,
                size: 28,
              ),
            ),
            SizedBox(
              width: 180,
              child: TextField(
                focusNode: _focusNode,
                onTapOutside: (event) => _focusNode.unfocus(),
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Ionicons.search_outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(8),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const ContactListCard(username: "test"),
        const ContactListCard(username: "ddd"),
        const ContactListCard(
          username: "tessst",
          nickname: "teststts",
        ),
        const ContactListCard(username: "tessssssssssssssssssssssssssssst"),
        const ContactListCard(username: "test"),
      ],
    );
  }
}
