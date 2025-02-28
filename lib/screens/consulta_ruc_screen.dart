import 'package:flutter/material.dart';
import '../core/api/ruc_service.dart';
import '../models/ruc_model.dart';

class ConsultaRucScreen extends StatefulWidget {
  @override
  _ConsultaRucScreenState createState() => _ConsultaRucScreenState();
}

class _ConsultaRucScreenState extends State<ConsultaRucScreen> {
  final TextEditingController rucController = TextEditingController();
  RucModel? rucData;
  bool isLoading = false;

  final RucService rucService = RucService();

  void consultarRuc() async {
    setState(() {
      isLoading = true;
      rucData = null;
    });

    final response = await rucService.getRuc(rucController.text);

    if (response != null) {
      setState(() {
        rucData = RucModel.fromJson(response);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("RUC no encontrado o Error en la API")),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Consulta RUC")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: rucController,
              decoration: InputDecoration(
                labelText: "Número de RUC",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 11,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: consultarRuc,
              child: Text("Consultar"),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (rucData != null) ...[
              Text("Razón Social: ${rucData!.razonSocial}"),
              Text("Estado: ${rucData!.estado}"),
              Text("Condición: ${rucData!.condicion}"),
              Text("Dirección: ${rucData!.direccion}"),
            ],
          ],
        ),
      ),
    );
  }
}
