import 'package:flutter/material.dart';
import 'fondo_legal.dart'; // importa el widget del fondo
import 'menu_superior.dart';
import 'ayuda_fab.dart';

class QuienesSomosPage extends StatefulWidget {
  @override
  State<QuienesSomosPage> createState() => _QuienesSomosPageState();
}

class _QuienesSomosPageState extends State<QuienesSomosPage> {
  String idiomaActual = 'Castellano';
  final bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FondoLegal(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MenuSuperior(
          loggedIn: loggedIn,
          onLogout: () {},
          idiomaActual: idiomaActual,
          onIdiomaChange: (nuevoIdioma) => setState(() => idiomaActual = nuevoIdioma),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      '¿Quiénes somos?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 14),
                    _infoPunto('Nuestra comunidad',
                        'Somos una comunidad que nace con un propósito sencillo: unir personas, abogados y gente solidaria en torno a causas comunes. Creemos que cuando compartimos experiencias y nos organizamos, podemos transformar la indignación en acción real.'
                    ),
                    _infoPunto('Qué hacemos',
                        'Nuestra app conecta a quienes sufren un mismo problema con profesionales legales y con otros ciudadanos dispuestos a colaborar. Facilitamos la creación de demandas colectivas, ofreciendo procesos claros, documentación ordenada y acompañamiento en cada paso.'
                    ),
                    _infoPunto('Cómo trabajamos',
                        'La confianza es nuestra base: protección de datos, comunicación segura y transparencia en todo momento. Aquí puedes aportar tu testimonio, sumar evidencia, invitar a más afectados o colaborar como voluntario. Siempre con soporte humano y guías sencillas para que nadie se quede atrás.'
                    ),
                    _infoPunto('Nuestra meta',
                        'Queremos que las causas individuales se conviertan en movimientos colectivos capaces de abrir vías legales y lograr resultados. Si compartes esta visión, crea tu perfil, busca tu causa y únete. Porque juntos, las cosas avanzan.'
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Nuestro objetivo es dar confianza y convertir la unión en resultados reales.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 48),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _botonMinimalista(context, 'Quiénes somos', Icons.group, () {}),
                  _botonMinimalista(context, 'Abrir caso de demanda', Icons.add_box, () {}),
                  _botonMinimalista(context, 'Demandas iniciadas', Icons.assignment_turned_in, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoPunto(String titulo, String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: "Lato",
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2),
          Text(
            texto,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontFamily: "Lato",
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonMinimalista(BuildContext context, String texto, IconData icono, VoidCallback onTap) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, color: Colors.white, size: 22),
            SizedBox(height: 2),
            Text(
              texto,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Lato",
                fontWeight: FontWeight.w500,
                fontSize: 11,
                letterSpacing: 0.1,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
