import 'package:flutter/material.dart';
import '../models/garden_models.dart';

class BedEditorScreen extends StatefulWidget {
  final Bed? initialBed;

  const BedEditorScreen({super.key, this.initialBed});

  @override
  _BedEditorScreenState createState() => _BedEditorScreenState();
}

class _BedEditorScreenState extends State<BedEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _compositionController;
  late TextEditingController _lastAmendedController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialBed?.name ?? '');
    _compositionController = TextEditingController(text: widget.initialBed?.soil.composition ?? '');
    _lastAmendedController = TextEditingController(text: widget.initialBed?.soil.lastAmended ?? '');
    _notesController = TextEditingController(text: widget.initialBed?.soil.notes ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialBed == null ? 'Add New Bed' : 'Edit Bed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Bed Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 24),
              Text('Soil Details',
                  style: Theme.of(context).textTheme.titleLarge),
              TextFormField(
                controller: _compositionController,
                decoration: const InputDecoration(labelText: 'Composition (e.g., 50% Loam, 50% Compost)'),
              ),
              TextFormField(
                controller: _lastAmendedController,
                decoration: const InputDecoration(labelText: 'Last Amended Date'),
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Soil Notes'),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newBed = Bed(
        id: widget.initialBed?.id ?? 'bed_${DateTime.now().millisecondsSinceEpoch}',
        name: _nameController.text,
        soil: Soil(
          composition: _compositionController.text,
          lastAmended: _lastAmendedController.text,
          notes: _notesController.text,
        ),
        crops: widget.initialBed?.crops ?? [],
      );
      Navigator.of(context).pop(newBed);
    }
  }
}
