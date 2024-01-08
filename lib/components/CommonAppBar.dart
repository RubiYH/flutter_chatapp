import 'package:flutter/material.dart';
import 'package:flutter_chatapp/main.dart';
import 'package:ionicons/ionicons.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    this.title,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Ionicons.chevron_back_outline),
        onPressed: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
      ),
      title: (title != null)
          ? Text(
              title!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      centerTitle: true,
      scrolledUnderElevation: 0,
      shadowColor: null,
      elevation: 0,
      actions: actions,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
    );
  }
}
