import SwiftUI

public struct ContentView: View {
    @State private var selectedTab = "drops" // Default to the luxury feed!
    @State private var selectedCity = "Bengaluru"
    
    // Compatibility Studio Profiles
    @State private var p1 = PersonProfile(
        name: "Rahul",
        birthDate: Calendar.current.date(from: DateComponents(year: 1995, month: 5, day: 15, hour: 14, minute: 30)) ?? Date(),
        financialPhilosophy: "investor",
        careerPace: "high_drive",
        familyDynamics: "close_proximity",
        communicationStyle: "direct"
    )
    
    @State private var p2 = PersonProfile(
        name: "Pooja",
        birthDate: Calendar.current.date(from: DateComponents(year: 1996, month: 10, day: 22, hour: 9, minute: 15)) ?? Date(),
        financialPhilosophy: "balanced",
        careerPace: "balanced",
        familyDynamics: "close_proximity",
        communicationStyle: "collaborative"
    )
    
    @State private var result: CompatibilityResult? = nil
    
    public init() {}
    
    public var body: some View {
        NavigationSplitView {
            navigationSidebar
        } detail: {
            switch selectedTab {
            case "drops":
                DailyDropsView()
            case "chat":
                ChatView()
            case "concierge":
                DateConciergeView()
            case "registry":
                RegistryView()
            case "observer":
                ElderObserverView()
            case "pushcards":
                PushCardView()
            case "onboarding":
                OnboardingView(onComplete: { selectedTab = "drops" })
            case "manifesto":
                manifestoView
            default:
                calculatorDetailView
            }
        }
        .frame(minWidth: 1140, minHeight: 760)
        .background(KnotTheme.bgDeep)
        .onAppear {
            calculate()
        }
    }
    
