import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/bloc/portafolio_bloc.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/widgets/main_data.dart';
import 'package:portafolio_yasmin/utils/menu_item.dart';
import 'package:portafolio_yasmin/utils/load_image.dart';

class PortafolioLayout extends StatelessWidget {
  const PortafolioLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PortfolioBloc>();

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: const Color(0xFF3B2366),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoadImage(
                  path: 'avatar',
                  ext: 'jpeg',
                  fit: BoxFit.contain,
                ),
                // Image.asset('avatar.jpeg'),
                const SizedBox(height: 20),
                MenuItem(
                  title: 'Jorge Grullón',
                  items: bloc.listMenuItem,
                  scrollController: bloc.scrollController,
                ),
              ],
            ),
          ),
        ),
        const Expanded(
          flex: 4,
          child: MainDataWidget(),
        ),
      ],
    );
  }
}
