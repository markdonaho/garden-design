// lib/screens/task_list_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/garden_models.dart'; // Import the models
import '../providers/garden_provider.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garden Tasks'),
      ),
      body: Consumer<GardenProvider>(
        builder: (context, gardenProvider, child) {
          if (gardenProvider.areTasksLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (gardenProvider.tasks.isEmpty) {
            return const Center(child: Text('No tasks yet! Add one below.'));
          }
          return ListView.builder(
            itemCount: gardenProvider.sortedTasks.length,
            itemBuilder: (context, index) {
              final task = gardenProvider.sortedTasks[index];
              return ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) async {
                    if (value != null) {
                      await gardenProvider.toggleTaskCompletion(task.id, value);
                    }
                  },
                ),
                title: Text(
                  task.description,
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Due: ${task.dueDate}'),
                    if (task.notes != null && task.notes!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('Notes: ${task.notes}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    await gardenProvider.deleteTask(task.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              _showAddTaskDialog(context, Provider.of<GardenProvider>(context, listen: false));
            },
            child: const Icon(Icons.add),
          );
        }
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, GardenProvider gardenProvider) {
    final TextEditingController descController = TextEditingController();
    final TextEditingController notesController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    String? selectedGardenId; // To hold the selected garden ID

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add a new task'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: descController,
                      autofocus: true,
                      decoration: const InputDecoration(labelText: 'Task Description'),
                    ),
                    const SizedBox(height: 16),
                    // Garden Selector Dropdown
                    if (gardenProvider.gardens.isNotEmpty)
                      DropdownButtonFormField<String>(
                        hint: const Text('Assign to a Garden (Optional)'),
                        value: selectedGardenId,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGardenId = newValue;
                          });
                        },
                        items: gardenProvider.gardens
                            .map<DropdownMenuItem<String>>((Garden garden) {
                          return DropdownMenuItem<String>(
                            value: garden.id,
                            child: Text(garden.name),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: notesController,
                      decoration: const InputDecoration(labelText: 'Notes (Optional)'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: Text('Due Date: ${selectedDate.toLocal().toString().split(' ')[0]}')),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Add Task'),
                  onPressed: () async {
                    if (descController.text.isNotEmpty) {
                      await gardenProvider.addTask(
                        descController.text,
                        selectedDate,
                        notes: notesController.text.isNotEmpty ? notesController.text : null,
                        gardenId: selectedGardenId, // Pass the selected garden ID
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
