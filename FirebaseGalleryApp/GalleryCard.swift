import SwiftUI
import UIKit

struct GalleryCard: View {
    var item: ImageItem
    var isExpanded: Bool
    var onTap: () -> Void
    var onEdit: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                // 🖼 Изображение
                Image(uiImage: item.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 180) // фиксированный размер карточек
                    .clipped()
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(isExpanded ? Color.accentColor.opacity(0.7) : .clear, lineWidth: 2)
                            .animation(.easeInOut(duration: 0.2), value: isExpanded)
                    )
                    .onTapGesture {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                            onTap()
                        }
                    }
                    .overlay(
                        // 🔘 Кнопки поверх фото
                        HStack(spacing: 14) {
                            Button {
                                onEdit()
                            } label: {
                                Image(systemName: "pencil")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }

                            Button {
                                onDelete()
                            } label: {
                                Image(systemName: "trash")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                        }
                        .padding(10)
                        .opacity(isExpanded ? 1 : 0)
                        .scaleEffect(isExpanded ? 1 : 0.8)
                        .animation(.easeInOut(duration: 0.25), value: isExpanded)
                        , alignment: .bottomTrailing
                    )
            }

            // 🏷 Название
            Text(item.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .frame(width: 160)
        }
        .frame(width: 170, height: 230)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
        )
        .padding(4)
    }
}

#Preview {
    let testItem = ImageItem(
        id: "preview",
        title: "Preview",
        image: UIImage(systemName: "photo.fill")!
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
            colors: [.purple.opacity(0.3), .blue.opacity(0.2)],
            startPoint: .top,
            endPoint: .bottom
        )
    )
}
