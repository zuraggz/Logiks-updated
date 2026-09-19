import 'package:flutter/material.dart';
import 'package:legos/models/lego_model.dart';
import 'package:legos/utils/validation.dart';
import 'package:legos/view_models/add_lego_model.dart';

class AddLegoView extends StatefulWidget {
  const AddLegoView({super.key});

  @override
  State<AddLegoView> createState() => _AddLegoViewState();
}

class _AddLegoViewState extends State<AddLegoView> {
  final _formKey = GlobalKey<FormState>();
  final _viewModel = AddLegoViewModel();

  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _piecesController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _yearController.dispose();
    _piecesController.dispose();
    _priceController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final lego = LegoModel(
      name: _nameController.text.trim(),
      yearOfCreation: int.parse(_yearController.text.trim()),
      numberOfPieces: int.parse(_piecesController.text.trim()),
      price: double.parse(_priceController.text.trim()),
    );

    final success = await _viewModel.addLego(lego);
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Lego added")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to add lego"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(7, 100, 176, 1),
        title: const Text(
          "Add Lego",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 100),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: validateName,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: "Year",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: validateYear,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _piecesController,
                decoration: const InputDecoration(
                  labelText: "Pieces",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: validatePieces,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: validatePrice,
              ),
              const SizedBox(height: 24),
              ListenableBuilder(
                listenable: _viewModel,
                builder: (context, child) => ElevatedButton(
                  onPressed: _viewModel.isSaving ? null : _save,
                  child: _viewModel.isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
