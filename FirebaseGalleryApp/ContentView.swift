import SwiftUI

struct ContentView: View {
    @StateObject private var firebase = FirebaseService()
    @State private var showUpload = false
    @State private var selectedItem: ImageItem?
    @State private var expandedItemID: String?
    
    // 🧩 Сетка из двух колонок (адаптивная)
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // 🎨 Фон — плавный градиент
                LinearGradient(
                        colors: [
                            Color(red: 0.95, green: 0.90, blue: 1.0),
                            Color(red: 0.88, green: 0.90, blue: 1.0),
                            Color(red: 0.85, green: 0.80, blue: 0.95)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()



                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(firebase.items) { item in
                            GalleryCard(
                                item: item,
                                isExpanded: expandedItemID == item.id,
                                onTap: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        if expandedItemID == item.id {
                                            expandedItemID = nil
                                        } else {
                                            expandedItemID = item.id
                                        }
                                    }
                                },
                                onEdit: {
                                    selectedItem = item
                                },
                                onDelete: {
                                    withAnimation {
                                        firebase.deleteImage(item: item)
                                        expandedItemID = nil
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
            }
            .navigationTitle("📸 My Gallery")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showUpload = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.pink, .purple)
                    }
                }
            }
            .sheet(isPresented: $showUpload) {
                UploadView(firebase: firebase)
            }
            .sheet(item: $selectedItem) { item in
                EditView(firebase: firebase, item: item)
            }
            .onAppear {
                firebase.fetchImages()
            }
        }
    }
}

#Preview {
    ContentView()
}
