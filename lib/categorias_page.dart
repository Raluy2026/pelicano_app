// lib/pages/categorias_page.dart
import 'package:flutter/material.dart';
import 'causa_service.dart';
import 'fondo_legal.dart';
import 'menu_superior.dart';

/// Pantalla principal de categorías
class CategoriasPage extends StatelessWidget {
  final String nombreUsuario;
  const CategoriasPage({super.key, required this.nombreUsuario});

  static final categorias = [
    'Bancos',
    'Aseguradoras',
    'Empresas Privadas',
    'Entidades públicas',
    'Partidos Políticos',
    'Individuo Particular',
    'ONGs',
    'Telefonía y Comunicaciones',
    'Alimentación',
    'Suministros Básicos',
  ];

  @override
  Widget build(BuildContext context) {
    return FondoLegal(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MenuSuperior(
          loggedIn: true,
          idiomaActual: 'Castellano',
          onLogout: () {},
          onIdiomaChange: (_) {},
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Causas abiertas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bienvenido, $nombreUsuario',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Seleccione una categoría para consultar las causas abiertas relacionadas.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GridView.builder(
                  itemCount: categorias.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    final categoria = categorias[index];
                    return _categoriaButton(
                      context,
                      categoria,
                      'assets/categorias/${categoria.toLowerCase().replaceAll(" ", "_")}.jpg',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoriaButton(BuildContext context, String texto, String imagePath) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListaCausasPage(categoria: texto),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Text(
            texto,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Lato",
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

/// Pantalla de lista de causas
class ListaCausasPage extends StatelessWidget {
  final String categoria;
  const ListaCausasPage({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoria)),
      body: FutureBuilder<Map<String, List<Causa>>>(
        future: CausaService.cargarCausas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar causas.'));
          }

          final causas = snapshot.data?[categoria] ?? [];
          if (causas.isEmpty) {
            return const Center(child: Text('No hay causas abiertas en esta categoría.'));
          }

          return ListView.builder(
            itemCount: causas.length,
            itemBuilder: (context, i) {
              final causa = causas[i];
              return Card(
                child: ListTile(
                  title: Text(causa.titulo),
                  subtitle: Text('Estado: ${causa.estado}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalleCausaPage(causa: causa),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Pantalla de detalle de causa
class DetalleCausaPage extends StatelessWidget {
  final Causa causa;
  const DetalleCausaPage({super.key, required this.causa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(causa.titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estado: ${causa.estado}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              causa.descripcion,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
