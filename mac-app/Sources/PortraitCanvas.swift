import SwiftUI

/// Luxury Editorial Portrait Art with Chiaroscuro Studio Lighting and Particle Ambience
public struct PortraitCanvas: View {
    public let name: String
    public let gradientColors: [Color]
    public let isBlurred: Bool
    
    @State private var particlePhase: Double = 0.0
    
    public init(name: String, gradientColors: [Color], isBlurred: Bool = false) {
        self.name = name
        self.gradientColors = gradientColors
        self.isBlurred = isBlurred
    }
    
    public var body: some View {
        ZStack {
            // 1. Deep Editorial Gradient Canvas
            RadialGradient(
                gradient: Gradient(colors: [
                    gradientColors.first?.opacity(0.85) ?? Color(red: 0.25, green: 0.15, blue: 0.35),
                    Color(red: 0.06, green: 0.07, blue: 0.11),
                    Color(red: 0.02, green: 0.02, blue: 0.04)
                ]),
                center: .topTrailing,
                startRadius: 40,
                endRadius: 520
            )
            
            // 2. Subtle Starlight / Golden Nebula Dust Particles
            TimelineView(.animation) { timeline in
                let time = timeline.date.timeIntervalSinceReferenceDate
                Canvas { context, size in
                    for i in 0..<35 {
                        let seed = Double(i) * 91.3
                        let x = (sin(seed + time * 0.2) * 0.45 + 0.5) * size.width
                        let y = (cos(seed * 1.3 + time * 0.15) * 0.45 + 0.5) * size.height
                        let radius = (sin(seed * 2.1 + time * 0.5) * 0.5 + 1.2) * 1.5
                        let opacity = (sin(seed * 0.7 + time * 0.4) * 0.4 + 0.5) * 0.6
                        
                        let rect = CGRect(x: x - radius, y: y - radius, width: radius * 2, height: radius * 2)
                        context.fill(
                            Path(ellipseIn: rect),
                            with: .color(KnotTheme.goldLight.opacity(opacity))
                        )
                    }
                }
            }
            .allowsHitTesting(false)
            
            // 3. Cinematic Studio Chiaroscuro Silhouette & Monogram
            VStack {
                Spacer()
                ZStack {
                    // Soft Golden Halo Glow behind silhouette
                    Circle()
                        .fill(KnotTheme.gold.opacity(0.12))
                        .frame(width: 260, height: 260)
                        .blur(radius: 40)
                    
                    // High-Fashion Editorial Monogram
                    Text(String(name.prefix(1)))
                        .font(.system(size: 210, weight: .ultraLight, design: .serif))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.35),
                                    KnotTheme.goldLight.opacity(0.2),
                                    Color.white.opacity(0.04)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: KnotTheme.gold.opacity(0.25), radius: 30, x: 0, y: 10)
                }
                .offset(y: -40)
                Spacer()
            }
            .blur(radius: isBlurred ? 28 : 0)
            
            // 4. Subtle Gold Hairline Vignette Rim
            RoundedRectangle(cornerRadius: 24)
                .stroke(
                    LinearGradient(
                        colors: [
                            KnotTheme.goldLight.opacity(0.4),
                            Color.white.opacity(0.1),
                            KnotTheme.goldDark.opacity(0.3)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.2
                )
        }
        .frame(height: 500)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.6), radius: 25, x: 0, y: 15)
    }
}
