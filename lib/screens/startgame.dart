
import 'package:flutter/material.dart';
import '../main.dart';
import 'game.dart';

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
  String _selectedBoardSize = '10x15';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          width: 300.0,
          height: 72.0,
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
              color: Color.fromRGBO(34, 34, 34, 1),
              fontWeight: FontWeight.w600,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(10, 10, 10, 1.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(10, 10, 10, 1.0)),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Tamanho do tabuleiro',
          style: TextStyle(
            color: Color.fromRGBO(10, 10, 10, 1.0),
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              margin: const EdgeInsets.only(right: 20.0),
              child: const Text('10x15',
                  style: TextStyle(
                    color: Color.fromRGBO(10, 10, 10, 1.0),
                    fontWeight: FontWeight.w600,
                  )),
            ),
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
                    color: Color.fromRGBO(10, 10, 10, 1.0),
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
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
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromARGB(255, 33, 149, 243),
            elevation: 15,
            shadowColor: const Color.fromARGB(255, 92, 92, 92),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 52.0),
              child: Text(
                'Iniciar',
                style: TextStyle(
                  color: Color.fromARGB(255, 37, 37, 37),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
  