import SwiftUI

/// Museum-Grade Celestial Synastry Orbit Wheel
public struct ConstellationView: View {
    public let person1Name: String
    public let nakshatra1: String
    public let person2Name: String
    public let nakshatra2: String
    public let gunaScore: Int
    
    @State private var rotationAngle: Double = 0.0
    @State private var pulseAura: Bool = false
    
    private let nakshatras = [
        "Ashwini", "Bharani", "Krittika", "Rohini", "Mrigashirsha", "Ardra",
        "Punarvasu", "Pushya", "Ashlesha", "Magha", "Purva Phalguni", "Uttara Phalguni",
        "Hasta", "Chitra", "Svati", "Vishakha", "Anuradha", "Jyeshtha",
        "Mula", "Purva Ashadha", "Uttara Ashadha", "Shravana", "Dhanishtha",
        "Shatabhisha", "Purva Bhadrapada", "Uttara Bhadrapada", "Revati"
    ]
    
    public init(
        person1Name: String = "You",
        nakshatra1: String = "Anuradha",
        person2Name: String = "Ananya",
        nakshatra2: String = "Rohini",
        gunaScore: Int = 32
    ) {
        self.person1Name = person1Name
        self.nakshatra1 = nakshatra1
        self.person2Name = person2Name
        self.nakshatra2 = nakshatra2
        self.gunaScore = gunaScore
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("CELESTIAL SYNASTRY WHEEL")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.gold)
                    Text("27 Nakshatras • Exact Lunar Chord")
                        .font(.system(size: 15, weight: .semibold, design: .serif))
                        .foregroundColor(.white)
                }
                Spacer()
                
                // Guna Milan Badge
                HStack(spacing: 4) {
                    Image(systemName: "sparkles")
                        .foregroundColor(KnotTheme.gold)
                    Text("\(gunaScore)/36 Gunas")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.gold)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(KnotTheme.gold.opacity(0.12))
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(KnotTheme.borderGold, lineWidth: 1))
            }
            
            // The Celestial Ring Canvas
            ZStack {
                // Background Radial Glow
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [KnotTheme.purple.opacity(0.2), KnotTheme.gold.opacity(0.08), Color.clear],
                            center: .center,
                            startRadius: 10,
                            endRadius: 160
                        )
                    )
                    .frame(width: 280, height: 280)
                    .scaleEffect(pulseAura ? 1.05 : 0.96)
                    .animation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true), value: pulseAura)
                
                // Outer Nakshatra Coordinate Ring
                Circle()
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
                    .frame(width: 260, height: 260)
                
                Circle()
                    .stroke(KnotTheme.gold.opacity(0.25), style: StrokeStyle(lineWidth: 1.5, dash: [4, 6]))
                    .frame(width: 220, height: 220)
                    .rotationEffect(.degrees(rotationAngle))
                
                // 27 Nakshatra Node Markers
                ForEach(0..<27, id: \.self) { i in
                    let angle = Double(i) * (360.0 / 27.0)
                    let radians = angle * .pi / 180.0
                    let radius: CGFloat = 110.0
                    let x = cos(radians) * radius
                    let y = sin(radians) * radius
                    
                    Circle()
                        .fill(i % 3 == 0 ? KnotTheme.gold : Color.white.opacity(0.3))
                        .frame(width: i % 3 == 0 ? 5 : 3, height: i % 3 == 0 ? 5 : 3)
                        .offset(x: x, y: y)
                }
                
                // Connecting Celestial Golden Arc (The KNOT)
                Path { path in
                    let r1: CGFloat = 110.0
                    let r2: CGFloat = 110.0
                    // Anuradha (~220°) and Rohini (~45°)
                    let p1 = CGPoint(x: 140 + cos(220.0 * .pi / 180.0) * r1, y: 140 + sin(220.0 * .pi / 180.0) * r1)
                    let p2 = CGPoint(x: 140 + cos(45.0 * .pi / 180.0) * r2, y: 140 + sin(45.0 * .pi / 180.0) * r2)
                    path.move(to: p1)
                    path.addQuadCurve(to: p2, control: CGPoint(x: 140, y: 140))
                }
                .stroke(
                    LinearGradient(
                        colors: [KnotTheme.goldLight, KnotTheme.gold, KnotTheme.purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 2.5, lineCap: .round)
                )
                .shadow(color: KnotTheme.gold.opacity(0.7), radius: 8)
                .frame(width: 280, height: 280)
                
                // Node 1 (You)
                VStack(spacing: 2) {
                    Circle()
                        .fill(KnotTheme.goldGradient)
                        .frame(width: 14, height: 14)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        .shadow(color: KnotTheme.gold, radius: 6)
                    Text("\(person1Name) (\(nakshatra1))")
                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.goldLight)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.black.opacity(0.85))
                        .cornerRadius(4)
                }
                .offset(x: -85, y: -70)
                
                // Node 2 (Match)
                VStack(spacing: 2) {
                    Circle()
                        .fill(LinearGradient(colors: [KnotTheme.purple, Color.pink], startPoint: .top, endPoint: .bottom))
                        .frame(width: 14, height: 14)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        .shadow(color: KnotTheme.purple, radius: 6)
                    Text("\(person2Name) (\(nakshatra2))")
                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.black.opacity(0.85))
                        .cornerRadius(4)
                }
                .offset(x: 75, y: 75)
                
                // Center Knot Insignia
                Circle()
                    .fill(KnotTheme.bgDeep)
                    .frame(width: 52, height: 52)
                    .overlay(Circle().stroke(KnotTheme.borderGold, lineWidth: 1.5))
                    .overlay(
                        Text("K")
                            .font(.system(size: 22, weight: .bold, design: .serif))
                            .foregroundColor(KnotTheme.gold)
                    )
                    .shadow(color: Color.black, radius: 10)
            }
            .frame(width: 280, height: 280)
            .onAppear {
                pulseAura = true
                withAnimation(.linear(duration: 60).repeatForever(autoreverses: false)) {
                    rotationAngle = 360.0
                }
            }
            
            // Legend
            HStack(spacing: 20) {
                HStack(spacing: 6) {
                    Circle().fill(KnotTheme.gold).frame(width: 8, height: 8)
                    Text("Anuradha (Saturn)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                HStack(spacing: 6) {
                    Circle().fill(KnotTheme.purple).frame(width: 8, height: 8)
                    Text("Rohini (Moon)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                HStack(spacing: 6) {
                    Rectangle().fill(KnotTheme.gold).frame(width: 12, height: 2)
                    Text("Harmonic Trine")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(20)
        .background(KnotTheme.bgCard)
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(KnotTheme.border, lineWidth: 1))
    }
}
