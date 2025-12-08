import 'package:flutter/material.dart';
import 'ComoFuncionaPage.dart'; // importa la buena
import 'registro_selector.dart';
import 'registrousuariopage.dart';
import 'registroprofesionalpage.dart';
import 'login_page.dart';
import 'recomendamos_orden_page.dart';
import 'quienessomospage.dart';

void main() {
  runApp(PelicanoApp());
}

class PelicanoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PELíCANO',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: const Color(0xFF154360),
        fontFamily: 'Lato',
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      // IMPORTANTE: sin 'routes', todo pasa por onGenerateRoute
      onGenerateRoute: (settings) {
        late final Widget page;
        switch (settings.name) {
          case '/login':
            page = LoginPage();
            break;
          case '/como_funciona':
            page = ComoFuncionaPage();
            break;
          case '/registro':
            page = RegistroSelectorPage();
            break;
          case '/recomendaciones':   // ✅ nueva ruta con argumento requerido
            page = RecomendamosOrdenPage(nombreUsuario: "Invitado");
            break;
          case '/quienes':
            page = QuienesSomosPage();
            break;
          default:
            page = HomePage();
        }

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide de derecha a izquierda + fade
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final slideTween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOutCubic));
            final slide = animation.drive(slideTween);

            final fade = animation.drive(CurveTween(curve: Curves.easeInOut));

            return SlideTransition(
              position: slide,
              child: FadeTransition(
                opacity: fade,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 900), // más lenta y elegante
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/FondoLegal.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/pelicano_logo.png',
                          width: 130,
                          height: 130,
                        ),
                        SizedBox(height: 36),
                        Text(
                          'PELíCANO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 22),
                        Text(
                          'Por una justicia colectiva, fácil y accesible.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Lato-Bold',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 9),
                        Text(
                          'Unidos somos más fuertes',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Lato-Bold',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          width: 220,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/como_funciona');
                            },
                            child: Text(
                              'Infórmate',
                              style: TextStyle(
                                color: const Color(0xFF154360),
                                fontSize: 21,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                            fontFamily: 'Lato',
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '¿Eres abogado o bufete y quieres sumarte a una de nuestras causas? ',
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/registro');
                                },
                                child: Text(
                                  'haz click aquí',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              ),
                            ),
                            TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
