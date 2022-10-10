import 'package:flutter/material.dart';

class DeleteModelDialog extends StatefulWidget {
  final int modelId;

  DeleteModelDialog(this.modelId);

  @override
  State<DeleteModelDialog> createState() => _DeleteModelDialogState();
}

class _DeleteModelDialogState extends State<DeleteModelDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        'Deseja deletar o modelo?',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Sim'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: const Text('Não'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
