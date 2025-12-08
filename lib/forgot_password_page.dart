import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recuperar contraseña")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Introduce tu correo para restaurar la contraseña:"),
            SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Correo electrónico",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Enviar link de recuperación"),
              onPressed: () {
                // Aquí deberías llamar a tu backend para enviar el correo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Se ha enviado un link a tu correo")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
