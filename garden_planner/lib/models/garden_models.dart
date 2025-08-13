// lib/models/garden_models.dart

class Crop {
  final String id;
  final String name;
  final String variety;
  final int quantity;
  final String plantingDate;

  Crop({
    required this.id,
    required this.name,
    required this.variety,
    required this.quantity,
    required this.plantingDate,
  });

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'] as String,
      name: json['name'] as String,
      variety: json['variety'] as String,
      quantity: json['quantity'] as int,
      plantingDate: json['planting_date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'variety': variety,
      'quantity': quantity,
      'planting_date': plantingDate,
    };
  }
}

class Soil {
  final String composition;
  final String lastAmended;
  final String notes;

  Soil({
    required this.composition,
    required this.lastAmended,
    required this.notes,
  });

  factory Soil.fromJson(Map<String, dynamic> json) {
    return Soil(
      composition: json['composition'] as String,
      lastAmended: json['last_amended'] as String,
      notes: json['notes'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'composition': composition,
      'last_amended': lastAmended,
      'notes': notes,
    };
  }
}

class Bed {
  final String id;
  final String name;
  final Soil soil;
  final List<Crop> crops;

  Bed({
    required this.id,
    required this.name,
    required this.soil,
    required this.crops,
  });

  factory Bed.fromJson(Map<String, dynamic> json) {
    final List<dynamic> cropList = json['crops'] as List<dynamic>;
    final List<Crop> crops = cropList.map((dynamic i) => Crop.fromJson(i as Map<String, dynamic>)).toList();

    return Bed(
      id: json['id'] as String,
      name: json['name'] as String,
      soil: Soil.fromJson(json['soil'] as Map<String, dynamic>),
      crops: crops,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'soil': soil.toJson(),
      'crops': crops.map((crop) => crop.toJson()).toList(),
    };
  }
}

class GardenTask {
  final String id;
  final String description;
  final String dueDate;
  bool isCompleted;

  GardenTask({
    required this.id,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });

  factory GardenTask.fromJson(Map<String, dynamic> json) {
    return GardenTask(
      id: json['id'] as String,
      description: json['description'] as String,
      dueDate: json['due_date'] as String,
      isCompleted: json['is_completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'due_date': dueDate,
      'is_completed': isCompleted,
    };
  }
}
