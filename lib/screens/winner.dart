import 'dart:ui';
import 'package:flutter/material.dart';
import 'scoreboard.dart';
import 'startgame.dart';

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
              Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/winner.png',
                  width: 450,
                  height: 249,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Nome: $winnerName',
                style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Pontos: $points',
                style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF202020),
                    width: 4,
                  ),
                  color: const Color(0xFF2195F3).withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: IconButton(
                        iconSize: 62,
                        icon: const Icon(Icons.restart_alt_sharp),
                        color: const Color(0xFF252525),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyGame(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(18),
                child: SizedBox(
                  width: 80,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: const Color(0xFF2195F3),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFF5C5C5C),
                          spreadRadius: 1,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0x00000000),
                        elevation: 0,
                      ),
                      child: const Icon(
                        Icons.list,
                        size: 30.0,
                        color: Color(0xFF202020),
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
