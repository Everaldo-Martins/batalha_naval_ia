# 🛳️ Batalha Naval com IA 💥

## 📝 Especificações do Projeto 

### ⚙️ Diretrizes

- **Interface Gráfica**: O jogo deve ter uma interface gráfica (mesmo que simples). Interface via texto é aceitável apenas se a linguagem não permitir facilmente desenvolver uma interface gráfica.
- **Top 5**: O jogo deve apresentar um Top 5 com, no mínimo, as seguintes informações: nome, pontuação e data/horário da partida. A pontuação dos jogadores deve ser armazenada (mesmo que seja em um arquivo TXT).
- **Pontuação**: A forma de pontuação deve ser definida pelo grupo (por exemplo, considerando o tempo para vencer uma partida).
- **Banco de Dados**: Sugere-se o uso do SQLite, mas estamos utilizando o Hive.
- **Dois Jogadores**: O jogo deve ser jogado por dois jogadores (humano e máquina).
- **IA Inteligente**: A máquina deve fazer jogadas inteligentes. Um jogo puramente aleatório resultará em Nota Zero.

### 📋 Regras Adaptadas

1. **Objetivo**: Os jogadores devem adivinhar em que quadrados estão os navios do oponente. O objetivo é afundar todos os barcos do oponente. Ganha quem afundar todos os navios adversários primeiro.
2. **Campos de Batalha**: O jogo deve apresentar dois campos de batalha para o jogador — um representando a disposição dos barcos do jogador e outro do oponente.
3. **Tamanhos dos Campos**: Deve ser possível escolher entre dois tamanhos distintos do campo de batalha (por exemplo: 8x12 e 10x15).
4. **Posicionamento dos Navios**: O jogador humano coloca os seus navios nos quadros, alinhados horizontalmente ou verticalmente. Os navios da máquina devem ser dispostos aleatoriamente. O número de navios é igual para ambos os jogadores e os navios não podem se sobrepor.
5. **Tipos de Navios**:
   - 1 porta-aviões (cinco quadrados)
   - 2 navios-tanque (quatro quadrados)
   - 3 contratorpedeiros (três quadrados)
   - 4 submarinos (dois quadrados)
   - Os quadrados que compõem um navio devem estar conectados e em fila reta.
6. **Jogadas**:
   - Após os navios serem posicionados, cada jogador, na sua vez, disparará 3 tiros consecutivos (selecionando três quadrados do campo de batalha do oponente).
   - A interface mostrará se os tiros foram acertados, mas não necessariamente informará quais navios foram atingidos. Esta informação só será revelada quando o navio for totalmente destruído.
7. **Tiros Especiais**: Os jogadores podem dar 2 tiros especiais durante a partida (informando tal escolha no início da sua jogada). Nesse caso, em vez dos tradicionais 3 tiros consecutivos, o jogador dará apenas um tiro, mas abrangendo os quadrados ao seu redor (atingindo uma área de 9 quadrados).
8. **Ordem de Jogadas**: O jogador humano sempre joga primeiro.
9. **Fim do Jogo**: O jogo termina quando um dos jogadores afundar todos os navios do seu oponente.

### 🚀 Equipe de Desenvolvimento

- 👨🏻‍💻 **[Arthur](https://github.com/arthurrpf)**
- 👨🏽‍💻 **[Everaldo](https://github.com/Everaldo-Martins)**
- 👨🏽‍💻 **[Júlio](https://github.com/juliocesar710)**
- 👩🏻‍💻 **[Lilianny](https://github.com/LiliannyMarinho)**