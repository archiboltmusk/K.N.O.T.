import SwiftUI

public struct ElderObserverView: View {
    @State private var copiedLink = false
    @State private var candidateSelected = "Ananya Iyer"
    
    public init() {}
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                // Header
                VStack(alignment: .leading, spacing: 6) {
                    Label("FAMILY LIAISON ENGINE", systemImage: "person.2.fill")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.gold)
                    Text("Elder Observer Pass")
                        .font(.system(size: 26, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                    Text("Satisfies parental involvement without sacrificing candidate autonomy or privacy.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Privacy Boundary Guard
                HStack(spacing: 16) {
                    ZStack {
                        Circle().fill(KnotTheme.emerald.opacity(0.15)).frame(width: 44, height: 44)
                        Image(systemName: "shield.lefthalf.filled").foregroundColor(KnotTheme.emerald).font(.title3)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Strict Privacy Firewalls Active")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Parents can ONLY view matches you have explicitly pre-approved. Private chats, voice notes, and active browsing feeds are 100% blocked from parental view.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(18)
                .background(KnotTheme.bgCard)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(KnotTheme.emerald.opacity(0.3), lineWidth: 1))
                
                // Shareable Link Generator
                VStack(alignment: .leading, spacing: 14) {
                    Text("GENERATE OBSERVER LINK FOR MATCH")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.gold)
                    
                    HStack {
                        Text("https://knot.app/family/PASS-7F2A9B1C88E2")
                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: copyLink) {
                            Text(copiedLink ? "Copied!" : "Copy Private Link")
                                .font(.caption.bold())
                                .foregroundColor(.black)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(KnotTheme.goldGradient)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(14)
                    .background(KnotTheme.bgDeep)
                    .cornerRadius(12)
                }
                .padding(20)
                .background(KnotTheme.bgCard)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(KnotTheme.border, lineWidth: 1))
                
                // Parental Preview Card
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("WHAT PARENTS SEE (SANITIZED OBSERVER VIEW)")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("VERIFIED BY DIGILOCKER")
                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                            .foregroundColor(KnotTheme.emerald)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Ananya Iyer, 28")
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                .foregroundColor(.white)
                            Spacer()
                            Text("31/36 Auspicious Alignment")
                                .font(.caption.bold())
                                .foregroundColor(KnotTheme.emerald)
                        }
                        
                        Divider().background(KnotTheme.border)
                        
                        HStack(spacing: 24) {
                            parentStat(label: "Career:", val: "Senior Consultant @ McKinsey")
                            parentStat(label: "Education:", val: "IIM Ahmedabad • B.Tech IIT")
                        }
                        
                        HStack(spacing: 24) {
                            parentStat(label: "Living Preference:", val: "Close Proximity (Private Home)")
                            parentStat(label: "Horoscope Engine:", val: "Vedic Sidereal Lahiri (Cryptographic)")
                        }
                    }
                    .padding(18)
                    .background(KnotTheme.bgDeep)
                    .cornerRadius(12)
                }
                .padding(20)
                .background(KnotTheme.bgCard)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(KnotTheme.border, lineWidth: 1))
            }
            .padding(32)
            .frame(maxWidth: 720)
        }
        .background(KnotTheme.bgDeep)
    }
    
    private func parentStat(label: String, val: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label).font(.caption2.bold()).foregroundColor(.secondary)
            Text(val).font(.caption).foregroundColor(.white)
        }
    }
    
    private func copyLink() {
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.setString("https://knot.app/family/PASS-7F2A9B1C88E2", forType: .string)
        withAnimation { copiedLink = true }
    }
}