    // MARK: - Navigation Sidebar
    private var navigationSidebar: some View {
        VStack(alignment: .leading, spacing: 20) {
            // App Branding
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 10) {
                    Circle()
                        .stroke(KnotTheme.gold, lineWidth: 1.5)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("K")
                                .font(.system(size: 15, weight: .bold, design: .serif))
                                .foregroundColor(KnotTheme.gold)
                        )
                    Text("K.N.O.T.")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .foregroundColor(KnotTheme.gold)
                }
                Text("KNOWLEDGE • ORBIT • TRUST")
                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                    .foregroundColor(.secondary)
            }
            .padding(.top, 20)
            .padding(.horizontal, 16)
            
            // Orbit City Switcher (Diaspora / Major Hubs)
            Menu {
                Button("Bengaluru (Indiranagar / Koramangala)") { selectedCity = "Bengaluru" }
                Button("Mumbai (Bandra / BKC / South Bombay)") { selectedCity = "Mumbai" }
                Button("Delhi-NCR (Gurugram / South Delhi)") { selectedCity = "Delhi-NCR" }
                Button("London (Mayfair / Shoreditch)") { selectedCity = "London" }
                Button("San Francisco Bay Area (South Bay / SF)") { selectedCity = "Bay Area" }
                Button("Singapore (Marina Bay / Tanjong Pagar)") { selectedCity = "Singapore" }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "location.circle.fill")
                        .foregroundColor(KnotTheme.gold)
                    Text("Orbit: \(selectedCity)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(KnotTheme.bgCard)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(KnotTheme.border, lineWidth: 1)
                )
            }
            .menuStyle(.borderlessButton)
            .padding(.horizontal, 14)
            
            Divider().background(KnotTheme.border)
            
            // Primary Nav Links
            VStack(alignment: .leading, spacing: 6) {
                sidebarButton(
                    id: "drops",
                    label: "3 Cosmic Drops",
                    icon: "sparkles.rectangle.stack.fill",
                    badge: "8:00 PM"
                )
                
                sidebarButton(
                    id: "chat",
                    label: "Matches & Chat",
                    icon: "bubble.left.and.bubble.right.fill",
                    badge: "2 Active"
                )
                
                sidebarButton(
                    id: "concierge",
                    label: "AI Date Concierge",
                    icon: "cup.and.saucer.fill",
                    badge: "New"
                )
                
                sidebarButton(
                    id: "registry",
                    label: "Milestone Registry",
                    icon: "banknote.fill",
                    badge: "50/50"
                )
                
                sidebarButton(
                    id: "observer",
                    label: "Elder Observer Pass",
                    icon: "person.2.fill",
                    badge: "Family"
                )
                
                sidebarButton(
                    id: "pushcards",
                    label: "Daily Story Cards",
                    icon: "quote.bubble.fill",
                    badge: "Viral"
                )
                
                sidebarButton(
                    id: "onboarding",
                    label: "Verified Onboarding",
                    icon: "person.badge.shield.checkmark.fill",
                    badge: "90s"
                )
                
                sidebarButton(
                    id: "calculator",
                    label: "Compatibility Studio",
                    icon: "slider.horizontal.2.square.on.square",
                    badge: nil
                )
                
                sidebarButton(
                    id: "manifesto",
                    label: "The Truthful Standard",
                    icon: "checkmark.seal.fill",
                    badge: nil
                )
            }
            .padding(.horizontal, 10)
            
            Spacer()
            
            // Bottom Info
            VStack(alignment: .leading, spacing: 4) {
                Text("CATEGORY-KILLER MATRIMONY")
                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                    .foregroundColor(KnotTheme.gold.opacity(0.8))
                Text("Bengaluru • Mumbai • Delhi NCR")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(16)
        }
        .frame(minWidth: 260, maxWidth: 280)
        .background(KnotTheme.bgSurface)
    }
    
    private func sidebarButton(id: String, label: String, icon: String, badge: String?) -> some View {
        Button(action: { selectedTab = id }) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .foregroundColor(selectedTab == id ? KnotTheme.gold : .secondary)
                    .frame(width: 20)
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(selectedTab == id ? .white : .secondary)
                    .fontWeight(selectedTab == id ? .semibold : .regular)
                Spacer()
                if let b = badge {
                    Text(b)
                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(KnotTheme.gold.opacity(0.12))
                        .foregroundColor(KnotTheme.gold)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(selectedTab == id ? KnotTheme.bgCard : Color.clear)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selectedTab == id ? KnotTheme.borderGold : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Calculator Detail View
    private var calculatorDetailView: some View {
        ScrollView {
            if let res = result {
                VStack(spacing: 24) {
                    // Scorecard Hero
                    HStack(spacing: 32) {
                        ZStack {
                            Circle()
                                .stroke(Color.secondary.opacity(0.12), lineWidth: 10)
                                .frame(width: 124, height: 124)
                            Circle()
                                .trim(from: 0, to: CGFloat(res.knotIndex / 100.0))
                                .stroke(
                                    KnotTheme.goldGradient,
                                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .frame(width: 124, height: 124)
                            VStack(spacing: 2) {
                                Text("\(Int(res.knotIndex))")
                                    .font(.system(size: 38, weight: .semibold, design: .serif))
                                    .foregroundColor(KnotTheme.gold)
                                Text("KMVA INDEX")
                                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(res.verdict)
                                .font(.system(size: 18, weight: .semibold, design: .serif))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 16) {
                                scorePill(label: "Values Alignment", score: res.valuesScore, max: 100, color: KnotTheme.purple)
                                scorePill(label: "Celestial Harmony", score: res.celestialScore, max: 100, color: KnotTheme.gold)
                            }
                        }
                        Spacer()
                    }
                    .padding(24)
                    .background(KnotTheme.bgCard)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(KnotTheme.border, lineWidth: 1))
                    
                    // Dual Columns
                    HStack(alignment: .top, spacing: 20) {
                        // Layer 1
                        VStack(alignment: .leading, spacing: 14) {
                            Label("Layer 1: Cultural & Celestial", systemImage: "moon.stars.fill")
                                .font(.headline)
                                .foregroundColor(KnotTheme.gold)
                            
                            HStack {
                                moonBadge(name: p1.name, moon: res.user1Moon)
                                Spacer()
                                Image(systemName: "arrow.left.and.right").foregroundColor(.secondary)
                                Spacer()
                                moonBadge(name: p2.name, moon: res.user2Moon)
                            }
                            .padding(12)
                            .background(KnotTheme.bgDeep)
                            .cornerRadius(10)
                            
                            insightRow(title: "Elemental Balance", text: res.elementalSummary)
                            insightRow(title: "Temperament Sync", text: res.temperamentSummary)
                            insightRow(title: "Angular Alignment", text: res.angularSummary)
                        }
                        .padding(20)
                        .background(KnotTheme.bgCard)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(KnotTheme.border, lineWidth: 1))
                        
                        // Layer 2
                        VStack(alignment: .leading, spacing: 14) {
                            Label("Layer 2: Values & Reality", systemImage: "heart.text.square.fill")
                                .font(.headline)
                                .foregroundColor(KnotTheme.purple)
                            
                            insightRow(title: "Financial Approach", text: res.financialSummary)
                            insightRow(title: "Career & Work Pace", text: res.careerSummary)
                            insightRow(title: "Living & In-laws", text: res.familySummary)
                            insightRow(title: "Conflict Resolution", text: res.communicationSummary)
                        }
                        .padding(20)
                        .background(KnotTheme.bgCard)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(KnotTheme.border, lineWidth: 1))
                    }
                }
                .padding(28)
            }
        }
    }
    
    // MARK: - Manifesto View
    private var manifestoView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Label("The K.N.O.T. Truthful Standard", systemImage: "checkmark.seal.fill")
                    .font(.title2.bold())
                    .foregroundColor(KnotTheme.emerald)
                
                Text("Designed to replace Tinder, Bumble, Shaadi.com, and Astrotalk all at once.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider().background(KnotTheme.border)
                
                manifestoPoint(
                    title: "1. Zero Fear-Mongering",
                    body: "We never monetize relationship anxiety. We do not predict disasters or sell fake rituals. Celestial data is strictly a cultural compass."
                )
                
                manifestoPoint(
                    title: "2. The 'Ask Mom' WhatsApp Card",
                    body: "Zero birth-time drop-off. Start instantly with your birth date. Need exact hospital records later? A 1-tap polite card asks parents with zero awkwardness."
                )
                
                manifestoPoint(
                    title: "3. The Family-Ready Vault",
                    body: "Downloadable 1-page parent-friendly Kundli dossier with cryptographic SHA-256 seal. Hand it to conservative parents without ever admitting you met on an app."
                )
            }
            .padding(36)
            .frame(maxWidth: 780)
        }
    }
    
    private func manifestoPoint(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.headline).foregroundColor(.white)
            Text(body).font(.subheadline).foregroundColor(.secondary).lineSpacing(4)
        }
        .padding(18)
        .background(KnotTheme.bgCard)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(KnotTheme.border, lineWidth: 1))
    }
    
    private func scorePill(label: String, score: Double, max: Double, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label).font(.caption2).foregroundColor(.secondary)
            HStack(spacing: 4) {
                Text("\(Int(score))").font(.title3.bold()).foregroundColor(color)
                Text("/ \(Int(max))").font(.caption).foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(KnotTheme.bgDeep)
        .cornerRadius(8)
    }
    
    private func moonBadge(name: String, moon: CelestialPosition) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name).font(.caption.bold()).foregroundColor(.white)
            Text("\(moon.rashi.name) (\(moon.rashi.sanskrit))").font(.subheadline.bold()).foregroundColor(KnotTheme.gold)
            Text("\(moon.nakshatra.name) • Pada \(moon.pada)").font(.caption2).foregroundColor(.secondary)
        }
    }
    
    private func insightRow(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title).font(.caption2.bold()).foregroundColor(.secondary)
            Text(text).font(.subheadline).foregroundColor(.white)
        }
        .padding(.vertical, 2)
    }
    
    private func calculate() {
        result = Engine.evaluate(p1: p1, p2: p2)
    }
}
