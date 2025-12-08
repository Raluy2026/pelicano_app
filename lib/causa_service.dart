import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Causa {
  final String titulo;
  final String estado;
  final String descripcion;

  Causa({
    required this.titulo,
    required this.estado,
    required this.descripcion,
  });

  factory Causa.fromJson(Map<String, dynamic> json) {
    return Causa(
      titulo: json['titulo'],
      estado: json['estado'],
      descripcion: json['descripcion'],
    );
  }
}

class CausaService {
  static Future<Map<String, List<Causa>>> cargarCausas() async {
    final jsonString = await rootBundle.loadString('assets/data/causas.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    return jsonMap.map((categoria, lista) {
      final causas = (lista as List)
          .map((e) => Causa.fromJson(e as Map<String, dynamic>))
          .toList();
      return MapEntry(categoria, causas);
    });
  }
}
