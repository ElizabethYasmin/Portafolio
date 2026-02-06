import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portafolio_yasmin/core/di/injection_container.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/bloc/person_bloc.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/bloc/person_event.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/bloc/person_state.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/pages/home_page.dart';

/// Pantalla inicial - Splash Screen
/// Carga información de la RENIEC y navega al portfolio
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadPersonData();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  void _loadPersonData() {
    // Cargar datos de ejemplo (puedes cambiar el RUC)
    context.read<PersonBloc>().add(
          const LoadPersonByRucEvent('10722530921'),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFFf093fb),
            ],
          ),
        ),
        child: BlocConsumer<PersonBloc, PersonState>(
          listener: (context, state) {
            if (state is PersonLoaded) {
              // Navegar al home después de cargar
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => HomePage(person: state.person),
                    ),
                  );
                }
              });
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo animado
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 80,
                          color: Color(0xFF667eea),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Título
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      'Elizabeth Yasmin',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      'Desarrolladora Flutter',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Estado de carga
                  if (state is PersonLoading)
                    Column(
                      children: [
                        const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        const SizedBox(height: 20),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: const Text(
                            'Cargando información...',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                  // Error
                  if (state is PersonError)
                    Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 50,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _loadPersonData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF667eea),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                          ),
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),

                  // Éxito
                  if (state is PersonLoaded)
                    Column(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 50,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '¡Bienvenido!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
