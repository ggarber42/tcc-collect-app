import 'package:flutter/material.dart';

class DeleteModelDialog extends StatefulWidget {
  final int modelId;
  final String text;

  DeleteModelDialog(this.modelId, this.text);

  @override
  State<DeleteModelDialog> createState() => _DeleteModelDialogState();
}

class _DeleteModelDialogState extends State<DeleteModelDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        widget.text,
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
