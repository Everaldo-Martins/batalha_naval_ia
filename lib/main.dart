import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'code/players.dart';
import 'screens/startscreen.dart';

late Box<Players> playersBox;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlayersAdapter());
  playersBox = await Hive.openBox<Players>('players');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batalha Naval - IA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 33, 149, 243),
        ),
        useMaterial3: true,
      ),
      home: const StartScreen(title: 'Batalha Naval - IA'),
    );
  }
}

Future<void> addBanco(String name, int score) async {
  var playersBox = Hive.box<Players>('players');

  // Verificar se o usuário já existe
  var playersExists = playersBox.values.any((players) => players.name == name);

  if (!playersExists) {
    var players = Players(
      name,
      score,
    );
    await playersBox.add(players);
  } else {
    var existingPlayer =
        playersBox.values.firstWhere((players) => players.name == name);
    // Access the existing players and update the score
    existingPlayer.score = score;
    await playersBox.put(existingPlayer.key, existingPlayer);
  }
}
