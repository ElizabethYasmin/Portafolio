import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portafolio_yasmin/core/di/injection_container.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/bloc/person_bloc.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/pages/splash_screen.dart';

/// Punto de entrada de la aplicación
/// Inicializa dependencias y configura el tema
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar inyección de dependencias
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Proveer PersonBloc a toda la aplicación
      create: (_) => sl<PersonBloc>(),
      child: MaterialApp(
        title: 'Elizabeth Yasmin - Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF667eea),
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
