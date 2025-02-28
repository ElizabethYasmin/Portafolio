import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/bloc/portafolio_bloc.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final List<String> items;
  final ScrollController scrollController;

  const MenuItem({
    super.key,
    required this.title,
    required this.items,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PortfolioBloc>();

    return Container(
      color: const Color(0xFF3B2366),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...bloc.listMenuItem.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final item = entry.value;

              return GestureDetector(
                onTap: () => bloc.scrollToItem(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
