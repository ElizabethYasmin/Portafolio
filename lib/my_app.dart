import 'package:flutter/material.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:portafolio_yasmin/utils/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YasminDev',
      theme: AppTheme.darkTheme,
      home: const PortfolioPage(),
    );
  }
}
