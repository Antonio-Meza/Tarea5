import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(PCInventoryApp());
}

class PCInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Inventario de PCs',
      theme: ThemeData(primaryColor: Colors.blueGrey),
      home: DashboardScreen(),
    );
  }
}
