// lib/screens/garden_layout_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/garden_provider.dart';
import '../models/garden_models.dart';
import '../widgets/bed_detail_sheet.dart';

class GardenLayoutView extends StatelessWidget {
  const GardenLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GardenProvider>(
      builder: (BuildContext context, GardenProvider gardenProvider, Widget? child) {
        if (gardenProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (gardenProvider.beds.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.grass, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No garden beds yet', style: TextStyle(fontSize: 18)),
                Text('Add your first bed to get started', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        final double width = MediaQuery.of(context).size.width;
        final int crossAxisCount = width < 600
            ? 1
            : (width < 900
                ? 2
                : 3);

        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.9,
          ),
          itemCount: gardenProvider.beds.length,
          itemBuilder: (BuildContext context, int index) {
            final Bed bed = gardenProvider.beds[index];
            return _buildBedCard(context, bed);
          },
        );
      },
    );
  }

  Widget _buildBedCard(BuildContext context, Bed bed) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.8,
                child: BedDetailSheet(bed: bed),
              );
            },
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.grass,
                    size: 32,
                    color: Colors.green[700],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      bed.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '${bed.crops.length} crops',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Last amended: ${bed.soil.lastAmended}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Tap for details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


