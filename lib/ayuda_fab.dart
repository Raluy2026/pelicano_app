import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AyudaFab extends StatelessWidget {
  const AyudaFab({Key? key}) : super(key: key);

  void mostrarDialogo(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54, // oscurece el fondo detrás del pop-up
      builder: (context) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF154360), // Azul petróleo
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white, // ribete blanco
                    width: 1.2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "¿Necesitas orientación?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lato-Bold",
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Si no encuentras una causa abierta o tienes dudas, escríbenos a ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Lato-Regular",
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Uri mailUrl = Uri(
                          scheme: 'mailto',
                          path: 'consulta@pelicano.es',
                        );
                        if (await canLaunchUrl(mailUrl)) {
                          await launchUrl(mailUrl);
                        }
                      },
                      child: const Text(
                        "consulta@pelicano.es",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontFamily: "Lato-Bold",
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "explicando tu caso. Nuestro grupo de asesores te dirá si puedes sumarte a una causa existente o cómo abrir una nueva.",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Lato-Regular",
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: const Text(
                          "Cerrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Lato-Bold",
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF154360),
      onPressed: () => mostrarDialogo(context),
      child: const Icon(Icons.help_outline, color: Colors.white),
      tooltip: "Ayuda",
    );
  }
}
