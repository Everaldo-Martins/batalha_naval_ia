import 'dart:ui';
import 'package:flutter/material.dart';
import 'scoreboard.dart';
import 'mygame.dart';

class Winner extends StatelessWidget {
  final String winnerName;
  final int points;

  const Winner({
    super.key,
    required this.winnerName,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/winner.png',
                width: 450.0,
                height: 249.0,
              ),
              const SizedBox(height: 20),
              Text(
                'Nome: $winnerName',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Pontos: $points',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50.0),
              TextButton(
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 33, 149, 243),
                  elevation: 15,
                  shadowColor: const Color.fromARGB(255, 92, 92, 92),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 52.0),
                    child: Text(
                      'Jogar novamente',
                      style: TextStyle(
                        color: Color.fromARGB(255, 37, 37, 37),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyGame()),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: 80,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
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
                        backgroundColor: Colors.transparent,
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
        ),
      ),
    );
  }
}
