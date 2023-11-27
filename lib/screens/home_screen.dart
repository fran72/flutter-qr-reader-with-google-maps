import 'package:flutter/material.dart';
import 'package:flutter_app_cap9/providers/providers.dart';
import 'package:flutter_app_cap9/screens/screens.dart';
import 'package:flutter_app_cap9/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Bar'),
        actions: [
          IconButton(
            onPressed: () {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);
              scanListProvider.deleteAllScans();
            },
            icon: const Icon(Icons.delete_forever),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    var currentIndex = uiProvider.selectedMenuOption;

    // final newScan = ScanModel(value: 'geo:23.980098,-90.466533');
    final newScan =
        ScanModel(value: 'geo:39.473465654790616, -0.3421750097648288');

    DBProvider.db.newScan(newScan);

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return const MapsScreen();
      case 1:
        scanListProvider.loadScansByType('http');
        return const DirectionsScreen();
      default:
        scanListProvider.loadScansByType('http');
        return const DirectionsScreen();
    }
  }
}
