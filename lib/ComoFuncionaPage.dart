import 'package:flutter/material.dart';
import 'fondo_legal.dart'; // mismo fondo
import 'menu_superior.dart';

class ComoFuncionaPage extends StatefulWidget {
  @override
  State<ComoFuncionaPage> createState() => _ComoFuncionaPageState();
}

class _ComoFuncionaPageState extends State<ComoFuncionaPage> {
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
          onIdiomaChange: (nuevoIdioma) =>
              setState(() => idiomaActual = nuevoIdioma),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      '¿Cómo funciona?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 14),
                    _infoPunto(
                        '1. Infórmate primero',
                        'Busca en la app si ya existe una causa similar. Si la encuentras, puedes unirte directamente. Si no existe, pasa al siguiente paso.'),
                    _infoPunto(
                        '2. Inicia tu caso',
                        'Envía un email con tu situación y pruebas, o rellena el formulario en la app. El registro es obligatorio: nombre completo, fecha de nacimiento y DNI (particulares) o datos de empresa y administrador (empresas).'),
                    _infoPunto(
                        '3. Análisis legal',
                        'Un equipo de asesores revisa la viabilidad del caso. Te informarán de costes mínimos y máximos, tiempo estimado, pruebas necesarias y posibilidades de éxito.'),
                    _infoPunto(
                        '4. Opciones de financiación',
                        'Se proponen tres escenarios según número de personas y plazo. Al coste se añade un 10% de gestión (mínimo 3 €). Si no se alcanza el objetivo, se devuelve la aportación menos los gastos. Aportaciones extra se consideran donación solidaria.'),
                    _infoPunto(
                        '5. Únete o sigue tu causa',
                        'Consulta el estado del proceso, el importe recaudado y la información de los demandantes (respetando anonimato). Para unirte, regístrate y realiza la aportación inicial.'),
                    SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Pelícano convierte la unión en acción legal organizada, clara y transparente.',
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
            // Footer con espacio + botones + frase con enlace
            Column(
              children: [
                SizedBox(height: 16), // espacio extra antes de los botones
                Container(
                  color: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _botonMinimalista(
                        context,
                        'Instrucciones',
                        Icons.list_alt,
                        () {
                          Navigator.pushNamed(context, '/recomendaciones');
                        },
                      ),
                      _botonMinimalista(
                        context,
                        'Abrir caso de demanda',
                        Icons.add_box,
                        () {
                          // aún no implementado
                        },
                      ),
                      _botonMinimalista(
                        context,
                        'Demandas iniciadas',
                        Icons.assignment_turned_in,
                        () {
                          // aún no implementado
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12), // espacio entre botones y frase
                Container(
                  color: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 15,
                          fontFamily: "Lato",
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 15,
                                  fontFamily: "Lato",
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
              ],
            ),
          ],
        ),
        // Eliminado floatingActionButton
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

  Widget _botonMinimalista(
      BuildContext context, String texto, IconData icono, VoidCallback onTap) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
