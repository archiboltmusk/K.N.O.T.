import SwiftUI

public struct ContentView: View {
    @State private var selectedTab = "onboarding"
    
    // Profiles for Compatibility Studio
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
            case "onboarding":
                OnboardingView()
            case "drops":
                DailyDropsView()
            case "manifesto":
                manifestoView
            default:
                calculatorDetailView
            }
        }
        .frame(minWidth: 1080, minHeight: 740)
        .onAppear {
            calculate()
        }
    }
    
    // MARK: - Navigation Sidebar
    private var navigationSidebar: some View {
        VStack(alignment: .leading, spacing: 18) {
            // App Branding
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Circle()
                        .stroke(Color(red: 0.89, green: 0.79, blue: 0.57), lineWidth: 1.5)
                        .frame(width: 26, height: 26)
                        .overlay(
                            Text("K")
                                .font(.system(size: 13, weight: .bold, design: .serif))
                                .foregroundColor(Color(red: 0.89, green: 0.79, blue: 0.57))
                        )
                    Text("K.N.O.T.")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .foregroundColor(Color(red: 0.89, green: 0.79, blue: 0.57))
                }
                Text("KNOWLEDGE • ORBIT • TRUST")
                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                    .foregroundColor(.secondary)
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            
            Divider()
            
            // Primary Sections
            VStack(alignment: .leading, spacing: 6) {
                sidebarButton(
                    id: "onboarding",
                    label: "Onboarding Wizard",
                    icon: "person.badge.shield.checkmark.fill",
                    badge: "90s"
                )
                
                sidebarButton(
                    id: "drops",
                    label: "Daily Curated Drops",
                    icon: "sparkles.rectangle.stack.fill",
                    badge: "3 New"
                )
                
                sidebarButton(
                    id: "calculator",
                    label: "Compatibility Studio",
                    icon: "slider.horizontal.2.square.on.square",
                    badge: nil
                )
                
                sidebarButton(
                    id: "manifesto",
                    label: "Truthful Standard",
                    icon: "checkmark.seal.fill",
                    badge: nil
                )
            }
            .padding(.horizontal, 10)
            
            Spacer()
            
            // If calculator is selected, show profile editor inputs
            if selectedTab == "calculator" {
                VStack(spacing: 12) {
                    Divider()
                    Text("STUDIO PROFILES")
                        .font(.caption2.bold())
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    profileMiniEditor(title: "Profile 1", profile: $p1, color: .indigo)
                    profileMiniEditor(title: "Profile 2", profile: $p2, color: .purple)
                    
                    Button("Recalculate") {
                        calculate()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.indigo)
                    .controlSize(.small)
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
        }
        .frame(minWidth: 260, maxWidth: 290)
        .background(Color(NSColor.controlBackgroundColor))
    }
    
    private func sidebarButton(id: String, label: String, icon: String, badge: String?) -> some View {
        Button(action: { selectedTab = id }) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .foregroundColor(selectedTab == id ? .indigo : .secondary)
                    .frame(width: 20)
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(selectedTab == id ? .primary : .secondary)
                    .fontWeight(selectedTab == id ? .semibold : .regular)
                Spacer()
                if let b = badge {
                    Text(b)
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.indigo.opacity(0.15))
                        .foregroundColor(.indigo)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(selectedTab == id ? Color.indigo.opacity(0.1) : Color.clear)
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
    
    private func profileMiniEditor(title: String, profile: Binding<PersonProfile>, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Circle().fill(color).frame(width: 6, height: 6)
                Text(profile.wrappedValue.name.isEmpty ? title : profile.wrappedValue.name)
                    .font(.caption.bold())
            }
            DatePicker("", selection: profile.birthDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
                .labelsHidden()
        }
        .padding(8)
        .background(Color(NSColor.textBackgroundColor))
        .cornerRadius(6)
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
                                    LinearGradient(
                                        colors: [Color(red: 0.99, green: 0.92, blue: 0.76), Color(red: 0.89, green: 0.79, blue: 0.57)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .frame(width: 124, height: 124)
                            VStack(spacing: 2) {
                                Text("\(Int(res.knotIndex))")
                                    .font(.system(size: 38, weight: .semibold, design: .serif))
                                    .foregroundColor(Color(red: 0.89, green: 0.79, blue: 0.57))
                                Text("KMVA INDEX")
                                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(res.verdict)
                                .font(.headline)
                            
                            HStack(spacing: 16) {
                                scorePill(label: "Values Alignment", score: res.valuesScore, max: 100, color: .purple)
                                scorePill(label: "Celestial Harmony", score: res.celestialScore, max: 100, color: .indigo)
                            }
                        }
                        Spacer()
                    }
                    .padding(24)
                    .background(Color(NSColor.controlBackgroundColor))
                    .cornerRadius(12)
                    
                    // Dual Columns
                    HStack(alignment: .top, spacing: 20) {
                        // Layer 1
                        VStack(alignment: .leading, spacing: 14) {
                            Label("Layer 1: Cultural & Celestial", systemImage: "moon.stars.fill")
                                .font(.headline)
                                .foregroundColor(.indigo)
                            
                            HStack {
                                moonBadge(name: p1.name, moon: res.user1Moon)
                                Spacer()
                                Image(systemName: "arrow.left.and.right")
                                    .foregroundColor(.secondary)
                                Spacer()
                                moonBadge(name: p2.name, moon: res.user2Moon)
                            }
                            .padding(12)
                            .background(Color(NSColor.textBackgroundColor))
                            .cornerRadius(8)
                            
                            insightRow(title: "Elemental Balance", text: res.elementalSummary)
                            insightRow(title: "Temperament Sync", text: res.temperamentSummary)
                            insightRow(title: "Angular Alignment", text: res.angularSummary)
                        }
                        .padding(18)
                        .background(Color(NSColor.controlBackgroundColor))
                        .cornerRadius(12)
                        
                        // Layer 2
                        VStack(alignment: .leading, spacing: 14) {
                            Label("Layer 2: Values & Reality", systemImage: "heart.text.square.fill")
                                .font(.headline)
                                .foregroundColor(.purple)
                            
                            insightRow(title: "Financial Approach", text: res.financialSummary)
                            insightRow(title: "Career & Work Pace", text: res.careerSummary)
                            insightRow(title: "Living & In-laws", text: res.familySummary)
                            insightRow(title: "Conflict Resolution", text: res.communicationSummary)
                        }
                        .padding(18)
                        .background(Color(NSColor.controlBackgroundColor))
                        .cornerRadius(12)
                    }
                    
                    // Prompts
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Pre-Marital Conversation Starters", systemImage: "bubble.left.and.bubble.right.fill")
                            .font(.headline)
                        
                        ForEach(res.conversationPrompts, id: \.self) { prompt in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "quote.opening")
                                    .font(.caption)
                                    .foregroundColor(.indigo)
                                Text(prompt)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(12)
                            .background(Color(NSColor.textBackgroundColor))
                            .cornerRadius(8)
                        }
                    }
                    .padding(18)
                    .background(Color(NSColor.controlBackgroundColor))
                    .cornerRadius(12)
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
                    .foregroundColor(.green)
                
                Text("Why we will never operate like Astrotalk, and why we will never be a casual hookup app.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                manifestoPoint(
                    title: "1. Zero Fear-Mongering",
                    body: "Traditional astrology apps profit by manufacturing anxiety ('You are under a negative transit; pay ₹500 to fix it'). K.N.O.T. treats celestial data strictly as a cultural compass. We never send panic notifications, predict disasters, or sell remedies."
                )
                
                manifestoPoint(
                    title: "2. Solving the Cold-Start Problem (Progressive Disclosure)",
                    body: "Apps that require exact hospital birth times and coordinates on day one experience massive drop-offs. K.N.O.T. allows users to verify intent and values first. Detailed ephemeris data is an opt-in unlock after two people mutually match."
                )
                
                manifestoPoint(
                    title: "3. Intentional Marriage Over Endless Swiping",
                    body: "We do not monetize screen addiction. Instead of infinite cards, users receive 3 curated daily introductions. Our goal is to be deleted because our members find their life partner."
                )
            }
            .padding(32)
            .frame(maxWidth: 760)
        }
    }
    
    private func manifestoPoint(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
            Text(body)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineSpacing(4)
        }
        .padding(16)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(10)
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
        .background(Color(NSColor.textBackgroundColor))
        .cornerRadius(8)
    }
    
    private func moonBadge(name: String, moon: CelestialPosition) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name).font(.caption.bold())
            Text("\(moon.rashi.name) (\(moon.rashi.sanskrit))").font(.subheadline.bold()).foregroundColor(.indigo)
            Text("\(moon.nakshatra.name) • Pada \(moon.pada)").font(.caption2).foregroundColor(.secondary)
        }
    }
    
    private func insightRow(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title).font(.caption2.bold()).foregroundColor(.secondary)
            Text(text).font(.subheadline).foregroundColor(.primary)
        }
        .padding(.vertical, 2)
    }
    
    private func calculate() {
        result = Engine.evaluate(p1: p1, p2: p2)
    }
}
