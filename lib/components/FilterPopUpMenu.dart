import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

enum filterMenu {
  latest('latest', '최신순'),
  oldest('oldest', '오래된순'),
  alphabetic('alphabetic', '가나다순');

  const filterMenu(this.type, this.name);
  final String type;
  final String name;
}

class FilterPopupMenu extends StatefulWidget {
  final Function onChange;

  const FilterPopupMenu({
    super.key,
    required this.onChange,
  });

  @override
  State<FilterPopupMenu> createState() => _FilterPopupMenuState();
}

class _FilterPopupMenuState extends State<FilterPopupMenu> {
  filterMenu? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<filterMenu>(
      icon: const Icon(Ionicons.filter_outline),
      initialValue: selectedMenu,
      onSelected: (filterMenu item) {
        selectedMenu = item;
        widget.onChange(item);
      },
      itemBuilder: (context) => <PopupMenuEntry<filterMenu>>[
        for (final i in filterMenu.values)
          PopupMenuItem<filterMenu>(
            value: i,
            child: ListTile(
              title: Text(i.name),
              trailing: selectedMenu == i
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
