# Especificações do Projeto

## Jogo definido: Batalha Naval com IA

### Diretrizes:

- O jogo deve ter interface gráfica (mesmo que simples)
- Interface via texto aceitável apenas caso a linguagem não possibilite facilmente desenvolver interface gráfica.
- Apresentar Top5 com, no mínimo, estas informações: nome, pontuação e data/horário da partida. **OBS.**: _deve-se armazenar a pontuação dos jogadores (mesmo que seja em um txt)_.
- A forma de pontuação deve ser definida pelo grupo (por exemplo, considerando o tempo para vencer uma partida).
- Sugestão: buscar a possibilidade de usar o SQLite. (Usamos o Hive)
- Dois jogadores (humano e _máquina_)
- A _máquina_ deve fazer jogadas _inteligentes_. Jogo puramente aleatório é passível de Nota Zero.

### Regras (_Adaptadas_):

- Os jogadores têm de adivinhar em que quadrados estão os navios do oponente. O objetivo é atingir (_afundar_) os barcos do oponente, ganhando quem atingir primeiro todos os navios adversários.
- O jogo deve apresentar, para o jogador, dois campos de batalha — um que representa a disposição dos barcos do jogador, e outro que representa a do oponente.
- Deve ser possível escolher entre 2 tamanhos distintos do campo de batalha (por exemplo: 8x12 e 10x15).
- Antes do início do jogo, o jogador humano colocará os seus navios nos quadros, alinhados horizontalmente ou verticalmente. Os navios do jogador _máquina_ devem ser dispostos aleatoriamente. O número de navios é igual para ambos jogadores e os navios não podem se sobrepor.
- Os navios são: **1 porta-aviões (cinco quadrados)**, **2 navios-tanque (quatro quadrados)**, **3 contratorpedeiros (três quadrados)** e **4 submarinos (dois quadrados)**. Vale destacar que os quadrados que compõem um navio devem estar conectados e em fila reta. 
- Após os navios terem sido posicionados, cada jogador, na sua vez de jogar, seguirá o seguinte procedimento: disparará 3 tiros consecutivos (selecionando três quadrados do campo de batalha do oponente); após os 3 tiros, a interface mostrará se os tiros foram acertados, mas não necessariamente informará quais navios foram atingidos (tal informação só deve ser revelada quando o navio for totalmente destruído).
- Os jogadores podem dar *2 tiros especiais* durante a partida (informando tal escolha no início da sua jogada). Nesse caso, em vez dos tradicionais 3 tiros consecutivos, o jogador dará apenas um tiro, mas abrangendo os quadrados ao seu redor (ou seja, em vez de atingir 1 quadrado, poderá atingir uma área de 9 quadrados).
- O jogador humano sempre joga primeiro.
- O jogo termina quando um dos jogadores afundar todas as armas do seu oponente.

### Equipe de Desenvolvimento:
- [Arthur](https://github.com/arthurrpf)
- [Everaldo](https://github.com/Everaldo-Martins)
- [Júlio](https://github.com/juliocesar710)
- [Lilianny](https://github.com/LiliannyMarinho)