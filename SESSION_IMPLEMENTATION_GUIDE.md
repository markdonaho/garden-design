# 🚀 Flutter Garden App - Session Implementation Guide
**Complete step-by-step instructions for building the garden planner app**  
**Each session is self-contained with clear deliverables and success criteria**

---

## 📋 **Session 1: Project Setup & Data Foundation** ✅ Completed

### **🎯 Session Goal**
Initialize Flutter project with dependencies and create the initial JSON data structure that will serve as the app's database.

### **📁 Files to Create**
- `garden_planner/` (Flutter project directory)
- `garden_planner/assets/garden_data.json`
- `garden_planner/pubspec.yaml` (modified)

### **🔧 Step-by-Step Instructions**

#### **Step 1: Create Flutter Project**
```bash
# Open terminal in your desired directory
flutter create garden_planner
cd garden_planner
```

#### **Step 2: Add Dependencies**
Open `pubspec.yaml` and replace the dependencies section:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  shared_preferences: ^2.2.3
  cupertino_icons: ^1.0.2
```

#### **Step 3: Install Dependencies**
```bash
flutter pub get
```

#### **Step 4: Create Assets Folder**
```bash
mkdir assets
```

#### **Step 5: Create Initial Data File**
Create `assets/garden_data.json`:
```json
{
  "beds": [
    {
      "id": "bed_01",
      "name": "North Raised Bed",
      "soil": {
        "composition": "50% Topsoil, 30% Compost, 20% Peat Moss",
        "last_amended": "2025-03-15",
        "notes": "Good drainage, gets full sun after 10 AM."
      },
      "crops": [
        {
          "id": "crop_01a",
          "name": "Tomato",
          "variety": "Celebrity",
          "quantity": 4,
          "planting_date": "2025-04-20"
        },
        {
          "id": "crop_01b",
          "name": "Basil",
          "variety": "Genovese",
          "quantity": 6,
          "planting_date": "2025-04-20"
        }
      ]
    },
    {
      "id": "bed_02",
      "name": "Herb Spiral",
      "soil": {
        "composition": "Sandy Loam Mix",
        "last_amended": "2025-03-10",
        "notes": "Top is drier for Mediterranean herbs."
      },
      "crops": [
        {
          "id": "crop_02a",
          "name": "Rosemary",
          "variety": "Arp",
          "quantity": 1,
          "planting_date": "2024-10-05"
        },
        {
          "id": "crop_02b",
          "name": "Okra",
          "variety": "Clemson Spineless",
          "quantity": 8,
          "planting_date": "2025-05-15"
        }
      ]
    },
    {
      "id": "bed_03",
      "name": "East Vegetable Bed",
      "soil": {
        "composition": "60% Topsoil, 25% Compost, 15% Sand",
        "last_amended": "2025-03-20",
        "notes": "Full sun all day, excellent for heat-loving crops."
      },
      "crops": [
        {
          "id": "crop_03a",
          "name": "Cucumber",
          "variety": "Marketmore 76",
          "quantity": 3,
          "planting_date": "2025-04-25"
        },
        {
          "id": "crop_03b",
          "name": "Nasturtium",
          "variety": "Alaska Mix",
          "quantity": 5,
          "planting_date": "2025-04-25"
        }
      ]
    }
  ],
  "tasks": [
    {
      "id": "task_01",
      "description": "Water the North Raised Bed",
      "due_date": "2025-08-12",
      "is_completed": false
    },
    {
      "id": "task_02",
      "description": "Check tomatoes for hornworms",
      "due_date": "2025-08-13",
      "is_completed": false
    },
    {
      "id": "task_03",
      "description": "Turn compost pile (add chicken manure)",
      "due_date": "2025-08-17",
      "is_completed": false
    },
    {
      "id": "task_04",
      "description": "Harvest okra from Herb Spiral",
      "due_date": "2025-08-12",
      "is_completed": true
    },
    {
      "id": "task_05",
      "description": "Fertilize tomatoes with fish emulsion",
      "due_date": "2025-08-14",
      "is_completed": false
    }
  ]
}
```

#### **Step 6: Configure Assets in pubspec.yaml**
Add this section to `pubspec.yaml` under the `flutter:` section:
```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/garden_data.json
```

#### **Step 7: Test Project Setup**
```bash
flutter run -d chrome
```

### **✅ Success Criteria**
- [ ] Flutter project runs without errors
- [ ] Dependencies resolve correctly
- [ ] Assets are accessible (no 404 errors in console)
- [ ] Basic counter app displays (we'll replace this next)

### **🔍 Troubleshooting**
- **Dependencies not found:** Run `flutter pub get` again
- **Assets not loading:** Check indentation in pubspec.yaml
- **Chrome not working:** Try `flutter run -d web-server` instead

---

## 📋 **Session 2: Data Modeling with Dart** ✅ Completed

### **🎯 Session Goal**
Create type-safe Dart classes that correspond to the JSON data structure, preventing runtime errors and making data handling robust.

### **📁 Files to Create**
- `lib/models/garden_models.dart`

### **🔧 Step-by-Step Instructions**

#### **Step 1: Create Models Directory**
```bash
mkdir lib/models
```

#### **Step 2: Create Garden Models File**
Create `lib/models/garden_models.dart`:
```dart
// lib/models/garden_models.dart

