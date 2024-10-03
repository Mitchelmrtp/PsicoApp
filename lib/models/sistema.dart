class Sistema {
  int id;
  String nombre;
  String version;

  Sistema({
    required this.id,
    required this.nombre,
    required this.version,
  });

  factory Sistema.fromJson(Map<String, dynamic> json) {
    return Sistema(
      id: json['id'],
      nombre: json['nombre'],
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'version': version,
    };
  }
}
