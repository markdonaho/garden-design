import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/garden_models.dart';
import '../providers/garden_provider.dart';
import 'bed_editor_screen.dart';

class GardenEditorScreen extends StatefulWidget {
  final Garden garden;

  const GardenEditorScreen({super.key, required this.garden});

  @override
  _GardenEditorScreenState createState() => _GardenEditorScreenState();
}

class _GardenEditorScreenState extends State<GardenEditorScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.garden.name);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GardenProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Garden'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              provider.deleteGarden(widget.garden.id);
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final updatedGarden = Garden(
                id: widget.garden.id,
                name: _nameController.text,
                beds: widget.garden.beds,
              );
              provider.updateGarden(updatedGarden);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Garden Name'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Beds', style: Theme.of(context).textTheme.titleLarge),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Bed'),
                  onPressed: () async {
                    final newBed = await Navigator.of(context).push<Bed>(
                      MaterialPageRoute(
                        builder: (context) => const BedEditorScreen(),
                      ),
                    );
                    if (newBed != null) {
                      provider.addBedToGarden(widget.garden.id, newBed);
                    }
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.garden.beds.length,
                itemBuilder: (context, index) {
                  final bed = widget.garden.beds[index];
                  return ListTile(
                    title: Text(bed.name),
                    trailing: const Icon(Icons.edit),
                    onTap: () async {
                      final updatedBed = await Navigator.of(context).push<Bed>(
                        MaterialPageRoute(
                          builder: (context) => BedEditorScreen(initialBed: bed),
                        ),
                      );
                      if (updatedBed != null) {
                        provider.updateBedInGarden(widget.garden.id, updatedBed);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
