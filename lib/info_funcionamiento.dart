import 'package:flutter/material.dart';
import 'fondo_legal.dart'; // importa el widget del fondo
import 'menu_superior.dart';
import 'ayuda_fab.dart';

class InfoFuncionamientoPage extends StatefulWidget {
  @override
  State<InfoFuncionamientoPage> createState() => _InfoFuncionamientoPageState();
}

class _InfoFuncionamientoPageState extends State<InfoFuncionamientoPage> {
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
                    '¿Cómo funciona Pelícano?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 14),
                  _infoPunto('1. Registro y presentación de la causa',
                      'Para iniciar una nueva causa, es imprescindible registrarse en la plataforma. Durante este proceso, se solicitarán datos personales y documentación probatoria que permita la verificación y análisis del caso. Aunque la recopilación de información personal es necesaria, el demandante podrá optar por mantener el anonimato en la causa mediante la activación de una opción específica en el formulario de registro.'
                  ),
                  _infoPunto('2. Consulta de causas existentes',
                      'Antes de registrar una nueva causa, se recomienda revisar las causas ya abiertas para verificar si su situación puede incorporarse a una demanda en curso. En caso de dudas, puede contactarnos a través del cuestionario habilitado para tal fin.'
                  ),
                  _infoPunto('3. Evaluación preliminar',
                      'Una vez recibido y analizado su caso, se le informará sobre la viabilidad jurídica de la demanda, así como el rango estimado de costes (mínimo y máximo). En función de estos parámetros y del número de demandantes involucrados, se le presentarán tres alternativas de acción posibles.'
                  ),
                  _infoPunto('4. Revisión de minuta y costes asociados',
                      'Lea detenidamente la minuta que Pelícano emitirá, la cual detalla los conceptos correspondientes al pago por la gestión administrativa, los servicios legales prestados y los procesos judiciales involucrados. Para mayor claridad, consulte el cuadro de costos disponible en la plataforma.'
                  ),
                  _infoPunto('5. Seguimiento del proceso',
                      'Manténgase informado del estado de su demanda colectiva, plazos importantes y actualizaciones de nuestro equipo legal a través de la sección "Demandas Iniciadas".'
                  ),
                  _infoPunto('6. Pagos Finales y Victoria',
                      'En caso de una victoria económica en la demanda, se le informará detalladamente sobre la distribución de las compensaciones y los pasos a seguir para recibir su parte, una vez deducidos los honorarios y gastos legales acordados.'
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: Text(
                      'Nuestro objetivo es simplificar el proceso legal y maximizar el impacto de tu voz.',
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
                _botonMinimalista(context, 'Cómo funciona', Icons.info_outline, () {}),
                _botonMinimalista(context, 'Abrir caso de demanda', Icons.add_box, () {}),
                _botonMinimalista(context, 'Demandas iniciadas', Icons.assignment_turned_in, () {}),
              ],
            ),
          ),
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Center(
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 15,
                    fontFamily: "Lato",
                  ),
                  children: [
                    TextSpan(
                      text:
                      'Si eres un Bufette o un Autónomo y quieres representar alguna de nuestras causas o colaborar con nosotros, haz click ',
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => RegistroProfesionalesPage()));
                        },
                        child: Text(
                          'aquí',
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
