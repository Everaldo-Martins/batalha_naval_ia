import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'classes/players.dart';
import 'screens/startscreen.dart';

late Box<Players> playersBox;

void main() async {
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Hive.registerAdapter(PlayersAdapter());
  playersBox = await Hive.openBox<Players>('players');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,     
      home: StartScreen(title: 'Batalha Naval - IA'),
    );
  }
}

Future<void> addBanco(String name, int score) async {
  var playersBox = Hive.box<Players>('players');

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

    existingPlayer.score = score;
    await playersBox.put(existingPlayer.key, existingPlayer);
  }
}
