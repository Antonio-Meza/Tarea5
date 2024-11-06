import 'package:flutter/material.dart';
import '../models/pc_model.dart';
import '../services/database_service.dart';
import 'pc_form_screen.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final DatabaseService _dbService = DatabaseService();

  Future<List<PCInventory>> _fetchComputers() async {
    return await _dbService.getComputers();
  }

  Future<void> _removeComputer(int id) async {
    await _dbService.deleteComputer(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventario de PCs')),
      body: FutureBuilder<List<PCInventory>>(
        future: _fetchComputers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el inventario'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay computadoras registradas'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pc = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    title: Text(pc.cpuType),
                    subtitle: Text('RAM: ${pc.ramSize}, Almacenamiento: ${pc.storageType}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => PCFormScreen(pc: pc),
                            ));
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeComputer(pc.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PCFormScreen(),
          ));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
