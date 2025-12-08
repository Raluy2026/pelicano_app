import 'package:flutter/material.dart';
import 'package:pelicano_app/ComoFuncionaPage.dart';
import 'package:pelicano_app/categorias_page.dart';
import 'package:pelicano_app/registro_selector.dart';
import 'package:pelicano_app/routes/app_routes.dart';
import 'fondo_legal.dart';
import 'menu_superior.dart';

class RecomendamosOrdenPage extends StatefulWidget {
  final String nombreUsuario;

  const RecomendamosOrdenPage({
    Key? key,
    required this.nombreUsuario,
  }) : super(key: key);

  @override
  State<RecomendamosOrdenPage> createState() => _RecomendamosOrdenPageState();
}

class _RecomendamosOrdenPageState extends State<RecomendamosOrdenPage> {
  String idiomaActual = 'Castellano';
  final bool loggedIn = true;

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    final aspectRatio = isWeb ? 2.4 : 1.9;

    return FondoLegal(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: false,
        appBar: MenuSuperior(
          loggedIn: loggedIn,
          onLogout: () {},
          idiomaActual: idiomaActual,
          onIdiomaChange: (nuevoIdioma) =>
              setState(() => idiomaActual = nuevoIdioma),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),

            // ✅ Encabezado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recomendaciones',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Bienvenido, ${widget.nombreUsuario.trim()}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lea bien el funcionamiento de la app, regístrese, consulte casos abiertos o cree uno nuevo. '
                    'Si es profesional o solidario utilice las 2 últimas casillas.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Grid minimalista con scroll seguro
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: aspectRatio,
                    children: [
                      _botonMinimalista(
                        texto: 'Cómo funciona',
                        icono: Icons.info_outline,
                        onTap: () => navigateTo(context, ComoFuncionaPage()),
                      ),
                      _botonMinimalista(
                        texto: 'Regístrate',
                        icono: Icons.person_add,
                        onTap: () => navigateTo(context, RegistroSelectorPage()),
                      ),
                      _botonMinimalista(
                        texto: 'Casos abiertos',
                        icono: Icons.assignment_outlined,
                        onTap: () => navigateTo(
                          context,
                          CategoriasPage(nombreUsuario: widget.nombreUsuario),
                        ),
                      ),
                      _botonMinimalista(
                        texto: 'Nuevo caso',
                        icono: Icons.add_box_outlined,
                        onTap: () {},
                      ),
                      _botonMinimalista(
                        texto: 'Profesionales',
                        icono: Icons.group_outlined,
                        onTap: () => navigateTo(context, RegistroSelectorPage()),
                      ),
                      _botonMinimalista(
                        texto: 'Aportaciones',
                        icono: Icons.volunteer_activism_outlined,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Botón minimalista refinado
  Widget _botonMinimalista({
    required String texto,
    required IconData icono,
    required VoidCallback onTap,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            texto,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Lato",
              fontWeight: FontWeight.w500,
              fontSize: 11,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
