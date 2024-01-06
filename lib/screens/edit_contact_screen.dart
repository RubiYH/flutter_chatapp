import 'package:flutter/material.dart';

class EditContactScreen extends StatefulWidget {
  final String username;

  const EditContactScreen({
    super.key,
    required this.username,
  });

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
