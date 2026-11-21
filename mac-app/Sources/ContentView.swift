import SwiftUI

public struct ContentView: View {
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
            sidebarView
        } detail: {
            detailView
        }
        .frame(minWidth: 980, minHeight: 680)
        .onAppear {
            calculate()
        }
    }
    
    private var sidebarView: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: "ring.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.indigo)
                    Text("K.N.O.T.")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                }
                Text("Knowledge • Navigation • Orbit • Trust")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 16)
            
            Divider()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Profile 1
                    profileInputCard(title: "Candidate 1", profile: $p1, accentColor: .indigo)
                    
                    // Profile 2
                    profileInputCard(title: "Candidate 2", profile: $p2, accentColor: .purple)
                }
                .padding(.bottom, 20)
            }
            
            Button(action: calculate) {
                HStack {
                    Image(systemName: "sparkles")
                    Text("Evaluate Compatibility")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
            .tint(.indigo)
            .padding(.bottom, 12)
        }
        .padding(.horizontal, 16)
        .frame(minWidth: 340, maxWidth: 380)
    }
    
    private func profileInputCard(title: String, profile: Binding<PersonProfile>, accentColor: Color) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Circle()
                    .fill(accentColor)
                    .frame(width: 8, height: 8)
                TextField("Name", text: profile.name)
                    .font(.headline)
                    .textFieldStyle(.plain)
            }
            
            DatePicker("Birth Timestamp", selection: profile.birthDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
                .font(.caption)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Financial Philosophy")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Picker("", selection: profile.financialPhilosophy) {
                    Text("Investor / Growth").tag("investor")
                    Text("Balanced / Prudent").tag("balanced")
                    Text("Disciplined Saver").tag("saver")
                    Text("Experiential").tag("experiential")
                }
                .pickerStyle(.menu)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Career Pacing")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Picker("", selection: profile.careerPace) {
                    Text("High-Drive / Executive").tag("high_drive")
                    Text("Steady / Work-Life Focus").tag("balanced")
                    Text("Entrepreneurial / Fluid").tag("entrepreneurial")
                }
                .pickerStyle(.menu)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Family Dynamics")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Picker("", selection: profile.familyDynamics) {
                    Text("Close Proximity to Family").tag("close_proximity")
                    Text("Independent Nuclear").tag("nuclear")
                    Text("Joint Family Living").tag("joint")
                }
                .pickerStyle(.menu)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Conflict & Communication")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Picker("", selection: profile.communicationStyle) {
                    Text("Direct & Immediate").tag("direct")
                    Text("Collaborative & Discussion").tag("collaborative")
                    Text("Reflective & Calm").tag("reflective")
                }
                .pickerStyle(.menu)
            }
        }
        .padding(14)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(10)
    }
    
    private var detailView: some View {
        ScrollView {
            if let res = result {
                VStack(spacing: 24) {
                    // Scorecard Hero
                    HStack(spacing: 32) {
                        // Circular Gauge
                        ZStack {
                            Circle()
                                .stroke(Color.secondary.opacity(0.15), lineWidth: 12)
                                .frame(width: 130, height: 130)
                            Circle()
                                .trim(from: 0, to: CGFloat(res.knotIndex / 100.0))
                                .stroke(
                                    LinearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing),
                                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .frame(width: 130, height: 130)
                            VStack(spacing: 2) {
                                Text("\(Int(res.knotIndex))")
                                    .font(.system(size: 38, weight: .bold, design: .rounded))
                                Text("K.N.O.T. INDEX")
                                    .font(.system(size: 9, weight: .semibold))
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(res.verdict)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            HStack(spacing: 20) {
                                scorePill(label: "Values Alignment", score: res.valuesScore, max: 100, color: .purple)
                                scorePill(label: "Celestial Harmony", score: res.celestialScore, max: 100, color: .indigo)
                            }
                        }
                        Spacer()
                    }
                    .padding(24)
                    .background(Color(NSColor.controlBackgroundColor))
                    .cornerRadius(12)
                    
                    // Dual Columns: Layer 1 & Layer 2
                    HStack(alignment: .top, spacing: 20) {
                        // Layer 1: Celestial & Cultural
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
                        
                        // Layer 2: Values & Reality
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
                    
                    // Pre-Marital Conversation Decks
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Recommended Pre-Marital Conversation Starters", systemImage: "bubble.left.and.bubble.right.fill")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        ForEach(res.conversationPrompts, id: \.self) { prompt in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "quote.opening")
                                    .font(.caption)
                                    .foregroundColor(.indigo)
                                    .padding(.top, 2)
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
                    
                    // Ethical Standard Footer
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                        Text("K.N.O.T. Truthful Standard: 100% transparent astronomical calculations. Zero fear-based warnings.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 8)
                }
                .padding(24)
            }
        }
    }
    
    private func scorePill(label: String, score: Double, max: Double, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
            HStack(spacing: 4) {
                Text("\(Int(score))")
                    .font(.title3.bold())
                    .foregroundColor(color)
                Text("/ \(Int(max))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Color(NSColor.textBackgroundColor))
        .cornerRadius(8)
    }
    
    private func moonBadge(name: String, moon: CelestialPosition) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name)
                .font(.caption.bold())
            Text("\(moon.rashi.name) (\(moon.rashi.sanskrit))")
                .font(.subheadline.bold())
                .foregroundColor(.indigo)
            Text("\(moon.nakshatra.name) • Pada \(moon.pada)")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
    
    private func insightRow(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.caption2.bold())
                .foregroundColor(.secondary)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 2)
    }
    
    private func calculate() {
        result = Engine.evaluate(p1: p1, p2: p2)
    }
}
