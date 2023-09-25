import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  const CustomError({super.key, required this.messsage});

  final String messsage;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(messsage),
    );
  }
}