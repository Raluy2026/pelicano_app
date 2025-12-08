import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'categorias_page.dart'; // ✅ importa la página de categorías

class MenuSuperior extends StatelessWidget implements PreferredSizeWidget {
  final bool loggedIn;
  final VoidCallback onLogout;
  final String idiomaActual;
  final Function(String) onIdiomaChange;

  const MenuSuperior({
    required this.loggedIn,
    required this.onLogout,
    required this.idiomaActual,
    required this.onIdiomaChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: const _HamburguesaMenu(), // Menú hamburguesa
      centerTitle: true,
      title: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/pelicano_logo.png',
              width: 42,
              height: 42,
            ),
          ),
        ],
      ),
      actions: [
        const AyudaIconoMini(),
        const SizedBox(width: 3),
        _UserMenu(loggedIn: loggedIn, onLogout: onLogout),
        const SizedBox(width: 3),
        _IdiomaMenu(idiomaActual: idiomaActual, onChange: onIdiomaChange),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HamburguesaMenu extends StatelessWidget {
  const _HamburguesaMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: Colors.white),
      tooltip: 'Menú principal',
      onSelected: (value) {
        if (value == 'inicio') {
          Navigator.of(context).pushReplacementNamed('/');
        }
        if (value == 'quienes') {
          Navigator.pushNamed(context, '/quienes');
        }
        if (value == 'funciona') {
          Navigator.pushNamed(context, '/como_funciona');
        }
        if (value == 'instrucciones') {
          Navigator.pushNamed(context, '/recomendaciones');
        }
        if (value == 'casos') {
          // ✅ “Casos Abiertos” abre CategoriasPage con transición RTL consistente
          Navigator.of(context).push(
            _rtlRoute(const CategoriasPage(nombreUsuario: 'David')),
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'inicio',
          child: Row(
            children: const [
              Icon(Icons.home, color: Color(0xFF154360), size: 20),
              SizedBox(width: 10),
              Text('Inicio', style: TextStyle(fontFamily: "Lato-Regular")),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'quienes',
          child: Row(
            children: const [
              Icon(Icons.info, color: Color(0xFF154360), size: 20),
              SizedBox(width: 10),
              Text('Quiénes somos', style: TextStyle(fontFamily: "Lato-Regular")),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'casos',
          child: Row(
            children: const [
              Icon(Icons.folder_open, color: Color(0xFF154360), size: 20),
              SizedBox(width: 10),
              Text('Casos Abiertos', style: TextStyle(fontFamily: "Lato-Regular")),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'funciona',
          child: Row(
            children: const [
              Icon(Icons.help_outline, color: Color(0xFF154360), size: 20),
              SizedBox(width: 10),
              Text('Cómo funciona', style: TextStyle(fontFamily: "Lato-Regular")),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'instrucciones',
          child: Row(
            children: const [
              Icon(Icons.list_alt, color: Color(0xFF154360), size: 20),
              SizedBox(width: 10),
              Text('Instrucciones', style: TextStyle(fontFamily: "Lato-Regular")),
            ],
          ),
        ),
      ],
    );
  }
}

// 🔄 Ruta con transición derecha→izquierda + fade, 250 ms, curva easeOutCubic
Route _rtlRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final slide = Tween<Offset>(
        begin: const Offset(1.0, 0.0), // entra desde la derecha
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);

      final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);

      return SlideTransition(
        position: slide,
        child: FadeTransition(opacity: fade, child: child),
      );
    },
  );
}

class _IdiomaMenu extends StatelessWidget {
  final String idiomaActual;
  final Function(String) onChange;

  const _IdiomaMenu({required this.idiomaActual, required this.onChange, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language, color: Colors.white, size: 22),
      tooltip: 'Idioma',
      initialValue: idiomaActual,
      onSelected: onChange,
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'Català', child: Text('Català', style: TextStyle(fontFamily: "Lato-Regular"))),
        PopupMenuItem(value: 'Castellano', child: Text('Castellano', style: TextStyle(fontFamily: "Lato-Regular"))),
        PopupMenuItem(value: 'Euskera', child: Text('Euskera', style: TextStyle(fontFamily: "Lato-Regular"))),
        PopupMenuItem(value: 'Galego', child: Text('Galego', style: TextStyle(fontFamily: "Lato-Regular"))),
      ],
    );
  }
}

class _UserMenu extends StatelessWidget {
  final bool loggedIn;
  final VoidCallback onLogout;

  const _UserMenu({required this.loggedIn, required this.onLogout, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.person, color: Colors.white, size: 23),
      tooltip: loggedIn ? 'Opciones de usuario' : 'Identifícate',
      onSelected: (value) {
        if (value == 'logout') {
          onLogout();
        } else if (value == 'registrarse') {
          Navigator.pushNamed(context, '/registro');
        } else if (value == 'login') {
          Navigator.pushNamed(context, '/login');
        }
      },
      itemBuilder: (context) => loggedIn
          ? [
              const PopupMenuItem(
                value: 'logout',
                child: Text(
                  'Logout',
                  style: TextStyle(fontFamily: "Lato-Regular", color: Color(0xFF154360)),
                ),
              ),
            ]
          : [
              const PopupMenuItem(
                value: 'registrarse',
                child: Text(
                  'Registrarse',
                  style: TextStyle(fontFamily: "Lato-Regular", color: Color(0xFF154360)),
                ),
              ),
              const PopupMenuItem(
                value: 'login',
                child: Text(
                  'Log-in',
                  style: TextStyle(fontFamily: "Lato-Regular", color: Color(0xFF154360)),
                ),
              ),
            ],
    );
  }
}

class AyudaIconoMini extends StatelessWidget {
  const AyudaIconoMini({Key? key}) : super(key: key);

  void mostrarDialogo(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C4A4E), // Azul petróleo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Colors.white, width: 1.2),
        ),
        elevation: 12,
        title: const Text(
          "¿Necesitas orientación?",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Lato-Bold",
            fontSize: 17,
          ),
        ),
        content: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: "Lato-Regular",
              fontSize: 14,
            ),
            children: [
              const TextSpan(
                text: "¿No encuentras la causa que buscas o tienes dudas sobre cómo y dónde abrir una nueva?\n\n",
              ),
              const TextSpan(text: "Escríbenos un email a "),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () async {
                    final Uri mailUrl = Uri(
                      scheme: 'mailto',
                      path: 'consulta@pelicano.es',
                    );
                    if (await canLaunchUrl(mailUrl)) {
                      await launchUrl(mailUrl);
                    }
                  },
                  child: const Text(
                    "consulta@pelicano.es",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontFamily: "Lato-Bold",
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const TextSpan(
                text: ", describiendo tu caso con el mayor detalle posible.\n\nNuestro equipo de asesores revisará tu situación y te indicará si puedes sumarte a una causa existente o te ayudará a crear tu propia causa.",
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cerrar", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help_outline, color: Colors.white70, size: 19),
      onPressed: () => mostrarDialogo(context),
      tooltip: "Ayuda",
      splashRadius: 18,
    );
  }
}
