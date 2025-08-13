# 🌱 Flutter Garden Planner App
**A practical, user-friendly garden management app for parents**  
**Technology:** Flutter Web with Provider state management  
**Status:** Sessions 1–5 Complete — Ready for Session 6 (Visual Enhancements)  

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
- **Shared Preferences** - Local browser storage for persistence
- **Model Classes** - Type-safe data handling

### **State Management**
- **GardenProvider** - Central data hub for all garden information
- **ChangeNotifier** - Efficient UI updates when data changes
- **Consumer Widgets** - Reactive UI components

## 📋 **Development Plan**

### **Session-Based Implementation (9 Sessions)**
1. **Session 1:** ✅ Project Setup & Data Foundation — Completed
2. **Session 2:** ✅ Data Modeling with Dart — Completed
3. **Session 3:** ✅ State Management Setup (Provider) — Completed
4. **Session 4:** 🏠 Home Screen & Garden Layout — Completed
5. **Session 5:** 📋 Bed Detail Modal — Completed
6. **Session 6:** 🎨 Visual Garden Representation — Completed
7. **Session 7:** Task Management System 
8. **Session 8:** Data Persistence 💾
9. **Session 9:** Polish & Deployment 🚀

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

## 📝 TODO (Up Next)

- Add crop icon mapping and visual polish for beds and modal (Session 6)
- Implement Tasks tab with list, filters, and actions (Session 7)
- Add local persistence with `shared_preferences` (Session 8)

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

### Design Principles
- Simplicity first: clean UI, intuitive navigation, large touch targets
- Garden-centric palette: greens, browns; organic shapes and hierarchy
- Accessibility: high contrast, readable typography, large text options

### Visual Elements
- Plant icons (built-in initially; custom SVGs as we expand)
- Garden bed visuals and pathways between beds
- Status indicators (watering, health, harvest readiness)

### Recommended Packages
- `flutter_svg` for scalable graphics
- `font_awesome_flutter` for supplemental icons
- `flutter_staggered_grid_view` for organic bed layouts (optional)

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

## 🚀 **Current Development Status**

### ✅ Sessions Completed
- Session 1: Project setup, dependencies, assets
- Session 2: Data models with JSON mapping
- Session 3: Provider integration and data load

### ▶️ Next
- Session 4: Home UI and Garden Layout grid
