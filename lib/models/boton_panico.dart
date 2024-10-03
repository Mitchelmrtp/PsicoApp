class BotonPanico {
  int id;

  BotonPanico({
    required this.id,
  });

  factory BotonPanico.fromJson(Map<String, dynamic> json) {
    return BotonPanico(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
