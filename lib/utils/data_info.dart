import 'package:flutter/material.dart';

class DataInfo extends StatelessWidget {
  const DataInfo({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF3B2366),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white).copyWith(
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            content,
            style: const TextStyle(color: Colors.white).copyWith(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
