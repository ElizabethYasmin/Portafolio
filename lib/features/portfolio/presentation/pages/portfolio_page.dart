import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/bloc/portafolio_bloc.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/pages/portafolio_layout.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PortfolioBloc(),
      builder: (context, child) => const Scaffold(
        backgroundColor: Color(0xFF1B0D2B),
        body: PortafolioLayout(),
      ),
    );
  }
}
