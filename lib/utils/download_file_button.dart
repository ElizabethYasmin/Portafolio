import 'package:flutter/material.dart';

class DownloadFileButton extends StatelessWidget {
  const DownloadFileButton({
    super.key,
    required this.buttonText,
    required this.backgroundColor,
    required this.onPressed,
  });

  final String buttonText;
  final Color backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Text(buttonText),
    );
  }
}
