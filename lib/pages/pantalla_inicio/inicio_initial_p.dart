import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/pages/pantalla_inicio/controller/inicio_controller.dart';
import 'package:ulimagym/pages/pantalla_inicio/widgets/item_widget.dart';


class PantallaDeInicioInitialPage extends StatelessWidget {
  PantallaDeInicioController controller = Get.put(PantallaDeInicioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _buildAppointmentStack(),
              SizedBox(height: 20),
              _buildChartRow(),
              SizedBox(height: 20),
              _buildUserRow(),
              SizedBox(height: 20),
              _buildProgressChart(),
              SizedBox(height: 20),
              _buildSuggestionsRow(),
              SizedBox(height: 20),
              _buildTipsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  /// Stack de Citas
  Widget _buildAppointmentStack() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text("27", style: TextStyle(fontSize: 20)),
            Text("NOV", style: TextStyle(fontSize: 20)),
          ],
        ),
        Container(
          width: 180,
          padding: EdgeInsets.symmetric(horizontal: 34, vertical: 36),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text("28 NOV", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 4),
              Text("Reservar", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Column(
          children: [
            Text("29", style: TextStyle(fontSize: 20)),
            Text("NOV", style: TextStyle(fontSize: 20)),
          ],
        ),
      ],
    );
  }

  /// Fila de gráficos
  Widget _buildChartRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.pie_chart, size: 24, color: Colors.blue),
      ],
    );
  }

  /// Fila de usuario
  Widget _buildUserRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage("assets/images/user_profile.png"),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Usuario", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Progreso: 80%", style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  /// Fila de progreso
  Widget _buildProgressChart() {
    return Column(
      children: [
        CircularProgressIndicator(
          value: 0.8,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
        SizedBox(height: 8),
        Text("80% Nivel de progreso", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// Fila de sugerencias
  Widget _buildSuggestionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Sugerencias para ti", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Icon(Icons.more_horiz, color: Colors.blue),
      ],
    );
  }

  /// Cuadrícula de consejos
  Widget _buildTipsGrid() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.8,
        ),
        itemCount: controller.pantallaDeInicioInicialModelObj.value.tipsgridItemList.value.length,
        itemBuilder: (context, index) {
          var model = controller.pantallaDeInicioInicialModelObj.value.tipsgridItemList.value[index];
          return TipsgridItemWidget(model);
        },
      ),
    );
  }
}
