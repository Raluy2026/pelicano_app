import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'fondo_legal.dart'; // importa el widget del fondo
import 'menu_superior.dart';
import 'custom_radios.dart';
import 'ayuda_fab.dart';

class RegistroProfesionalPage extends StatefulWidget {
  final String subtipo; // "autonomo" o "bufete"

  const RegistroProfesionalPage({required this.subtipo});

  @override
  State<RegistroProfesionalPage> createState() => _RegistroProfesionalPageState();
}

class _RegistroProfesionalPageState extends State<RegistroProfesionalPage> {
  final _formKey = GlobalKey<FormState>();
  String idiomaActual = 'Castellano';
  final bool loggedIn = false;

  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bufeteController = TextEditingController();
  final licenciaController = TextEditingController();
  final contactoController = TextEditingController();
  final dniContactoController = TextEditingController();
  final colegiadoController = TextEditingController();
  final dniController = TextEditingController();
  final cifController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bufeteController.dispose();
    licenciaController.dispose();
    cifController.dispose();
    contactoController.dispose();
    dniContactoController.dispose();
    colegiadoController.dispose();
    dniController.dispose();
    super.dispose();
  }

  Future<void> registrarProfesional() async {
    final esBufete = widget.subtipo == "bufete";
    final url = Uri.parse('http://localhost/registro.php');
    Map<String, String> body;

    if (esBufete) {
      body = {
        'tipo_usuario': 'bufete',
        'nombre_despacho': nombreController.text,
        'cif': cifController.text,
        'persona_contacto': contactoController.text,
        'dni_contacto': dniContactoController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };
    } else {
      body = {
        'tipo_usuario': 'profesional',
        'nombre': nombreController.text,
        'numero_colegiado': colegiadoController.text,
        'dni_nie': dniController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };
    }

    final response = await http.post(
      url,
      body: body,
    );

    if (response.statusCode == 200 && response.body.contains('Registro exitoso')) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("¡Registro exitoso!"),
          content: Text("Haz clic aquí para iniciar sesión."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/login');
              },
              child: Text("Ingresar"),
            ),
          ],
        ),
      );
      nombreController.clear();
      emailController.clear();
      passwordController.clear();
      bufeteController.clear();
      licenciaController.clear();
      cifController.clear();
      contactoController.clear();
      dniContactoController.clear();
      colegiadoController.clear();
      dniController.clear();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en el registro: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool esBufete = widget.subtipo == "bufete";
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
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (esBufete)
                _campoTexto(nombreController, 'Nombre del Bufete')
              else
                _campoTexto(nombreController, 'Nombre'),
              SizedBox(height: 10),
              if (esBufete) ...[
                _campoTexto(cifController, 'CIF'),
                SizedBox(height: 10),
                _campoTexto(contactoController, 'Persona de contacto'),
                SizedBox(height: 10),
                _campoTexto(dniContactoController, 'DNI de la persona de contacto'),
              ] else ...[
                _campoTexto(colegiadoController, 'Número de colegiado'),
                SizedBox(height: 10),
                _campoTexto(dniController, 'DNI o NIE'),
              ],
              SizedBox(height: 10),
              _campoTexto(emailController, 'Email', keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10),
              _campoTexto(passwordController, 'Contraseña', ocultar: true),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      registrarProfesional();
                    }
                  },
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                      fontFamily: "Lato-Bold",
                      color: const Color(0xFF154360),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _campoTexto(TextEditingController controller, String label,
      {bool ocultar = false, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      obscureText: ocultar,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white, fontFamily: "Lato-Regular", fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70, fontFamily: "Lato-Regular"),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        isDense: true,
        contentPadding: EdgeInsets.only(bottom: 7),
      ),
      validator: (value) => (value == null || value.isEmpty) ? 'Campo requerido' : null,
    );
  }
}
