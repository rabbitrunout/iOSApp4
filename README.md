# 📱 FirebaseGalleryApp

## 🎯 Description
**FirebaseGalleryApp** is a modern iOS application that allows users to create and manage a personal photo gallery powered by **Firebase Realtime Database**.  
Users can **upload**, **view**, **edit**, **update**, and **delete** photos and their captions — all of which are synced in real-time.  

The app is built with a **clean, minimalist interface** featuring:  
- ✨ Responsive gallery cards  
- 🌈 Soft gradient background  
- 🎞 Smooth animations  
- 🖱 Edit and delete buttons that appear only when tapping on an image  

---

## ⚙️ Technologies Used
- **SwiftUI** – declarative UI framework  
- **Firebase Realtime Database** – real-time cloud-based data storage  
- **Firebase SDK** – integration and configuration  
- **Combine** – reactive data updates and binding  
- **UIKit Integration** – photo picker using `UIImagePickerController`  

---

## 🧩 Main Features

| Feature | Description | File |
|----------|-------------|------|
| **Upload (Insert)** | Adds a new image with a title to Firebase | `FirebaseService.uploadImage()` |
| **Retrieve (Fetch)** | Loads and observes gallery data in real time | `FirebaseService.fetchImages()` |
| **Update** | Edit existing image and title | `FirebaseService.updateImage()` + `EditView.swift` |
| **Delete** | Remove a photo from Firebase | `FirebaseService.deleteImage()` |
| **File Upload** | Encodes and stores photos in Base64 format | `FirebaseService.swift` |
| **Progress Bar** | Displays upload progress dynamically | `ProgressView` in `UploadView.swift` |
| **Image Picker** | Lets the user choose a photo from gallery | `ImagePicker.swift` |
| **Modern UI** | Adaptive grid layout with elegant animations | `ContentView.swift` + `GalleryCard.swift` |

---

## 🗂 Main Files
- `FirebaseService.swift` — Firebase CRUD logic and progress tracking  
- `ContentView.swift` — main gallery screen with grid layout  
- `GalleryCard.swift` — reusable card with image preview and controls  
- `UploadView.swift` — upload interface with progress indicator  
- `EditView.swift` — editing screen for modifying photos or titles  
- `ImagePicker.swift` — integrates UIKit’s image picker into SwiftUI  

---

## 🧠 How It Works
1. The user taps the **「＋」** button to open the upload screen.  
2. The selected image is encoded in **Base64** and uploaded to **Firebase Realtime Database**.  
3. The app listens to database changes via `.observe(.value)` to update instantly.  
4. When tapping on an image:  
   - ✏️ **Edit** — change the photo or its caption  
   - 🗑 **Delete** — remove the photo from the gallery  

---

## 📸 Screens

| Screen | Description |
|--------|--------------|
| 🏠 **Main Gallery** | Displays all uploaded photos in a grid |
| ➕ **Upload Screen** | Upload photo with progress tracking |
| ✏️ **Edit Screen** | Update image and title in real time |

---

## ✅ Evaluation Summary

| Requirement | Status |
|--------------|---------|
| Firebase Integration | ✅ |
| Realtime Database | ✅ |
| Insert / Fetch / Update / Delete | ✅ |
| File Upload | ✅ |
| Progress Bar | ✅ |
| Modern UI / Animations | ✅ |

> 💯 **FirebaseGalleryApp** meets and exceeds all assignment requirements — implementing full CRUD functionality, file upload with progress display, and a polished SwiftUI user experience.

---

## 🚀 How to Run

1. Clone or download the project from GitHub.  
2. Open the `.xcodeproj` or `.xcodeworkspace` in **Xcode 15+**.  
3. Run `pod install` (if using CocoaPods) to install Firebase SDKs.  
4. Add your own **GoogleService-Info.plist** file to the project root.  
5. Run the app on a simulator or a physical iPhone.  

---

## 👩‍💻 Author
**Irina Safronova**  
Mobile & Web Developer Student @ triOS College, Toronto  
📅 Graduation: May 2026  
💼 Portfolio projects include: *Glowi*, *FluiDex Drive*, *CityChamberHunt*, *TaskTracker*, and more.  

---

