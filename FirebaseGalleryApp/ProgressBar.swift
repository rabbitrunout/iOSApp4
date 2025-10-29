import SwiftUI

struct ProgressBar: View {
    var progress: Double
    var barHeight: CGFloat = 10
    var cornerRadius: CGFloat = 8
    var gradientColors: [Color] = [.blue, .purple]

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.gray.opacity(0.3))
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing))
                    .frame(width: geo.size.width * CGFloat(progress))
            }
        }
        .frame(height: barHeight)
        .animation(.easeInOut(duration: 0.4), value: progress)
    }
}

#Preview {
    ProgressBar(progress: 0.5)
}
