import 'package:flutter/material.dart';
import '../models/pc_model.dart';
import '../services/database_service.dart';

class PCFormScreen extends StatefulWidget {
  final PCInventory? pc;
  PCFormScreen({this.pc});

  @override
  _PCFormScreenState createState() => _PCFormScreenState();
}

class _PCFormScreenState extends State<PCFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _dbService = DatabaseService();

  late TextEditingController _cpuController;
  late TextEditingController _ramController;
  late TextEditingController _storageController;

  @override
  void initState() {
    super.initState();
    _cpuController = TextEditingController(text: widget.pc?.cpuType ?? '');
    _ramController = TextEditingController(text: widget.pc?.ramSize ?? '');
    _storageController = TextEditingController(text: widget.pc?.storageType ?? '');
  }

  Future<void> _savePC() async {
    if (_formKey.currentState!.validate()) {
      final newPC = PCInventory(
        id: widget.pc?.id,
        cpuType: _cpuController.text,
        ramSize: _ramController.text,
        storageType: _storageController.text,
      );
      if (widget.pc == null) {
        await _dbService.addPC(newPC);
      } else {
        await _dbService.updatePC(newPC);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pc == null ? 'Nueva PC' : 'Editar PC')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _cpuController,
                decoration: InputDecoration(labelText: 'Tipo de CPU'),
                validator: (value) => value!.isEmpty ? 'Ingrese el tipo de CPU' : null,
              ),
              TextFormField(
                controller: _ramController,
                decoration: InputDecoration(labelText: 'Tamaño de RAM'),
                validator: (value) => value!.isEmpty ? 'Ingrese el tamaño de RAM' : null,
              ),
              TextFormField(
                controller: _storageController,
                decoration: InputDecoration(labelText: 'Tipo de almacenamiento'),
                validator: (value) => value!.isEmpty ? 'Ingrese el tipo de almacenamiento' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePC,
                child: Text('Guardar Información'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
