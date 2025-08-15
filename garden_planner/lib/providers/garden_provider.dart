// lib/providers/garden_provider.dart
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/garden_models.dart';
import 'dart:async';

class GardenProvider with ChangeNotifier {
  List<GardenTask> _tasks = [];
  List<Garden> _gardens = []; // To hold the list of gardens

  bool _areTasksLoading = true;
  bool _areGardensLoading = true; // Loading state for gardens

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot>? _tasksSubscription;
  StreamSubscription<QuerySnapshot>? _gardensSubscription; // Stream for gardens

  List<GardenTask> get tasks => _tasks;
  List<Garden> get gardens => _gardens; // Getter for gardens

  bool get areTasksLoading => _areTasksLoading;
  bool get areGardensLoading => _areGardensLoading; // Getter for garden loading state

  List<GardenTask> get sortedTasks {
    List<GardenTask> sorted = List.from(_tasks);
    sorted.sort((a, b) {
      if (a.isCompleted != b.isCompleted) return a.isCompleted ? 1 : -1;
      return a.dueDate.compareTo(b.dueDate);
    });
    return sorted;
  }

  GardenProvider() {
    _listenToGardens(); // Listen to gardens
    _listenToTasks();   // Listen to tasks
  }

  void _listenToGardens() {
    _gardensSubscription =
        _firestore.collection('gardens').snapshots().listen((snapshot) {
      _gardens = snapshot.docs
          .map((doc) => Garden.fromJson(doc.data()..['id'] = doc.id))
          .toList();
      _areGardensLoading = false;
      notifyListeners();
    }, onError: (error) {
      debugPrint("Error listening to gardens snapshots: $error");
      _areGardensLoading = false;
      notifyListeners();
    });
  }

  void _listenToTasks() {
    _tasksSubscription =
        _firestore.collection('tasks').snapshots().listen((snapshot) {
      _tasks = snapshot.docs
          .map((doc) => GardenTask.fromJson(doc.data()..['id'] = doc.id))
          .toList();
      _areTasksLoading = false;
      notifyListeners();
    }, onError: (error) {
      debugPrint("Error listening to tasks snapshots: $error");
      _areTasksLoading = false;
      notifyListeners();
    });
  }

  Future<void> addGarden(String name) async {
    DocumentReference docRef = _firestore.collection('gardens').doc();
    final newGarden = Garden(
      id: docRef.id,
      name: name,
      beds: [], // Start with empty beds
    );
    await docRef.set(newGarden.toJson());
  }

  Future<void> updateGarden(Garden garden) async {
    await _firestore
        .collection('gardens')
        .doc(garden.id)
        .set(garden.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteGarden(String gardenId) async {
    await _firestore.collection('gardens').doc(gardenId).delete();
  }

  Future<void> addBedToGarden(String gardenId, Bed newBed) async {
    await _firestore.collection('gardens').doc(gardenId).update({
      'beds': FieldValue.arrayUnion([newBed.toJson()])
    });
  }

  Future<void> updateBedInGarden(String gardenId, Bed updatedBed) async {
    final gardenRef = _firestore.collection('gardens').doc(gardenId);
    final gardenDoc = await gardenRef.get();
    if (gardenDoc.exists) {
      final garden = Garden.fromJson(gardenDoc.data()!);
      final bedIndex = garden.beds.indexWhere((b) => b.id == updatedBed.id);
      if (bedIndex != -1) {
        garden.beds[bedIndex] = updatedBed;
        await gardenRef.set(garden.toJson());
      }
    }
  }

  Future<void> deleteBedFromGarden(String gardenId, Bed bedToDelete) async {
    await _firestore.collection('gardens').doc(gardenId).update({
      'beds': FieldValue.arrayRemove([bedToDelete.toJson()])
    });
  }

  Future<void> addTask(String description, DateTime dueDate,
      {String? notes, String? gardenId}) async {
    DocumentReference docRef = _firestore.collection('tasks').doc();
    final newTask = GardenTask(
      id: docRef.id,
      description: description,
      dueDate: dueDate.toIso8601String().substring(0, 10),
      notes: notes,
      isCompleted: false,
      gardenId: gardenId, // Set the gardenId
    );
    await docRef.set(newTask.toJson());
  }

  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    await _firestore
        .collection('tasks')
        .doc(taskId)
        .update({'is_completed': isCompleted});
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    _gardensSubscription?.cancel(); // Dispose the gardens subscription
    super.dispose();
  }
}


