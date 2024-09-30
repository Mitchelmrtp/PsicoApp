class EmotionService {
  // Simulación de una respuesta de datos emocionales desde la base de datos
  Future<Map<String, double>> fetchEmotionStats(String memberId) async {
    // Simulación de una espera, como si estuviera llamando a una API
    await Future.delayed(Duration(seconds: 2));

    // Datos emocionales simulados
    Map<String, double> dummyData = {
      'Feliz': 20,
      'Neutral': 15,
      'Triste': 25,
      'Ansioso': 10,
      'Irritado': 5,
      'Enojado': 25,
    };

    // Retornamos los datos simulados
    return dummyData;
  }
}
