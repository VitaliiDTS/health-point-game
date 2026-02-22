import 'package:flutter/material.dart';
import 'package:health_point_game/widgets/command_input.dart';
import 'package:health_point_game/widgets/hero_status_card.dart';

class HpGamePage extends StatefulWidget {
  const HpGamePage({super.key});

  @override
  State<HpGamePage> createState() => _HpGamePageState();
}

class _HpGamePageState extends State<HpGamePage> {
  static const int _maxHp = 100;

  final TextEditingController _controller = TextEditingController();

  int _hp = _maxHp;
  String? _errorText;
  String _message = 'Введи команду, щоб змінити HP героя';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _hp = _maxHp;
      _errorText = null;
      _message = 'HP повернуто до $_maxHp.';
      _controller.clear();
    });
  }

  void _applyCommand() {
    final raw = _controller.text.trim();

    if (raw.isEmpty) {
      setState(() => _errorText = 'Введи команду: damage 10 / heal 5');
      return;
    }

    if (raw.toLowerCase() == 'avada kedavra') {
      setState(() {
        _hp = 0;
        _errorText = null;
        _message = 'Avada Kedavra! Вклонися Темному Лорду';
        _controller.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avada Kedavra!')),
      );
      return;
    }

    final parts = raw.split(RegExp(r'\s+'));
    if (parts.length != 2) {
      setState(() => _errorText = 'Невірний формат. Приклад: damage 12');
      return;
    }

    final command = parts[0].toLowerCase();
    final value = int.tryParse(parts[1]);

    if (value == null || value <= 0) {
      setState(() => _errorText = 'Число має бути цілим і > 0.');
      return;
    }

    if (_hp == 0) {
      setState(() => _errorText = 'Герой мертвий :(');
      return;
    }

    switch (command) {
      case 'damage':
        setState(() {
          _hp = (_hp - value).clamp(0, _maxHp);
          _errorText = null;
          _message = 'Отримано $value Шкоди';
        });

      case 'heal':
        setState(() {
          _hp = (_hp + value).clamp(0, _maxHp);
          _errorText = null;
          _message = 'Поліковано на $value';
        });

      default:
        setState(() => _errorText = 'Невідома команда. Використай damage/heal/reset');
        return;
    }

    _controller.clear();
    if (_hp == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Game over')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Point Game'),
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: _reset,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeroStatusCard(
                  hp: _hp,
                  maxHp: _maxHp,
                  message: _message,
                ),
                const SizedBox(height: 16),
                CommandInput(
                  controller: _controller,
                  errorText: _errorText,
                  onApply: _applyCommand,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
