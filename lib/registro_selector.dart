import 'package:flutter/material.dart';
import 'menu_superior.dart';
import 'custom_radios.dart';
import 'fondo_legal.dart'; // importa el widget del fondo
import 'registrousuariopage.dart';
import 'registroprofesionalpage.dart';
import 'ayuda_fab.dart';

class RegistroSelectorPage extends StatefulWidget {
  @override
  State<RegistroSelectorPage> createState() => _RegistroSelectorPageState();
}

class _RegistroSelectorPageState extends State<RegistroSelectorPage> {
  String? tipoSeleccionado; // "particular" o "profesional"
  String? subtipoProfesional; // "autonomo" o "bufete"
  String idiomaActual = 'Castellano';
  final bool loggedIn = false; // Actualiza en tu lógica real

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "¿Qué tipo de usuario eres?",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Lato-Bold",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _radioOpcion("particular", "Usuario Particular"),
            SizedBox(height: 10),
            _radioOpcion("profesional", "Usuario Profesional"),
            if (tipoSeleccionado == "profesional") ...[
              SizedBox(height: 24),
              Text(
                "¿Qué clase de profesional?",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Lato-Bold",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              _radioSubOpcion("autonomo", "Abogado Autónomo / Personal"),
              SizedBox(height: 7),
              _radioSubOpcion("bufete", "Despacho / Bufete"),
            ],
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _continuar,
                child: Text(
                  "Continuar",
                  style: TextStyle(
                    fontFamily: "Lato-Bold",
                    color: const Color(0xFF154360),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _radioOpcion(String valor, String texto) {
    return InkWell(
      onTap: () => setState(() => tipoSeleccionado = valor),
      child: Row(
        children: [
          CustomCheckCircle(
            checked: tipoSeleccionado == valor,
            onTap: () => setState(() => tipoSeleccionado = valor),
          ),
          SizedBox(width: 10),
          Text(
            texto,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: "Lato-Regular",
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _radioSubOpcion(String valor, String texto) {
    return InkWell(
      onTap: () => setState(() => subtipoProfesional = valor),
      child: Row(
        children: [
          CustomCheckCircle(
            checked: subtipoProfesional == valor,
            onTap: () => setState(() => subtipoProfesional = valor),
          ),
          SizedBox(width: 10),
          Text(
            texto,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: "Lato-Regular",
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _continuar() {
    if (tipoSeleccionado == "particular") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RegistroUsuarioPage()),
      );
    } else if (tipoSeleccionado == "profesional" && subtipoProfesional != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RegistroProfesionalPage(subtipo: subtipoProfesional!),
        ),
      );
    }
  }
}
