import SwiftUI

public struct DailyDropsView: View {
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Today's Curated Introductions")
                            .font(.title2.bold())
                        Text("3 verified, high-intent profiles aligned with your lifestyle and cultural baseline. Refreshes in 14h 22m.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Label("High-Intent Filter Active", systemImage: "shield.checkmark.fill")
                        .font(.caption.bold())
                        .foregroundColor(.green)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.green.opacity(0.12))
                        .cornerRadius(6)
                }
                
                Divider()
                
                // Drop 1
                candidateCard(
                    name: "Ananya Iyer",
                    age: 28,
                    role: "Senior Consultant @ McKinsey",
                    city: "Bangalore / Mumbai",
                    knotIndex: 88,
                    moonSign: "Taurus (Rohini)",
                    valuesHighlight: "Disciplined Investor • Close Proximity to Family • Collaborative Conflict Style",
                    marriageIntent: "Seeking marriage within 1–2 years",
                    accentColor: .indigo
                )
                
                // Drop 2
                candidateCard(
                    name: "Dr. Siddharth Mehta",
                    age: 30,
                    role: "Pediatric Surgeon @ Manipal Hospital",
                    city: "Bangalore",
                    knotIndex: 84,
                    moonSign: "Virgo (Hasta)",
                    valuesHighlight: "Balanced Spender • High-Drive Career • Independent Nuclear Living",
                    marriageIntent: "Seeking marriage within 12–18 months",
                    accentColor: .purple
                )
                
                // Drop 3
                candidateCard(
                    name: "Meera Sen",
                    age: 29,
                    role: "Founding Designer @ Series-A FinTech",
                    city: "Delhi NCR / Remote",
                    knotIndex: 79,
                    moonSign: "Pisces (Revati)",
                    valuesHighlight: "Experiential Living • Entrepreneurial Rhythm • Reflective Communication",
                    marriageIntent: "Exploring seriously with clear commitment goals",
                    accentColor: .blue
                )
            }
            .padding(28)
            .frame(maxWidth: 820)
        }
        .background(Color(NSColor.windowBackgroundColor))
    }
    
    private func candidateCard(
        name: String,
        age: Int,
        role: String,
        city: String,
        knotIndex: Int,
        moonSign: String,
        valuesHighlight: String,
        marriageIntent: String,
        accentColor: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                // Avatar placeholder with initials
                Circle()
                    .fill(accentColor.opacity(0.15))
                    .frame(width: 54, height: 54)
                    .overlay(
                        Text(String(name.prefix(1)))
                            .font(.title2.bold())
                            .foregroundColor(accentColor)
                    )
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 8) {
                        Text("\(name), \(age)")
                            .font(.headline)
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .font(.caption)
                    }
                    Text(role)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text(city)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Score Badge
                VStack(spacing: 2) {
                    Text("\(knotIndex)")
                        .font(.title2.bold())
                        .foregroundColor(accentColor)
                    Text("K.N.O.T.")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color(NSColor.textBackgroundColor))
                .cornerRadius(10)
            }
            
            Divider()
            
            // Dual Layer Highlights
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "moon.stars.fill")
                        .foregroundColor(.indigo)
                        .font(.caption)
                    Text("Celestial Anchor:")
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                    Text(moonSign)
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "heart.text.square.fill")
                        .foregroundColor(.purple)
                        .font(.caption)
                    Text("Values Synergy:")
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                    Text(valuesHighlight)
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "calendar.badge.clock")
                        .foregroundColor(.green)
                        .font(.caption)
                    Text("Timeline:")
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                    Text(marriageIntent)
                        .font(.caption)
                        .foregroundColor(.primary)
                }
            }
            
            // Actions
            HStack(spacing: 12) {
                Button(action: {}) {
                    Label("View Full Dual Card", systemImage: "doc.text.magnifyingglass")
                }
                .buttonStyle(.bordered)
                
                Button(action: {}) {
                    Label("Send Intent & Connect", systemImage: "sparkles")
                }
                .buttonStyle(.borderedProminent)
                .tint(accentColor)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
                .help("Share with Family Circle")
            }
            .padding(.top, 4)
        }
        .padding(20)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(12)
    }
}
