import 'dart:ui';
import 'package:flutter/material.dart';
import 'scoreboard.dart';
import 'mygame.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required String title});

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
      home: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/logo_start.png',
                      width: 600.0, height: 229.0),
                ),
                const SizedBox(height: 20),
                // Botão "Jogar"
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 32, 32, 32), width: 4),
                    color: const Color.fromARGB(255, 33, 149, 243)
                        .withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    width: 90.0,
                    height: 90.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                        child: IconButton(
                          iconSize: 62,
                          icon: const Icon(Icons.play_arrow),
                          color: const Color.fromARGB(255, 37, 37, 37),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyGame()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: 80,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  color: const Color.fromARGB(255, 33, 149, 243),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 92, 92, 92),
                      spreadRadius: 1,
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(0, 129, 129, 129),
                    elevation: 0,
                  ),
                  child: const Icon(
                    Icons.list,
                    size: 30.0,
                    color: Color.fromARGB(255, 32, 32, 32),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScoreBoard(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
