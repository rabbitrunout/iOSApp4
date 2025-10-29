//
//  EditView.swift
//  FirebaseGalleryApp
//
//  Created by Irina Saf on 2025-10-29.
//
import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var firebase: FirebaseService
    var item: ImageItem
    
    @State private var newTitle: String
    @State private var newImage: UIImage?
    @State private var showPicker = false
    @State private var isSaving = false
    
    init(firebase: FirebaseService, item: ImageItem) {
        self.firebase = firebase
        self.item = item
        _newTitle = State(initialValue: item.title)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if let newImage = newImage {
                Image(uiImage: newImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(12)
            } else {
                Image(uiImage: item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(12)
            }
            
            Button("📷 Сменить фото") {
                showPicker = true
            }
            .buttonStyle(.borderedProminent)
            
            TextField("Новое название", text: $newTitle)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            if isSaving {
                ProgressView("Сохраняем...")
                    .progressViewStyle(.circular)
            } else {
                Button("💾 Сохранить изменения") {
                    isSaving = true
                    firebase.updateImage(item: item, newTitle: newTitle, newImage: newImage) {
                        isSaving = false
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showPicker) {
            ImagePicker(image: $newImage)
        }
    }
}


#Preview {
    let testFirebase = FirebaseService()
    let testItem = ImageItem(
        id: "preview-id",
        title: "Пример фото",
        image: UIImage(systemName: "photo")!
    )
    return EditView(firebase: testFirebase, item: testItem)
}

