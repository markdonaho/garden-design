# 🌱 Flutter Garden Planner App
**A practical, user-friendly garden management app for parents**  
**Technology:** Flutter Web with Provider state management  
**Status:** Sessions 1–7 Complete — Ready for Session 8 (Firebase Integration)  

## 🎯 **Project Overview**

### **What We're Building**
A responsive Flutter web app that helps manage garden beds, track crops, monitor tasks, and maintain garden health. The app will be simple enough for daily use but powerful enough to provide real gardening insights.

### **Why This Matters**
- **Practical Value:** Real-world application for your parents' garden
- **Family Connection:** Combines your skills with their needs
- **Learning Opportunity:** Flutter web, state management, local persistence
- **Community Impact:** Could help other gardeners in similar situations

## 🏗️ **Technical Architecture**

### **Frontend Framework**
- **Flutter Web** - Cross-platform, responsive design
- **Material Design 3** - Modern, accessible UI components
- **Provider Pattern** - Simple, effective state management

### **Data Layer**
- **JSON Assets** - Initial data structure and examples
- **Firebase** - Cloud Firestore for real-time data persistence and Firebase Hosting for deployment.
- **Model Classes** - Type-safe data handling

### **State Management**
- **GardenProvider** - Central data hub for all garden information
- **ChangeNotifier** - Efficient UI updates when data changes
- **Consumer Widgets** - Reactive UI components

## 📋 **Development Plan**

Here is the detailed session-by-session plan for building the Garden Planner app.

---

### **Session 1: Project Setup & Data Foundation** ✅ Completed

**🎯 Session Goal:** Initialize Flutter project with dependencies and create the initial JSON data structure that will serve as the app's database.

**🔧 Step-by-Step Summary:**
1.  **Create Flutter Project**: `flutter create garden_planner`
2.  **Add Dependencies**: `provider`, `shared_preferences`
3.  **Create `assets/garden_data.json`**: Defined initial data for beds and tasks.
4.  **Configure `pubspec.yaml`**: Linked the assets.
5.  **Test Project**: Ran `flutter run` to ensure setup was correct.

**✅ Success Criteria:**
- [x] Flutter project runs without errors.
- [x] Dependencies resolve correctly.
- [x] Assets are accessible.

---

### **Session 2: Data Modeling with Dart** ✅ Completed

**🎯 Session Goal:** Create type-safe Dart classes (`Crop`, `Soil`, `Bed`, `GardenTask`) corresponding to the JSON structure.

**🔧 Step-by-Step Summary:**
1.  **Create `lib/models/garden_models.dart`**.
2.  **Implement Classes**: Added `fromJson` and `toJson` factories for robust data handling.
3.  **Analyze Code**: Ran `flutter analyze` to ensure no errors.

**✅ Success Criteria:**
- [x] All model classes compile without errors.
- [x] `flutter analyze` shows no errors.
- [x] Models have proper JSON serialization methods.

---

### **Session 3: State Management Setup** ✅ Completed

**🎯 Session Goal:** Create the `GardenProvider` class to manage application state, load data from JSON, and notify the UI of changes.

**🔧 Step-by-Step Summary:**
1.  **Create `lib/providers/garden_provider.dart`**.
2.  **Implement `GardenProvider`**: Added logic to load `garden_data.json` and manage lists of beds and tasks.
3.  **Integrate Provider**: Wrapped the `MyApp` widget with `ChangeNotifierProvider` in `lib/main.dart`.
4.  **Test Integration**: Displayed bed and task counts on a placeholder home screen.

**✅ Success Criteria:**
- [x] App starts without errors.
- [x] Garden data loads and displays correctly.
- [x] Provider is accessible throughout the app.

---

### **Session 4: Home Screen & Garden Layout** ✅ Completed

**🎯 Session Goal:** Create the main UI with bottom navigation and a responsive grid display of garden beds.

**🔧 Step-by-Step Summary:**
1.  **Create `lib/screens/home_screen.dart`**: Implemented `Scaffold` with `BottomNavigationBar`.
2.  **Create `lib/screens/garden_layout_view.dart`**: Built a `GridView` to display `Bed` objects from `GardenProvider`.
3.  **Style Bed Cards**: Designed cards to show key bed information.
4.  **Update `main.dart`**: Set `HomeScreen` as the app's home.

