import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

enum filterContactMenu {
  latest('latest', '최신순'),
  oldest('oldest', '오래된순'),
  alphabetic('alphabetic', '가나다순');

  const filterContactMenu(this.type, this.name);
  final String type;
  final String name;
}

enum filterChatMenu {
  latest('latest', '최신순'),
  unread('unread', '안 읽은 순'),
  alphabetic('alphabetic', '가나다순');

  const filterChatMenu(this.type, this.name);
  final String type;
  final String name;
}

class FilterPopupMenu extends StatefulWidget {
  final Function onChange;
  final String type;

  const FilterPopupMenu(
      {super.key, required this.onChange, required this.type});

  @override
  State<FilterPopupMenu> createState() => _FilterPopupMenuState();
}

class _FilterPopupMenuState extends State<FilterPopupMenu> {
  filterContactMenu? selectedContactMenu;
  filterChatMenu? selectedChatMenu;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case "Contact":
        return PopupMenuButton<filterContactMenu>(
          icon: const Icon(Ionicons.filter_outline),
          initialValue: selectedContactMenu,
          onSelected: (filterContactMenu item) {
            selectedContactMenu = item;
            widget.onChange(item);
          },
          itemBuilder: (context) => <PopupMenuEntry<filterContactMenu>>[
            for (final i in filterContactMenu.values)
              PopupMenuItem<filterContactMenu>(
                value: i,
                child: ListTile(
                  title: Text(
                    i.name,
                  ),
                  trailing: selectedContactMenu == i
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade600,
                          ),
                          width: 5,
                          height: 5,
                        )
                      : null,
                ),
              )
          ],
          color: Colors.white,
        );

      case "Chat":
      default:
        return PopupMenuButton<filterChatMenu>(
          icon: const Icon(Ionicons.filter_outline),
          initialValue: selectedChatMenu,
          onSelected: (filterChatMenu item) {
            selectedChatMenu = item;
            widget.onChange(item);
          },
          itemBuilder: (context) => <PopupMenuEntry<filterChatMenu>>[
            for (final i in filterChatMenu.values)
              PopupMenuItem<filterChatMenu>(
                value: i,
                child: ListTile(
                  title: Text(
                    i.name,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                  ),
                  trailing: selectedChatMenu == i
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade600,
                          ),
                          width: 5,
                          height: 5,
                        )
                      : null,
                ),
              )
          ],
          color: Colors.white,
        );
    }
  }
}
