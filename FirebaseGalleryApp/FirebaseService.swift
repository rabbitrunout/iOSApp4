import Foundation
import Combine
import UIKit
import FirebaseDatabase

// ✅ Модель изображения
struct ImageItem: Identifiable {
    let id: String
    let title: String
    let image: UIImage
}

// ✅ Основной сервис работы с Firebase
class FirebaseService: ObservableObject {
    @Published var items: [ImageItem] = []
    private let dbRef = Database.database().reference().child("gallery")

    // MARK: - Получение изображений
    func fetchImages() {
        dbRef.observe(.value) { snapshot in
            var loaded: [ImageItem] = []

            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let value = snap.value as? [String: Any],
                   let title = value["title"] as? String,
                   let base64 = value["imageData"] as? String,
                   let data = Data(base64Encoded: base64),
                   let uiImage = UIImage(data: data) {
                    loaded.append(ImageItem(id: snap.key, title: title, image: uiImage))
                }
            }

            DispatchQueue.main.async {
                self.items = loaded.reversed()
            }
        }
    }
    
    func testWrite() {
        dbRef.child("test").setValue(["hello": "Firebase"]) { error, _ in
            if let error = error {
                print("❌ Test write error:", error.localizedDescription)
            } else {
                print("✅ Test write success!")
            }
        }
    }


    // MARK: - Загрузка изображения (Base64)
    func uploadImage(title: String, image: UIImage, progressHandler: @escaping (Double) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let data = image.jpegData(compressionQuality: 0.6) {
                let base64 = data.base64EncodedString()
                let id = UUID().uuidString
                let newItem = [
                    "title": title,
                    "imageData": base64
                ]

                // Симулируем прогресс загрузки
                for step in 1...10 {
                    Thread.sleep(forTimeInterval: 0.08)
                    DispatchQueue.main.async {
                        progressHandler(Double(step) / 10.0)
                    }
                }

                // Сохраняем в Realtime Database
                self.dbRef.child(id).setValue(newItem) { error, _ in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("❌ Error when saving: \(error.localizedDescription)")
                        } else {
                            print("✅ Image saved successfully")
                            self.fetchImages()
                        }
                    }
                }
            }
        }
    }

    // MARK: - Удаление
    func deleteImage(item: ImageItem) {
        dbRef.child(item.id).removeValue()
    }
    
    // MARK: - Обновление изображения
    func updateImage(item: ImageItem, newTitle: String, newImage: UIImage?, completion: @escaping () -> Void) {
        var updatedData: [String: Any] = ["title": newTitle]

        if let newImage = newImage,
           let data = newImage.jpegData(compressionQuality: 0.6) {
            updatedData["imageData"] = data.base64EncodedString()
        }

        dbRef.child(item.id).updateChildValues(updatedData) { error, _ in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ Error updated:", error.localizedDescription)
                } else {
                    print("✅ Photo updated successfully")
                    self.fetchImages()
                    completion()
                }
            }
        }
    }

}

