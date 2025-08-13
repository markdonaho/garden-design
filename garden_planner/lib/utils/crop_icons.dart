// garden_planner/lib/utils/crop_icons.dart

import 'package:flutter/material.dart';

/// A utility class for mapping crop names to specific icons.
class CropIcon {
  /// Returns an icon for a given crop name.
  ///
  /// This function uses a simple mapping to provide icons for common garden crops.
  /// It defaults to a generic plant icon if no specific match is found.
  static IconData getIconForCrop(String cropName) {
    final lowerCaseCropName = cropName.toLowerCase();

    // Mapping of crop names to icons
    const cropIconMap = {
      'tomato': Icons.local_florist, // Using florist for tomato flowers
      'basil': Icons.eco,
      'rosemary': Icons.eco,
      'cucumber': Icons.local_florist,
      'okra': Icons.local_florist,
      'nasturtium': Icons.local_florist,
      'pepper': Icons.local_restaurant, // Represents something edible
      'lettuce': Icons.grass,
      'carrot': Icons.arrow_downward, // Represents root vegetables
      'radish': Icons.arrow_downward,
      'onion': Icons.panorama_fish_eye, // Represents bulbs
      'garlic': Icons.panorama_fish_eye,
    };

    // Return the specific icon or a default one
    return cropIconMap[lowerCaseCropName] ?? Icons.grass;
  }
}
