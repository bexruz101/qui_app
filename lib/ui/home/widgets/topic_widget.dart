import 'package:flutter/material.dart';

class Topics extends StatelessWidget {
  const Topics(
      {super.key,
      required this.mainTopic,
      required this.numberOfQuestions,
      required this.icon, required this.onTap});

  final String mainTopic;
  final int numberOfQuestions;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(mainTopic),
      trailing: Text(numberOfQuestions.toString()),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
