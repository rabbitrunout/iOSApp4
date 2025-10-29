import SwiftUI

struct UploadView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var image: UIImage?
    @State private var showPicker = false
    @State private var uploadProgress: Double = 0.0
    @ObservedObject var firebase: FirebaseService

    var body: some View {
        VStack(spacing: 25) {
            Text("Upload New Image")
                .font(.title2.bold())

            TextField("Enter title", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                    .shadow(radius: 6)
                    .padding(.horizontal)
            }

            Button("Select Image") {
                showPicker = true
            }
            .buttonStyle(.borderedProminent)

            if uploadProgress > 0 && uploadProgress < 1 {
                VStack {
                    ProgressBar(progress: uploadProgress)
                        .frame(height: 10)
                        .padding(.horizontal)
                    Text("\(Int(uploadProgress * 100))%")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Button("Upload") {
                guard let image = image, !title.isEmpty else { return }
                firebase.uploadImage(title: title, image: image) { progress in
                    withAnimation {
                        uploadProgress = progress
                    }
                    if progress >= 1.0 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            dismiss()
                        }
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(image == nil || title.isEmpty)

            Spacer()
        }
        .sheet(isPresented: $showPicker) {
            ImagePicker(image: $image)
        }
        .padding()
    }
}

#Preview {
    UploadView(firebase: FirebaseService())
}
