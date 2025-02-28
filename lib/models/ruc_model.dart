class RucModel {
  final String razonSocial;
  final String estado;
  final String condicion;
  final String direccion;

  RucModel({
    required this.razonSocial,
    required this.estado,
    required this.condicion,
    required this.direccion,
  });

  factory RucModel.fromJson(Map<String, dynamic> json) {
    return RucModel(
      razonSocial: json["razonSocial"] ?? "",
      estado: json["estado"] ?? "",
      condicion: json["condicion"] ?? "",
      direccion: json["direccion"] ?? "-",
    );
  }
}
