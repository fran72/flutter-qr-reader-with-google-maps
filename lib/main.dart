import 'package:flutter/material.dart';
import 'package:flutter_app_cap9/providers/providers.dart';
import 'package:flutter_app_cap9/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'map': (_) => const MapScreen(),
        },
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.purple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.purple),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Colors.purple),
        ),
      ),
    );
  }
}