**✅ Success Criteria:**
- [x] App displays garden beds in a grid layout.
- [x] Bottom navigation works.
- [x] Bed cards show relevant information.

---

### **Session 5: Bed Detail Modal** ✅ Completed

**🎯 Session Goal:** Implement an interactive modal bottom sheet to display comprehensive information for each garden bed.

**🔧 Step-by-Step Summary:**
1.  **Create `lib/widgets/bed_detail_sheet.dart`**.
2.  **Design Modal UI**: Included sections for soil info, crops, and quick actions.
3.  **Integrate Modal**: Triggered `showModalBottomSheet` on bed card tap in `garden_layout_view.dart`.

**✅ Success Criteria:**
- [x] Tapping a bed card opens a modal bottom sheet.
- [x] Modal displays comprehensive bed information.
- [x] Modal can be closed and scrolled.

---

### **Session 6: Visual Garden Representation** ✅ Completed

**🎯 Session Goal:** Enhance the UI by adding crop icons and refining the styling of garden bed cards.

**🔧 Step-by-Step Summary:**
1.  **Create `lib/utils/crop_icons.dart`**: A utility to map crop names to `IconData`.
2.  **Update `bed_detail_sheet.dart`**: Replaced text avatars with icons in the crop list.
3.  **Update `garden_layout_view.dart`**: Added a row of crop icons to each bed card for a quick visual summary.
4.  **Restyle Bed Cards**: Applied a brown background and border to make cards look more like garden beds.

**✅ Success Criteria:**
- [x] Crop icons are displayed in the `BedDetailSheet`.
- [x] A summary of crop icons is visible on each bed card.
- [x] Bed cards have an enhanced garden-themed style.

---

### **Session 7: Task Management System** ✅ Completed

**🎯 Session Goal:** Build a full-featured task management screen allowing users to view, create, update, and delete garden tasks.

**🔧 Step-by-Step Summary:**
1.  **Create `lib/screens/task_list_view.dart`**: Built the UI to display a list of tasks.
2.  **Implement CRUD in `GardenProvider`**: Added methods to add, delete, and toggle task completion.
3.  **Enhance "Add Task" Dialog**: Based on user feedback, the dialog was rebuilt to include a notes field and a date picker.
4.  **Integrate with Home Screen**: Replaced the placeholder "Tasks" view with the functional `TaskListView`.

**✅ Success Criteria:**
- [x] App displays a list of tasks on the "Tasks" tab.
- [x] Users can check off tasks to mark them complete.
- [x] Users can delete tasks.
- [x] Users can add new, detailed tasks with specific due dates and notes.

---

### **Session 8: Data Persistence with Firebase** 💾 Up Next

**🎯 Session Goal:** Migrate the application's data layer from a local JSON file to a cloud-based, persistent solution using Firebase Cloud Firestore.

**🔧 Key Steps:**
1.  **Firebase Project Setup**: Create a new project in the Firebase Console and register the web app.
2.  **Integrate Firebase SDK**: Add `firebase_core` and `cloud_firestore` to `pubspec.yaml` and initialize Firebase in `main.dart`.
3.  **Data Migration**: Create a one-time utility to upload the initial `garden_data.json` to Firestore.
4.  **Refactor `GardenProvider`**: Rewrite all data handling methods (`loadGardenData`, `addTask`, etc.) to interact with Firestore collections instead of in-memory lists.

---

### **Session 9: Polish & Deployment** 🚀

**🎯 Session Goal:** Refine the UI/UX, improve responsiveness, and deploy the application to Firebase Hosting.

## 📁 Repository Layout

```
garden-design/
├── garden_planner/            # Flutter app
│   ├── lib/                   # Dart source code (models, providers, screens)
│   ├── assets/                # Garden data JSON
│   └── web/                   # Web deployment files
├── session_archive/           # Session summaries and transcripts
└── Archive/                   # Historical planning and design docs
```

## ✅ Current Progress

- Models implemented: `Crop`, `Soil`, `Bed`, `GardenTask`
- Provider integrated: `GardenProvider` loads `assets/garden_data.json`
- App renders responsive bed grid and bed detail modal in Chrome
- Crop icons are now displayed in the bed detail view and on the home screen bed cards
- A full-featured task management system is implemented with create, read, update, and delete functionality.

## 📝 TODO (Up Next)

