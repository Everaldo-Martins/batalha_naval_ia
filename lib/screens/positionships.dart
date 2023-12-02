import 'package:flutter/material.dart';

class PositionShips extends StatelessWidget {
  final int gridX = 8; // Defina o número desejado de colunas
  final int gridY = 8;

  const PositionShips({super.key}); // Defina o número desejado de linhas

  String getImageFromGrid(List<List<String>> playerGrid, int x, int y, bool isEnemy) {
    // Implemente a lógica para obter a imagem com base nas coordenadas (x, y) e na grade do jogador
    // Retorne o caminho da imagem apropriada
    return "caminho_da_imagem";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridX,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
        ),
        itemCount: gridY * gridX,
        itemBuilder: (_, i) {
          int x = i % gridX;
          int y = i ~/ gridX;
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: const Color.fromARGB(255, 12, 12, 12),
              ),
            ),
            child: Center(
              child: Image.asset(
                getImageFromGrid([], x, y, false), // Substitua [] pelo playerGrid apropriado
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}