import 'package:flutter/material.dart';
import 'inventory_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio - Gestión de PCs')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InventoryScreen()),
          ),
          child: Text('BIENVENIDO a Inventario de Computadoras'),
        ),
      ),
    );
  }
}
