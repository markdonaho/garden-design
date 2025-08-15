// lib/providers/garden_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/garden_models.dart';

class GardenProvider with ChangeNotifier {
  List<Bed> _beds = <Bed>[];
  List<GardenTask> _tasks = <GardenTask>[];
  bool _isLoading = true;

  List<Bed> get beds => _beds;
  List<GardenTask> get tasks => _tasks;
  bool get isLoading => _isLoading;

  GardenProvider() {
    loadGardenData();
  }

  Future<void> loadGardenData() async {
    try {
      _isLoading = true;
      notifyListeners();

      final String response = await rootBundle.loadString('assets/garden_data.json');
      final Map<String, dynamic> data = json.decode(response) as Map<String, dynamic>;

      final List<dynamic> bedList = data['beds'] as List<dynamic>;
      _beds = bedList.map((dynamic i) => Bed.fromJson(i as Map<String, dynamic>)).toList();

      final List<dynamic> taskList = data['tasks'] as List<dynamic>;
      _tasks = taskList.map((dynamic i) => GardenTask.fromJson(i as Map<String, dynamic>)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error loading garden data: $error');
    }
  }

  void addTask(String description, DateTime dueDate, {String? notes}) {
    final newTask = GardenTask(
      id: 'task_${DateTime.now().millisecondsSinceEpoch}', // Simple unique ID
      description: description,
      dueDate: dueDate.toIso8601String().substring(0, 10),
      notes: notes,
      isCompleted: false,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskCompletion(String taskId) {
    final int taskIndex = _tasks.indexWhere((GardenTask task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((GardenTask task) => task.id == taskId);
    notifyListeners();
  }

  void addBed(Bed bed) {
    _beds.add(bed);
    notifyListeners();
  }

  void updateBed(Bed updatedBed) {
    final int bedIndex = _beds.indexWhere((Bed bed) => bed.id == updatedBed.id);
    if (bedIndex != -1) {
      _beds[bedIndex] = updatedBed;
      notifyListeners();
    }
  }
}