class Crop {
  final String id;
  final String name;
  final String variety;
  final int quantity;
  final String planting_date;

  Crop({
    required this.id,
    required this.name,
    required this.variety,
    required this.quantity,
    required this.planting_date,
  });

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'],
      name: json['name'],
      variety: json['variety'],
      quantity: json['quantity'],
      planting_date: json['planting_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'variety': variety,
      'quantity': quantity,
      'planting_date': planting_date,
    };
  }
}

class Soil {
  final String composition;
  final String last_amended;
  final String notes;

  Soil({
    required this.composition,
    required this.last_amended,
    required this.notes,
  });

  factory Soil.fromJson(Map<String, dynamic> json) {
    return Soil(
      composition: json['composition'],
      last_amended: json['last_amended'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'composition': composition,
      'last_amended': last_amended,
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
    var cropList = json['crops'] as List;
    List<Crop> crops = cropList.map((i) => Crop.fromJson(i)).toList();

    return Bed(
      id: json['id'],
      name: json['name'],
      soil: Soil.fromJson(json['soil']),
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
  final String due_date;
  bool is_completed;

  GardenTask({
    required this.id,
    required this.description,
    required this.due_date,
    this.is_completed = false,
  });

  factory GardenTask.fromJson(Map<String, dynamic> json) {
    return GardenTask(
      id: json['id'],
      description: json['description'],
      due_date: json['due_date'],
      is_completed: json['is_completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'due_date': due_date,
      'is_completed': is_completed,
    };
  }
}
```

#### **Step 3: Test Model Compilation**
```bash
flutter analyze
```

### **✅ Success Criteria**
- [ ] All model classes compile without errors
- [ ] `flutter analyze` shows no errors
- [ ] Models have proper JSON serialization methods
- [ ] Type safety is enforced throughout

### **🔍 Troubleshooting**
- **Compilation errors:** Check for missing semicolons or brackets
- **Import errors:** Ensure file path is correct
- **Type errors:** Verify all required fields are properly typed

---

## 📋 **Session 3: State Management Setup** ✅ Completed

### **🎯 Session Goal**
Create the GardenProvider class that will be the central hub for all application data, loading from JSON and notifying the UI of changes.

### **📁 Files to Create**
- `lib/providers/garden_provider.dart`
- `lib/main.dart` (modified)

### **🔧 Step-by-Step Instructions**

#### **Step 1: Create Providers Directory**
```bash
mkdir lib/providers
```

#### **Step 2: Create Garden Provider**
Create `lib/providers/garden_provider.dart`:
```dart
// lib/providers/garden_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/garden_models.dart';

class GardenProvider with ChangeNotifier {
  List<Bed> _beds = [];
  List<GardenTask> _tasks = [];
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

      // Load from the initial asset file
      final String response = await rootBundle.loadString('assets/garden_data.json');
      final data = await json.decode(response);

      var bedList = data['beds'] as List;
      _beds = bedList.map((i) => Bed.fromJson(i)).toList();

      var taskList = data['tasks'] as List;
      _tasks = taskList.map((i) => GardenTask.fromJson(i)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print('Error loading garden data: $error');
    }
  }

  // Method to add a new task
  void addTask(GardenTask task) {
    _tasks.add(task);
    notifyListeners();
  }

  // Method to toggle task completion
  void toggleTaskCompletion(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].is_completed = !_tasks[taskIndex].is_completed;
      notifyListeners();
    }
  }

  // Method to remove a task
  void removeTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  // Method to add a new bed
  void addBed(Bed bed) {
    _beds.add(bed);
    notifyListeners();
  }

  // Method to update bed information
  void updateBed(Bed updatedBed) {
    final bedIndex = _beds.indexWhere((bed) => bed.id == updatedBed.id);
    if (bedIndex != -1) {
      _beds[bedIndex] = updatedBed;
      notifyListeners();
    }
  }
}
```

#### **Step 3: Update Main App File**
Replace the contents of `lib/main.dart`:
```dart
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/garden_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GardenProvider(),
      child: MaterialApp(
        title: 'Garden Planner',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(title: 'Garden Planner'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<GardenProvider>(
        builder: (context, gardenProvider, child) {
          if (gardenProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Garden Beds: ${gardenProvider.beds.length}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Active Tasks: ${gardenProvider.tasks.where((task) => !task.is_completed).length}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Test task toggle functionality
                    if (gardenProvider.tasks.isNotEmpty) {
                      gardenProvider.toggleTaskCompletion(gardenProvider.tasks.first.id);
                    }
                  },
                  child: const Text('Test Task Toggle'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

#### **Step 4: Test Provider Integration**
```bash
flutter run -d chrome
```

### **✅ Success Criteria**
- [x] App starts without errors
- [x] Loading indicator displays briefly
- [x] Garden data loads and displays (bed count and task count)
- [x] Provider is accessible throughout the app

### **🔍 Troubleshooting**
- **Provider not found:** Check import paths and provider setup
- **Data not loading:** Verify asset path and JSON format
- **State not updating:** Ensure `notifyListeners()` is called

---

## 📋 **Session 4: Home Screen & Garden Layout** 🚧 In Progress (Next)

### **🎯 Session Goal**
Create the main UI with bottom navigation and a responsive grid display of garden beds.

### **📁 Files to Create**
- `lib/screens/home_screen.dart`
- `lib/screens/garden_layout_view.dart`

### **🔧 Step-by-Step Instructions**

#### **Step 1: Create Screens Directory**
```bash
mkdir lib/screens
```

#### **Step 2: Create Garden Layout View**
Create `lib/screens/garden_layout_view.dart`:
```dart
// lib/screens/garden_layout_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/garden_provider.dart';

class GardenLayoutView extends StatelessWidget {
  const GardenLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GardenProvider>(
      builder: (context, gardenProvider, child) {
        if (gardenProvider.beds.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.grass, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No garden beds yet', style: TextStyle(fontSize: 18)),
                Text('Add your first bed to get started', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.85,
          ),
          itemCount: gardenProvider.beds.length,
          itemBuilder: (context, index) {
            final bed = gardenProvider.beds[index];
            return _buildBedCard(context, bed);
          },
        );
      },
    );
  }

  Widget _buildBedCard(BuildContext context, bed) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Show bed detail sheet in next session
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped on ${bed.name}')),
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
                'Last amended: ${bed.soil.last_amended}',
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
```

#### **Step 3: Create Home Screen**
Create `lib/screens/home_screen.dart`:
```dart
// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'garden_layout_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    GardenLayoutView(),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Task List', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Coming in the next session!', style: TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Parents\' Garden Planner'),
        elevation: 2,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Garden Beds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Tasks',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
```

#### **Step 4: Update Main App**
Replace the `home` property in `lib/main.dart`:
```dart
// In lib/main.dart, replace the home property
home: const HomeScreen(),
```

And add the import at the top:
```dart
import 'screens/home_screen.dart';
```

#### **Step 5: Test the New UI**
```bash
flutter run -d chrome
```

### **✅ Success Criteria**
- [ ] App displays garden beds in attractive grid layout
- [ ] Bottom navigation works between Garden and Tasks views
- [ ] Bed cards show relevant information (name, crop count, amendment date)
- [ ] Tapping bed cards shows snackbar (placeholder for detail sheet)
- [ ] UI is responsive and visually appealing

### **🔍 Troubleshooting**
- **Import errors:** Check file paths and import statements
- **Layout issues:** Verify GridView parameters and card dimensions
- **Navigation not working:** Ensure BottomNavigationBar is properly configured

---

## 📋 **Session 5: Bed Detail Modal**

### **🎯 Session Goal**
Implement interactive bed detail views with modal bottom sheets that display comprehensive information about each garden bed.

### **📁 Files to Create**
- `lib/widgets/bed_detail_sheet.dart`

### **🔧 Step-by-Step Instructions**

#### **Step 1: Create Widgets Directory**
```bash
mkdir lib/widgets
```

#### **Step 2: Create Bed Detail Sheet Widget**
Create `lib/widgets/bed_detail_sheet.dart`:
```dart
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
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
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

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Soil Information
                  _buildSectionHeader(context, 'Soil Information', Icons.science_outlined),
                  _buildSoilInfo(context),
                  const SizedBox(height: 24),

                  // Crops
                  _buildSectionHeader(context, 'Crops (${bed.crops.length})', Icons.local_florist),
                  _buildCropsList(context),
                  const SizedBox(height: 24),

                  // Quick Actions
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
        children: [
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
          children: [
            _buildInfoRow('Composition', bed.soil.composition),
            const Divider(),
            _buildInfoRow('Last Amended', bed.soil.last_amended),
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
        children: [
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
      itemBuilder: (context, index) {
        final crop = bed.crops[index];
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
            subtitle: Text('Planted: ${crop.planting_date}'),
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
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement add crop functionality
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
              // TODO: Implement edit bed functionality
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
```

#### **Step 3: Update Garden Layout View**
In `lib/screens/garden_layout_view.dart`, replace the `onTap` function in the `_buildBedCard` method:

First, add the import at the top:
```dart
import '../widgets/bed_detail_sheet.dart';
```

Then replace the `onTap` function:
```dart
onTap: () {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: BedDetailSheet(bed: bed),
      );
    },
  );
},
```

#### **Step 4: Test the Modal Sheet**
```bash
flutter run -d chrome
```

### **✅ Success Criteria**
- [ ] Tapping bed cards opens modal bottom sheets
- [ ] Modal displays comprehensive bed information
- [ ] Soil information is clearly presented
- [ ] Crops list shows all planted items
- [ ] Quick action buttons are functional (show placeholders)
- [ ] Modal can be closed and scrolled

### **🔍 Troubleshooting**
- **Modal not opening:** Check import paths and showModalBottomSheet call
- **Layout issues:** Verify FractionallySizedBox height factor
- **Data not displaying:** Ensure bed object is properly passed

---

## 🎯 **Next Sessions Preview**

### **Session 6: Visual Garden Representation** 🎨
- Implement plant icons for each crop type
- Add pathway and garden layout graphics
- Create visual garden bed representation
- Build interactive garden map view

### **Session 7: Task Management System**
- Create task list view with CRUD operations
- Implement task creation, completion, and deletion
- Add due date management and sorting

### **Session 8: Data Persistence**
- Implement shared_preferences for local storage
- Add data saving and loading functionality
- Handle data migration and error recovery

### **Session 9: Polish & Deployment**
- UI/UX refinements and animations
- Responsive design improvements
- Web deployment configuration

---

## 🚀 **Getting Started with Next Session**

To continue building your garden app:

1. **Complete the current session** - Ensure all deliverables are working
2. **Test thoroughly** - Verify all functionality before moving forward
3. **Commit your code** - Save your progress with git
4. **Move to next session** - Follow the same pattern for continued development

Each session builds upon the previous one, creating a solid foundation for your garden planner app. The incremental approach ensures you can test and validate each component before adding complexity.

**Happy coding! Your parents are going to love this garden planner! 🌱**
