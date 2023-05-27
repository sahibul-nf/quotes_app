import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String message, {bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isError ? Colors.red : const Color(0xff68B984),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
    ),
  );
}
