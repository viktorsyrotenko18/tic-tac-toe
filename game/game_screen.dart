import 'package:flutter/material.dart';
import 'game_controller.dart';
import 'package:tic_tac_toe/widgets/cell.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameController controller = GameController();
  bool vsBot = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F0C29),
              Color(0xFF302B63),
              Color(0xFF24243E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔥 Заголовок
              const Text(
                "TIC TAC TOE",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 20,
                      color: Colors.white24,
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🎯 Статус гри
              Text(
                controller.winner == ''
                    ? 'Хід: ${controller.currentPlayer}'
                    : controller.winner == 'draw'
                        ? 'Нічия 🤝'
                        : 'Переміг ${controller.winner} 🎉',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 20,
                      color: Colors.white24,
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🤖 Перемикач бота
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("🤖 Бот"),
                  Switch(
                    value: vsBot,
                    onChanged: (v) {
                      setState(() {
                        vsBot = v;
                        controller.reset();
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🧩 Ігрове поле
              SizedBox(
                width: 330,
                height: 330,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return Cell(
                      value: controller.board[index],
                      highlight: controller.winningLine.contains(index),
                      onTap: () {
                        setState(() {
                          controller.makeMove(index, vsBot: vsBot);
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // 🔘 Кнопка нової гри
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                  elevation: 10,
                ),
                onPressed: () {
                  setState(() {
                    controller.reset();
                  });
                },
                child: const Text(
                  "Нова гра",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
