// lib/screens/garden_layout_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/garden_models.dart';
import '../providers/garden_provider.dart';
import '../widgets/bed_detail_sheet.dart'; // Import for BedDetailSheet
import 'bed_editor_screen.dart';
import 'garden_editor_screen.dart';

class GardenLayoutView extends StatelessWidget {
  const GardenLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GardenProvider>(
        builder: (context, gardenProvider, child) {
          if (gardenProvider.areGardensLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gardenProvider.gardens.isEmpty) {
            return const Center(
              child:
                  Text('No gardens yet. Add one to get started!', style: TextStyle(fontSize: 18)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: gardenProvider.gardens.length,
            itemBuilder: (context, index) {
              final garden = gardenProvider.gardens[index];
              return _buildGardenCard(context, garden, gardenProvider);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGardenDialog(context),
        tooltip: 'Add New Garden',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGardenCard(
      BuildContext context, Garden garden, GardenProvider provider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  garden.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit ${garden.name}',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GardenEditorScreen(garden: garden),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Divider(height: 24.0),
            if (garden.beds.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: Text('No beds in this garden yet.')),
              )
            else
              ...garden.beds.map((bed) => _buildBedTile(context, bed)),
          ],
        ),
      ),
    );
  }

  Widget _buildBedTile(BuildContext context, Bed bed) {
    return ListTile(
      title: Text(bed.name),
      subtitle: Text('${bed.crops.length} crops planted'),
      leading: const Icon(Icons.grass),
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return FractionallySizedBox(
              heightFactor: 0.8,
              child: BedDetailSheet(bed: bed),
            );
          },
        );
      },
    );
  }

  void _showAddGardenDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create a New Garden'),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Garden Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  Provider.of<GardenProvider>(context, listen: false)
                      .addGarden(nameController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showAddBedDialog(
      BuildContext context, Garden garden, GardenProvider provider) {
    final TextEditingController bedNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a Bed to ${garden.name}'),
          content: TextField(
            controller: bedNameController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Bed Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (bedNameController.text.isNotEmpty) {
                  final newBed = Bed(
                    id: 'bed_${DateTime.now().millisecondsSinceEpoch}',
                    name: bedNameController.text,
                    soil: Soil(composition: '', lastAmended: '', notes: ''),
                    crops: [],
                  );
                  provider.addBedToGarden(garden.id, newBed);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Bed'),
            ),
          ],
        );
      },
    );
  }
}


