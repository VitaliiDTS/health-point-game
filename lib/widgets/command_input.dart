import 'package:flutter/material.dart';

class CommandInput extends StatelessWidget {
  const CommandInput({
    required this.controller,
    required this.onApply,
    this.errorText,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onApply;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Command',
            helperText: 'damage 5 / heal 5 / Avada Kedavra',
            errorText: errorText,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (_) => onApply(),
        ),
        const SizedBox(height: 12),
        FilledButton(onPressed: onApply, child: const Text('Apply')),
      ],
    );
  }
}
