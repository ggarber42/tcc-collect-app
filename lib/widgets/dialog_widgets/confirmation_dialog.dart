import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String confirmationText;
  ConfirmationDialog(this.confirmationText);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        confirmationText,
      ),
      actions: [
        TextButton(
          child: const Text('NÃO'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text('SIM'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
