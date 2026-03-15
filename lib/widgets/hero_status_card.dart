import 'package:flutter/material.dart';

class HeroStatusCard extends StatelessWidget {
  const HeroStatusCard({
    required this.hp,
    required this.maxHp,
    required this.message,
    super.key,
  });

  final int hp;
  final int maxHp;
  final String message;

  ({String emoji, String label}) _statusForHp(int hpValue) {
    if (hpValue == 0) return (emoji: '💀', label: 'Dead');
    if (hpValue <= 19) return (emoji: '😵', label: 'Critical');
    if (hpValue <= 49) return (emoji: '😣', label: 'Hurt');
    if (hpValue <= 79) return (emoji: '🙂', label: 'Okay');
    return (emoji: '😄', label: 'Great');
  }

  @override
  Widget build(BuildContext context) {
    final status = _statusForHp(hp);
    final hpPercent = hp / maxHp;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${status.emoji} ${status.label}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'HP: $hp / $maxHp',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: hpPercent),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
