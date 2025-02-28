class DniModel {
  final String dni;
  final String nombres;
  final String apellidoPaterno;
  final String apellidoMaterno;

  DniModel({
    required this.dni,
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
  });

  // Convertir JSON a objeto Dart
  factory DniModel.fromJson(Map<String, dynamic> json) {
    return DniModel(
      dni: json['dni'],
      nombres: json['nombres'],
      apellidoPaterno: json['apellidoPaterno'],
      apellidoMaterno: json['apellidoMaterno'],
    );
  }
}
