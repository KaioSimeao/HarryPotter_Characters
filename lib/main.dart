import 'package:avaliacao_2/providers/characters_provider.dart';
import 'package:avaliacao_2/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharactersProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Harry Potter Characters',
      theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          appBarTheme: const AppBarTheme(backgroundColor: Color(0x63496767)),
          scaffoldBackgroundColor: const Color(0x63202C30)),
      home: const CharactersScreen(),
    );
  }
}
