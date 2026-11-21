import SwiftUI

public struct RegistryView: View {
    @State private var partner1Name: String = "Rahul"
    @State private var partner2Name: String = "Pooja"
    @State private var jointMonthlySavings: Double = 100000.0 // ₹1 Lakh/month
    
    // Goals state
    @State private var goals = [
        (title: "First Home Down Payment (Whitefield / Indiranagar)", target: 2500000.0, current: 850000.0, icon: "house.fill"),
        (title: "Intimate Zero-Waste Wedding Fund", target: 1200000.0, current: 550000.0, icon: "heart.circle.fill"),
        (title: "Kyoto & Hokkaido Sabbatical Fund", target: 600000.0, current: 200000.0, icon: "airplane")
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                // Header
                VStack(spacing: 6) {
                    HStack(spacing: 8) {
                        Image(systemName: "banknote.fill")
                            .foregroundColor(KnotTheme.gold)
                        Text("Pre-Marital Financial Registry & Escrow")
                            .font(.system(size: 24, weight: .bold, design: .serif))
                            .foregroundColor(.white)
                    }
                    Text("Replacing archaic dowry and transactional biodatas with 50/50 equal milestone commitments.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 24)
                
                // Anti-Dowry Cryptographic Charter Card
                HStack(spacing: 16) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 36))
                        .foregroundColor(KnotTheme.gold)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Anti-Dowry Dignity Charter • Signed & Verified")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Both partners have verified independent financial identities via DigiLocker. All contributions are 1:1 matched and held in mutual goal escrow accounts.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    
                    Text("AUDITED")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(KnotTheme.gold.opacity(0.15))
                        .foregroundColor(KnotTheme.gold)
                        .cornerRadius(6)
                }
                .padding(20)
                .background(KnotTheme.bgCard)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(KnotTheme.borderGold, lineWidth: 1)
                )
                
                // Interactive Monthly Velocity Simulator
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("Simulate Joint Monthly Savings Capacity")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        Text("₹\(Int(jointMonthlySavings).formatted()) / month")
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                            .foregroundColor(KnotTheme.gold)
                    }
                    
                    Slider(value: $jointMonthlySavings, in: 20000...300000, step: 10000)
                        .accentColor(KnotTheme.gold)
                    
                    HStack {
                        Text("₹\(partner1Name)'s share: ₹\(Int(jointMonthlySavings / 2).formatted())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("₹\(partner2Name)'s share: ₹\(Int(jointMonthlySavings / 2).formatted())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(20)
                .background(KnotTheme.bgSurface)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(KnotTheme.border, lineWidth: 1)
                )
                
                // Goals List
                VStack(alignment: .leading, spacing: 16) {
                    Text("Shared Milestone Progress")
                        .font(.headline)
                        .foregroundColor(KnotTheme.gold)
                    
                    ForEach(goals, id: \.title) { goal in
                        let pct = goal.current / goal.target
                        let remaining = max(0.0, goal.target - goal.current)
                        let months = jointMonthlySavings > 0 ? (remaining / jointMonthlySavings) : 99.0
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: goal.icon)
                                    .foregroundColor(KnotTheme.gold)
                                Text(goal.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("₹\(Int(goal.current / 100000))L / ₹\(Int(goal.target / 100000))L (\(Int(pct * 100))%)")
                                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                                    .foregroundColor(KnotTheme.gold)
                            }
                            
                            // Progress bar
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.secondary.opacity(0.15))
                                        .frame(height: 10)
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(LinearGradient(colors: [KnotTheme.goldDark, KnotTheme.gold], startPoint: .leading, endPoint: .trailing))
                                        .frame(width: geo.size.width * CGFloat(pct), height: 10)
                                }
                            }
                            .frame(height: 10)
                            
                            HStack {
                                Text("Remaining: ₹\(Int(remaining).formatted())")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("Estimated Arrival: \(String(format: "%.1f", months)) months")
                                    .font(.system(size: 11, weight: .semibold, design: .monospaced))
                                    .foregroundColor(KnotTheme.gold)
                            }
                        }
                        .padding(16)
                        .background(KnotTheme.bgCard)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(KnotTheme.border, lineWidth: 1)
                        )
                    }
                }
            }
            .padding(24)
            .frame(maxWidth: 720)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(KnotTheme.bgDeep)
    }
}