- Integrate Firebase and migrate data to Cloud Firestore (Session 8)
- Polish UI/UX and deploy the app to Firebase Hosting (Session 9)

## 🚀 Quick Start

### Prerequisites
- Flutter SDK installed and in PATH
- Chrome browser
- VS Code or Cursor with Flutter extensions

### Create and Run
```bash
# If not already created
flutter create garden_planner
cd garden_planner

# Install dependencies
flutter pub get

# Run the web app in Chrome
flutter run -d chrome
```

If assets are added or changed, ensure `pubspec.yaml` includes:
```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/garden_data.json
```

## 🎨 Visual Design & Enhancements

This section outlines the strategy for creating an intuitive and visually appealing user interface. For detailed research and alternative options, see `Archive/VISUAL_ENHANCEMENT_RESEARCH.md` (once moved).

### Design Principles
- **Simplicity First**: Clean UI, intuitive navigation, and large touch targets.
- **Garden-Centric Palette**: Use greens, browns, and other organic colors and shapes.
- **Accessibility**: Ensure high contrast, readable typography, and support for screen readers.

### Core Visual Elements
- **Crop Icons**: Use built-in Material icons initially, with a plan to migrate to custom SVGs for better recognition.
- **Garden Bed Visuals**: Style bed cards to be visually distinct and representative.
- **Status Indicators**: Implement visual cues for plant health, watering needs, and harvest readiness.

### Recommended Packages
- `flutter_svg`: For scalable custom SVG icons.
- `font_awesome_flutter`: For a wider range of supplemental icons.

### Phased Implementation Strategy
- **Phase 1 (Complete)**: Use built-in icons and basic styling for bed cards.
- **Phase 2 (In Progress)**: Introduce custom SVG icons for key crops and enhance layout graphics.
- **Phase 3 (Future)**: Explore advanced visualizations like pathway graphics, seasonal themes, and interactive map views.

## 📱 **User Experience**

### **Daily Garden Check**
1. Open app → See visual garden overview
2. Check tasks → See what needs doing today
3. Update progress → Mark tasks complete
4. Add notes → Record observations

### **Weekly Planning**
1. Review bed status → See what's growing well
2. Plan new plantings → Add new crops to beds
3. Schedule maintenance → Create new tasks
4. Track soil health → Note amendments needed

## 🔧 **Technical Requirements**

- **Flutter SDK** installed and configured
- **VS Code or Cursor** with Flutter extensions
- **Chrome browser** for web development
- **Basic understanding** of Dart and Flutter concepts

## 🎯 **Success Metrics**

### **Functional Requirements**
- ✅ All garden beds display correctly with visual elements
- ✅ Task management works end-to-end
- ✅ Data persists between sessions
- ✅ App works on all target devices
- ✅ Visual garden representation is clear and intuitive

### **User Experience Goals**
- ✅ Parents can use app without training
- ✅ Garden management becomes easier with visual cues
- ✅ Tasks are never forgotten
- ✅ Garden health improves over time

## 🔮 **Future Enhancements**

### **Phase 2 Features**
- Weather integration for garden planning
- Photo documentation of plants
- Harvest tracking and yield analysis
- Companion planting recommendations

### **Phase 3 Features**
- Multiple garden support
- Sharing garden plans with family
- Integration with garden supply stores
- Advanced analytics and insights

## 🧱 Data Structure (Reference)

```json
{
  "beds": [
    {
      "id": "bed_01",
      "name": "North Raised Bed",
      "position": {"x": 10, "y": 10},
      "soil": { "composition": "...", "last_amended": "...", "notes": "..." },
      "crops": [ { "id": "...", "name": "...", "variety": "...", "quantity": 4, "planting_date": "..." } ]
    }
  ],
  "tasks": [
    {
      "id": "task_01",
      "description": "Water the North Raised Bed",
      "due_date": "2025-08-12",
      "is_completed": false
    }
  ]
}
```

### Provider Architecture
```dart
class GardenProvider with ChangeNotifier {
  List<Bed> _beds = [];
  List<GardenTask> _tasks = [];
  Future<void> loadGardenData() async { /* load assets/garden_data.json */ }
}
```

### Widget Hierarchy
```
MyApp
└── ChangeNotifierProvider<GardenProvider>
    └── MaterialApp
        └── Home (Session 4 adds HomeScreen/GardenLayoutView)
```

