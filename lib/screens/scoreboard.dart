import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../code/players.dart';
import 'dart:ui';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  Future<List<Map<String, dynamic>>> obterNomesDoHive() async {
    // Utilize a referência local para playerBox
    var playerBox = Hive.box<Players>('players');

    // Ordenar os usuários por pontuação em ordem decrescente
    final playerList = playerBox.values.toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    // Pegar os nomes dos primeiros 5 usuários (top 5)
    final top5Players = playerList.take(5);

    List<Map<String, dynamic>> dados = [];
    for (int i = 0; i < top5Players.length; i++) {
      var player = top5Players.elementAt(i);
      dados.add({
        'posicao': i + 1,
        'nome': player.name,
        'pontuacao': player.score,
      });
    }
    return dados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Batalha Naval - IA',
          style: TextStyle(
            color: Color(0xFFD8D8D8),
          ),
        ),
        backgroundColor: const Color(0xFF202020),
        iconTheme: const IconThemeData(
          color: Color(0xFFD8D8D8),
        ),
      ),
      body: Stack(
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
            child: Center(
              child: SizedBox(
                width: 350.0,
                height: 435.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      color: const Color(0xFFDCDCDC)
                          .withOpacity(0.6),
                      padding: const EdgeInsets.all(30),
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: obterNomesDoHive(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Erro, sem informações.'));
                          } else {
                            List<Map<String, dynamic>> dados =
                                snapshot.data ?? [];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Top 5 ranking',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...dados.map((data) {
                                  return ListTile(
                                    title: Text(
                                      '${data['posicao']}. ${data['nome']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Pontuação: ${data['pontuacao']}',
                                    ),
                                  );
                                }),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}