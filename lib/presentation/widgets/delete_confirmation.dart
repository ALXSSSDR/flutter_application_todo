import 'package:flutter/material.dart';

class ConfirmationDeleteDialog extends StatelessWidget {
  final Function delFunc;
  final String objId;

  const ConfirmationDeleteDialog(
      {super.key, required this.delFunc, required this.objId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Подтвердите удаление',
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Отменить'),
        ),
        TextButton(
          onPressed: () {
            delFunc(objId);
            Navigator.of(context).pop();
          },
          child: const Text('Удалить'),
        )
      ],
    );
  }
}