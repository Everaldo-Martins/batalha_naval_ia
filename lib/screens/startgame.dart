import 'package:flutter/material.dart';
import 'dart:ui';
import '../main.dart';
import 'game.dart';

class MyGame extends StatelessWidget {
  const MyGame({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batalha Naval - IA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2195F3),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 400.0,
                maxHeight: 400.0,
              ),
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: const Color(0xFFDCDCDC).withOpacity(0.6),
                    padding: const EdgeInsets.all(30),
                    child: const StartGame(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StartGame extends StatefulWidget {
  const StartGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  final TextEditingController _nameController = TextEditingController();
  // ignore: unused_field
  bool _isButtonEnabled = false;
  String _selectedBoardSize = '8x12';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          width: 300,
          height: 72,
        ),
        TextField(
          controller: _nameController,
          onChanged: (text) {
            setState(() {
              _isButtonEnabled = text.isNotEmpty;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Nome do jogador',
            labelStyle: TextStyle(
              color: Color(0xFF222222),
              fontWeight: FontWeight.w600,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0A0A0A)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0A0A0A)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Tamanho do tabuleiro',
          style: TextStyle(
            color: Color(0xFF0A0A0A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: '8x12',
              groupValue: _selectedBoardSize,
              onChanged: (value) {
                setState(() {
                  _selectedBoardSize = value.toString();
                });
              },
            ),
            Container(
              margin: const EdgeInsets.only(left: 0),
              child: const Text('8x12',
                  style: TextStyle(
                    color: Color(0xFF0A0A0A),
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Radio(
              value: '10x15',
              groupValue: _selectedBoardSize,
              onChanged: (value) {
                setState(() {
                  _selectedBoardSize = value.toString();
                });
              },
            ),
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: const Text('10x15',
                  style: TextStyle(
                    color: Color(0xFF0A0A0A),
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextButton(
          onPressed: _isButtonEnabled
              ? () {
                  addBanco(_nameController.text, 0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game(
                        playerName: _nameController.text,
                        boardSize: _selectedBoardSize,
                      ),
                    ),
                  );
                }
              : null,
          child: Material(
            borderRadius: BorderRadius.circular(80),
            color: const Color(0xFF2195F3),
            elevation: 6,
            shadowColor: const Color(0xFF5C5C5C),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 36,
                color: Color(0xFF0A0A0A),
              ),
            ),
          ),
        ),
      ],
    );
  }
}