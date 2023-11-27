import 'package:flutter/material.dart';
import 'package:flutter_app_cap9/providers/providers.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return BottomNavigationBar(
      currentIndex: uiProvider.selectedMenuOption,
      onTap: (int i) => uiProvider.selectedMenuOption = i,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map, color: Theme.of(context).primaryColor),
          label: 'GEOs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list, color: Theme.of(context).primaryColor),
          label: 'HTTPs',
        ),
      ],
    );
  }
}
