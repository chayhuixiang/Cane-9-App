import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditButton({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      radius: 14,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: const Icon(Icons.edit),
        color: Colors.white,
        iconSize: 18,
      ),
    );
  }
}
