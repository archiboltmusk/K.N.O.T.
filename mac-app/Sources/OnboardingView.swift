import SwiftUI

public struct OnboardingView: View {
    @State private var currentStep = 1
    
    // Step 1: Verification & Intent
    @State private var fullName = ""
    @State private var workRole = ""
    @State private var company = ""
    @State private var isLinkedInVerified = true
    @State private var birthDate = Calendar.current.date(from: DateComponents(year: 1996, month: 7, day: 20)) ?? Date()
    @State private var marriageTimeline = "Within 1–2 Years"
    
    // Step 2: The 4 Value Pillars
    @State private var financialPhilosophy = "investor"
    @State private var careerPace = "high_drive"
    @State private var familyDynamics = "close_proximity"
    @State private var communicationStyle = "collaborative"
    
    // Step 3: Cultural Comfort
    @State private var knowsBirthTime = false
    @State private var birthTime = Date()
    @State private var birthCity = "Bangalore, India"
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            // Header Progress Bar
            onboardingHeader
            
            Divider()
            
            // Step Content
            ScrollView {
                VStack(spacing: 24) {
                    switch currentStep {
                    case 1:
                        step1VerificationView
                    case 2:
                        step2ValuesView
                    case 3:
                        step3CulturalView
                    default:
                        step4SuccessView
                    }
                }
                .padding(32)
                .frame(maxWidth: 680)
            }
            
            Divider()
            
