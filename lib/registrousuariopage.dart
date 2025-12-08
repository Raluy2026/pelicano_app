import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'menu_superior.dart';
import 'fondo_legal.dart'; // importa el widget del fondo
import 'custom_radios.dart';
import 'ayuda_fab.dart';

class RegistroUsuarioPage extends StatefulWidget {
  @override
  State<RegistroUsuarioPage> createState() => _RegistroUsuarioPageState();
}

class _RegistroUsuarioPageState extends State<RegistroUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  bool anonimato = false;
  String idiomaActual = 'Castellano';
  final bool loggedIn = false;

  final nombreController = TextEditingController();
  final apellidosController = TextEditingController();
  final dniNieController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    apellidosController.dispose();
    dniNieController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> registrarUsuario() async {
    final url = Uri.parse('http://localhost/registro.php');
    final response = await http.post(
      url,
      body: {
        'tipo_usuario': 'particular',
        'nombre': nombreController.text,
        'apellidos': apellidosController.text,
        'dni_nie': dniNieController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'anonimato': anonimato ? '1' : '0',
      },
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
      apellidosController.clear();
      dniNieController.clear();
      emailController.clear();
      passwordController.clear();
      setState(() => anonimato = false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en el registro: ${response.body}')),
      );
    }
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _campoTexto(nombreController, 'Nombre'),
              SizedBox(height: 10),
              _campoTexto(apellidosController, 'Apellidos'),
              SizedBox(height: 10),
              _campoTexto(dniNieController, 'DNI o NIE'),
              SizedBox(height: 10),
              _campoTexto(emailController, 'Email', keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10),
              _campoTexto(passwordController, 'Contraseña', ocultar: true),
              SizedBox(height: 17),
              Row(
                children: [
                  CustomCheckCircle(
                    checked: anonimato,
                    onTap: () => setState(() => anonimato = !anonimato),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Deseo ser anónimo en estadísticas y publicaciones',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Lato-Regular",
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
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
                        registrarUsuario();
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
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        isDense: true,
        contentPadding: EdgeInsets.only(bottom: 7),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Campo requerido' : null,
    );
  }
}
