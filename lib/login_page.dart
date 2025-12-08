import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'recomendamos_orden_page.dart'; // página de recomendaciones
import 'forgot_password_page.dart';   // nueva página de recuperación

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool cargando = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => cargando = true);

    final url = Uri.parse('http://localhost/login.php');
    final response = await http.post(
      url,
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    setState(() => cargando = false);

    if (response.statusCode == 200 && response.body.contains('Login correcto')) {
      // Simulamos que el backend devuelve el nombre del usuario
      final nombreUsuario = "David"; // aquí deberías parsear la respuesta real

      // Guardamos el nombre en memoria global (puedes usar Provider, Riverpod o similar)
      // Para simplificar, lo pasamos como argumento
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RecomendamosOrdenPage(nombreUsuario: nombreUsuario),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error de acceso"),
          content: Text("Usuario o contraseña incorrectos. Vuelve a intentarlo."),
          actions: [
            TextButton(
              child: Text("Cerrar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

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
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/pelicano_logo.png',
                      height: 90,
                    ),
                    const SizedBox(height: 35),
                    Text(
                      "PELíCANO",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lato-Bold",
                        fontSize: 27,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(height: 27),
                    _campoTexto(emailController, 'Email', keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 13),
                    _campoTexto(passwordController, 'Contraseña', ocultar: true),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ForgotPasswordPage()),
                          );
                        },
                        child: Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 27),
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
                        onPressed: cargando ? null : _login,
                        child: cargando
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF154360)))
                            : Text(
                                "Ingresar",
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
        ),
      ],
    );
  }

  Widget _campoTexto(TextEditingController controller, String label,
      {bool ocultar = false, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      obscureText: ocultar,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.black87, fontFamily: "Lato-Regular", fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white70,
        labelStyle: TextStyle(color: Colors.black54),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Campo requerido' : null,
    );
  }
}
