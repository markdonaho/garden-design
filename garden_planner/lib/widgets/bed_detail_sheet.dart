// lib/widgets/bed_detail_sheet.dart

import 'package:flutter/material.dart';
import '../models/garden_models.dart';

class BedDetailSheet extends StatelessWidget {
  final Bed bed;

  const BedDetailSheet({super.key, required this.bed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.grass,
                  size: 32,
                  color: Colors.green[700],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    bed.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSectionHeader(context, 'Soil Information', Icons.science_outlined),
                  _buildSoilInfo(context),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, 'Crops (${bed.crops.length})', Icons.local_florist),
                  _buildCropsList(context),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, 'Quick Actions', Icons.touch_app),
                  _buildQuickActions(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.green[700], size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoilInfo(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildInfoRow('Composition', bed.soil.composition),
            const Divider(),
            _buildInfoRow('Last Amended', bed.soil.lastAmended),
            const Divider(),
            _buildInfoRow('Notes', bed.soil.notes),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCropsList(BuildContext context) {
    if (bed.crops.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'No crops planted yet',
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bed.crops.length,
      itemBuilder: (BuildContext context, int index) {
        final Crop crop = bed.crops[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[100],
              child: Text(
                crop.name[0].toUpperCase(),
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              '${crop.name} (${crop.variety})',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('Planted: ${crop.plantingDate}'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'x${crop.quantity}',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add crop functionality coming soon!')),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Crop'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit bed functionality coming soon!')),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Bed'),
          ),
        ),
      ],
    );
  }
}


