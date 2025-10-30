import SwiftUI
import UIKit

struct GalleryCard: View {
    var item: ImageItem
    var isExpanded: Bool
    var onTap: () -> Void
    var onEdit: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                // 🖼 Фото
                Image(uiImage: item.image)
                    .resizable()
                    .scaledToFit() // 👈 изображение центрируется без обрезания
                    .frame(width: 160, height: 160)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.9))
                    )
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isExpanded ? Color.accentColor.opacity(0.8) : .clear, lineWidth: 2)
                            .shadow(color: isExpanded ? Color.accentColor.opacity(0.5) : .clear, radius: 8)
                            .animation(.easeInOut(duration: 0.25), value: isExpanded)
                    )
                    .onTapGesture {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            onTap()
                        }
                    }
                    .overlay(
                        // 🔘 Кнопки (редактировать / удалить)
                        HStack(spacing: 18) {
                            Button(action: onEdit) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundStyle(.blue, .white)
                                    .shadow(radius: 2)
                            }
                            
                            Button(action: onDelete) {
                                Image(systemName: "trash.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundStyle(.red, .white)
                                    .shadow(radius: 2)
                            }
                        }
                        .padding(12)
                        .opacity(isExpanded ? 1 : 0)
                        .scaleEffect(isExpanded ? 1 : 0.8)
                        .animation(.easeInOut(duration: 0.25), value: isExpanded)
                        , alignment: .bottomTrailing
                    )
            }
            .frame(width: 180, height: 180)
            
            // 🏷 Название
            Text(item.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .frame(width: 160)
                .padding(.bottom, 5)
        }
        .frame(width: 180, height: 240)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.6))
                .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(isExpanded ? Color.accentColor.opacity(0.4) : .clear, lineWidth: 1)
        )
        .padding(6)
    }
}

#Preview {
    let testItem = ImageItem(
        id: "preview",
        title: "Bugs Bunny",
        image: UIImage(named: "example") ?? UIImage(systemName: "photo.fill")!
    )
    
    return GalleryCard(
        item: testItem,
        isExpanded: true,
        onTap: {},
        onEdit: {},
        onDelete: {}
    )
    .padding()
    .background(
        LinearGradient(
            colors: [
                Color.purple.opacity(0.2),
                Color.blue.opacity(0.15),
                Color.white.opacity(0.1)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    )
}