            // Footer Navigation
            onboardingFooter
        }
        .background(Color(NSColor.windowBackgroundColor))
    }
    
    // MARK: - Header
    private var onboardingHeader: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text("K.N.O.T. Onboarding")
                    .font(.headline)
                Text("Step \(min(currentStep, 3)) of 3 • High-Intent Verification (< 90 seconds)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Progress indicators
            HStack(spacing: 8) {
                ForEach(1...3, id: \.self) { idx in
                    Circle()
                        .fill(idx <= currentStep ? Color.indigo : Color.secondary.opacity(0.2))
                        .frame(width: 10, height: 10)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(Color(NSColor.controlBackgroundColor))
    }
    
    // MARK: - Step 1: Verification & Intent
    private var step1VerificationView: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Professional Identity & Intent")
                    .font(.title2.bold())
                Text("K.N.O.T. filters out casual daters and bots by verifying professional intent upfront.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // LinkedIn Verified Pill
            HStack(spacing: 12) {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.blue)
                    .font(.title3)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Verified Professional Profile")
                        .font(.subheadline.bold())
                    Text("Auto-verified via LinkedIn OAuth (No spam, no fake accounts)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Toggle("", isOn: $isLinkedInVerified)
                    .labelsHidden()
            }
            .padding(14)
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Full Name")
                    .font(.caption.bold())
                TextField("e.g. Rahul Sharma", text: $fullName)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Role / Designation")
                        .font(.caption.bold())
                    TextField("e.g. Senior Product Manager", text: $workRole)
                        .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Company / Organization")
                        .font(.caption.bold())
                    TextField("e.g. Microsoft", text: $company)
                        .textFieldStyle(.roundedBorder)
                }
            }
            
            HStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date of Birth")
                        .font(.caption.bold())
                    DatePicker("", selection: $birthDate, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Marriage Timeline Intent")
                        .font(.caption.bold())
                    Picker("", selection: $marriageTimeline) {
                        Text("Within 6–12 Months").tag("Within 6–12 Months")
                        Text("Within 1–2 Years").tag("Within 1–2 Years")
                        Text("Exploring Seriously (2+ Years)").tag("Exploring Seriously (2+ Years)")
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
            }
        }
    }
    
    // MARK: - Step 2: Value Pillars
    private var step2ValuesView: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 6) {
                Text("The 4 Core Reality Pillars")
                    .font(.title2.bold())
                Text("These fundamental values determine long-term marital harmony far more than superficial hobbies.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Financial Pillar
            valueCard(
                title: "1. Financial Philosophy",
                icon: "chart.line.uptrend.xyaxis",
                selection: $financialPhilosophy,
                options: [
                    ("investor", "Investor / Wealth Growth", "Focuses on compounding assets, equities, and calculated risk."),
                    ("balanced", "Balanced & Prudent", "Maintains healthy lifestyle while ensuring systematic savings."),
                    ("saver", "Disciplined Saver", "Prioritizes high emergency cushion and low-debt security."),
                    ("experiential", "Experiential Living", "Values travel and personal experiences over strict capital accumulation.")
                ]
            )
            
            // Career Pace
            valueCard(
                title: "2. Career Rhythm & Pacing",
                icon: "briefcase.fill",
                selection: $careerPace,
                options: [
                    ("high_drive", "High-Drive / Executive", "Demanding hours with ambitious growth trajectory."),
                    ("balanced", "Steady & Balanced", "Clear boundaries protecting evenings and weekends."),
                    ("entrepreneurial", "Entrepreneurial / Fluid", "Dynamic, unpredictable rhythm driven by startups/ventures.")
                ]
            )
            
            // Family Dynamics
            valueCard(
                title: "3. Family & Living Arrangements",
                icon: "house.fill",
                selection: $familyDynamics,
                options: [
                    ("close_proximity", "Close Proximity to Parents", "Living in the same city/neighborhood while maintaining a private home."),
                    ("nuclear", "Independent Nuclear Home", "Separate living space focused on the couple's core unit."),
                    ("joint", "Joint Family Living", "Sharing a household with extended family.")
                ]
            )
            
            // Communication
            valueCard(
                title: "4. Conflict Resolution Style",
                icon: "bubble.left.and.bubble.right.fill",
                selection: $communicationStyle,
                options: [
                    ("collaborative", "Collaborative Discussion", "Prefers talking through tensions calmly to find win-win outcomes."),
                    ("direct", "Direct & Immediate", "Tackles issues the moment they arise to clear the air."),
                    ("reflective", "Reflective & Measured", "Needs time to process emotions before discussing solutions.")
                ]
            )
        }
    }
    
    private func valueCard(title: String, icon: String, selection: Binding<String>, options: [(String, String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundColor(.indigo)
            
            ForEach(options, id: \.0) { key, label, desc in
                Button(action: { selection.wrappedValue = key }) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: selection.wrappedValue == key ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(selection.wrappedValue == key ? .indigo : .secondary)
                            .padding(.top, 2)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(label)
                                .font(.subheadline.bold())
                                .foregroundColor(.primary)
                            Text(desc)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(12)
                    .background(selection.wrappedValue == key ? Color.indigo.opacity(0.08) : Color(NSColor.controlBackgroundColor))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selection.wrappedValue == key ? Color.indigo.opacity(0.4) : Color.clear, lineWidth: 1.5)
                    )
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    // MARK: - Step 3: Cultural Comfort
    private var step3CulturalView: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Cultural Roots & Astrological Alignment")
                    .font(.title2.bold())
                Text("We calculate your basic celestial markers from your birth date. Exact time is 100% optional until you mutually match.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Progressive Disclosure Card
            HStack(spacing: 14) {
                Image(systemName: "sparkles")
                    .font(.title2)
                    .foregroundColor(.purple)
                VStack(alignment: .leading, spacing: 3) {
                    Text("No Cold-Start Drop-off")
                        .font(.subheadline.bold())
                    Text("You don't need your hospital birth certificate to get started. Basic astronomical positioning is derived from your birth date automatically.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(14)
            .background(Color.purple.opacity(0.08))
            .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 12) {
                Toggle("I know my exact birth time right now", isOn: $knowsBirthTime)
                    .font(.subheadline.bold())
                
                if knowsBirthTime {
                    HStack(spacing: 16) {
                        DatePicker("Birth Time (Exact)", selection: $birthTime, displayedComponents: [.hourAndMinute])
                            .datePickerStyle(.compact)
                        
                        TextField("Birth City", text: $birthCity)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.top, 4)
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("⚡ You can unlock full Kundli / Nakshatra Pada synergy later with any candidate you mutually match with.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        // WhatsApp "Ask Mom" Card
                        HStack(spacing: 12) {
                            Image(systemName: "message.fill")
                                .foregroundColor(.green)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("WhatsApp 'Ask Mom' Card")
                                    .font(.caption.bold())
                                Text("One-tap polite message to ask your family for your exact hospital birth time.")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Button("Copy Message") {
                                let pb = NSPasteboard.general
                                pb.clearContents()
                                pb.setString("Hey Maa/Papa, I'm filling out a verified marriage profile and need my exact birth details. Could you check my birth certificate or Kundli chart and share: 1. Exact time of birth, 2. Hospital / City of birth. Thank you!", forType: .string)
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.small)
                        }
                        .padding(10)
                        .background(Color.green.opacity(0.08))
                        .cornerRadius(8)
                    }
                    .padding(.top, 2)
                }
            }
            .padding(16)
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(10)
        }
    }
    
    // MARK: - Step 4: Success
    private var step4SuccessView: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.green)
            
            Text("Profile Verified & Ready!")
                .font(.title.bold())
            
            Text("Your high-intent profile has been established with your verified credentials, 4 core value pillars, and celestial baseline.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 480)
            
            Button("View My Daily Curated Drops") {
                currentStep = 1
            }
            .buttonStyle(.borderedProminent)
            .tint(.indigo)
            .padding(.top, 12)
        }
        .padding(.vertical, 40)
    }
    
    // MARK: - Footer
    private var onboardingFooter: some View {
        HStack {
            if currentStep > 1 && currentStep <= 3 {
                Button("Back") {
                    withAnimation { currentStep -= 1 }
                }
                .buttonStyle(.plain)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if currentStep < 3 {
                Button("Continue") {
                    withAnimation { currentStep += 1 }
                }
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
            } else if currentStep == 3 {
                Button("Complete Verification") {
                    withAnimation { currentStep = 4 }
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .background(Color(NSColor.controlBackgroundColor))
    }
}
