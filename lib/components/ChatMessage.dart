import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message, sentAt;
  final bool selfSent, hasRead;

  const ChatMessage({
    super.key,
    required this.selfSent,
    required this.message,
    required this.sentAt,
    this.hasRead = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                selfSent ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!selfSent)
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://lh3.google.com/u/0/ogw/ANLem4YhMQ9VVephNQ0m4A_jRJxxeSkSKYCi7ELdJ6-R=s32-c-mo"),
                  radius: 16,
                ),
              const SizedBox(
                width: 10,
              ),
              FittedBox(
                fit: BoxFit.fill,
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 25,
                    maxWidth: 150,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: selfSent ? Colors.yellow.shade200 : Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 20,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
