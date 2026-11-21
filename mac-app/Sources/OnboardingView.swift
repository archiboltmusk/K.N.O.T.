import SwiftUI

public struct OnboardingView: View {
    @State private var currentStep = 1
    
    // Form States
    @State private var fullName = "Rahul Sharma"
    @State private var workRole = "Senior Product Manager"
    @State private var company = "Microsoft"
    @State private var city = "Bangalore (Indiranagar)"
    @State private var marriageTimeline = "Within 1–2 Years"
    @State private var birthDate = Calendar.current.date(from: DateComponents(year: 1996, month: 7, day: 20)) ?? Date()
    
    // Values
    @State private var financialPhilosophy = "investor"
    @State private var careerPace = "high_drive"
    @State private var familyDynamics = "close_proximity"
    @State private var conflictStyle = "collaborative"
    
    // Step 3
    @State private var knowsBirthTime = false
    @State private var birthTime = Date()
    @State private var birthCity = "Bangalore, India"
    
    public var onComplete: (() -> Void)? = nil
    
    public init(onComplete: (() -> Void)? = nil) {
        self.onComplete = onComplete
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            // Left Input Flow (Multi-Step Form)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    // Header Step Indicator
                    stepIndicatorHeader
                    
                    switch currentStep {
                    case 1:
                        step1IdentityView
                    case 2:
                        step2DilemmasView
                    case 3:
                        step3CulturalView
                    default:
                        step4SuccessView
                    }
                    
                    // Bottom Navigation
                    stepNavigationFooter
                }
                .padding(36)
                .frame(maxWidth: 580)
            }
            .frame(maxWidth: .infinity)
            .background(KnotTheme.bgDeep)
            
            Divider()
                .background(KnotTheme.border)
            
            // Right Side: Live Luxury Profile Card Preview
            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Label("LIVE PROFILE PREVIEW", systemImage: "sparkles")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.gold)
                    Spacer()
                    Text("Updates in real-time")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
                
                livePreviewCard
                
                Spacer()
            }
            .padding(28)
            .frame(width: 380)
            .background(KnotTheme.bgSurface)
        }
    }
    
    // MARK: - Step Indicator
    private var stepIndicatorHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                ForEach(1...3, id: \.self) { idx in
                    Capsule()
                        .fill(idx <= currentStep ? KnotTheme.gold : Color.white.opacity(0.1))
                        .frame(height: 4)
                }
            }
            
            HStack {
                Text("Step \(min(currentStep, 3)) of 3")
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                    .foregroundColor(KnotTheme.gold)
                    .textCase(.uppercase)
                Spacer()
                Text("High-Intent Verification • < 90 Seconds")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // MARK: - Step 1: Professional Identity
    private var step1IdentityView: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Professional Identity & Intent")
                    .font(.system(size: 26, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                Text("K.N.O.T. filters out casual daters and bots by verifying intent and career background.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // LinkedIn Verified Banner
            HStack(spacing: 14) {
                ZStack {
                    Circle().fill(Color.blue.opacity(0.15)).frame(width: 38, height: 38)
                    Image(systemName: "checkmark.seal.fill").foregroundColor(.blue).font(.system(size: 18))
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Auto-Verified Professional Profile")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                    Text("Connected via LinkedIn OAuth • Zero fake accounts")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(14)
            .background(KnotTheme.bgCard)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(KnotTheme.border, lineWidth: 1))
            
            // Inputs
            VStack(alignment: .leading, spacing: 16) {
                luxuryInputField(label: "FULL LEGAL NAME", text: $fullName, placeholder: "e.g. Rahul Sharma")
                
                HStack(spacing: 16) {
                    luxuryInputField(label: "ROLE / DESIGNATION", text: $workRole, placeholder: "e.g. Product Manager")
                    luxuryInputField(label: "COMPANY / ORG", text: $company, placeholder: "e.g. Microsoft")
                }
                
                luxuryInputField(label: "PRIMARY LOCATION", text: $city, placeholder: "e.g. Bangalore / Mumbai")
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("MARRIAGE TIMELINE INTENT")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.gold)
                    
                    HStack(spacing: 10) {
                        timelinePill(title: "Within 6–12 Months")
                        timelinePill(title: "Within 1–2 Years")
                        timelinePill(title: "Exploring Seriously (2+ Yrs)")
                    }
                }
            }
        }
    }
    
    private func timelinePill(title: String) -> some View {
        Button(action: { marriageTimeline = title }) {
            Text(title)
                .font(.caption.bold())
                .foregroundColor(marriageTimeline == title ? .black : .white)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(marriageTimeline == title ? KnotTheme.goldGradient : LinearGradient(colors: [KnotTheme.bgCard], startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(marriageTimeline == title ? Color.clear : KnotTheme.border, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
    
    private func luxuryInputField(label: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundColor(KnotTheme.gold)
            TextField(placeholder, text: text)
                .textFieldStyle(.plain)
                .font(.system(size: 14, weight: .medium))
                .padding(12)
                .background(KnotTheme.bgCard)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(KnotTheme.border, lineWidth: 1)
                )
        }
    }
    
    // MARK: - Step 2: Dilemmas
    private var step2DilemmasView: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 6) {
                Text("The 4 Core Reality Pillars")
                    .font(.system(size: 26, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                Text("Situational choices that predict marital durability far more than superficial hobbies.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            dilemmaSelector(
                title: "1. Financial Philosophy",
                icon: "chart.line.uptrend.xyaxis",
                selection: $financialPhilosophy,
                options: [
                    ("investor", "Disciplined Investor", "Focuses on compounding equities, index funds, and buying financial autonomy."),
                    ("balanced", "Balanced & Prudent", "Enjoys lifestyle spending while maintaining systematic emergency cushions."),
                    ("saver", "Conservative Saver", "Prioritizes debt elimination and low-risk capital preservation.")
                ]
            )
            
            dilemmaSelector(
                title: "2. Career Rhythm & Pacing",
                icon: "briefcase.fill",
                selection: $careerPace,
                options: [
                    ("high_drive", "High-Drive Executive", "Demanding crunch rhythms with high trajectory aspirations."),
                    ("balanced", "Steady & Balanced", "Strict boundaries protecting evenings and weekends."),
                    ("entrepreneurial", "Entrepreneurial Fluid", "Dynamic startup rhythms that thrive outside strict 9-to-5s.")
                ]
            )
            
            dilemmaSelector(
                title: "3. Family Living Arrangements",
                icon: "house.fill",
                selection: $familyDynamics,
                options: [
                    ("close_proximity", "Close Proximity (Private Home)", "Same neighborhood as parents while maintaining couple privacy."),
                    ("nuclear", "Independent Nuclear Home", "Separate living space focused on the core partnership."),
                    ("joint", "Joint Family Living", "Sharing a household with extended family.")
                ]
            )
        }
    }
    
    private func dilemmaSelector(title: String, icon: String, selection: Binding<String>, options: [(String, String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: icon)
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundColor(KnotTheme.gold)
                .textCase(.uppercase)
            
            ForEach(options, id: \.0) { key, label, desc in
                Button(action: { selection.wrappedValue = key }) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: selection.wrappedValue == key ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(selection.wrappedValue == key ? KnotTheme.gold : .secondary)
                            .padding(.top, 2)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(label)
                                .font(.subheadline.bold())
                                .foregroundColor(selection.wrappedValue == key ? .white : .primary)
                            Text(desc)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(14)
                    .background(selection.wrappedValue == key ? KnotTheme.bgCardHover : KnotTheme.bgCard)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selection.wrappedValue == key ? KnotTheme.borderGold : KnotTheme.border, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    // MARK: - Step 3: Cultural Comfort
    private var step3CulturalView: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Cultural Roots & Ephemeris")
                    .font(.system(size: 26, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                Text("Basic astronomical signs are derived automatically. Exact time is optional until mutual match.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Progressive Disclosure Card
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 12) {
                    Image(systemName: "sparkles")
                        .foregroundColor(KnotTheme.gold)
                    Text("Progressive Disclosure: Zero Cold-Start Drop-off")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                }
                Text("You don't need your hospital birth certificate right now. Your Sun and general Moon signs are active immediately.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Divider().background(KnotTheme.border)
                
                // WhatsApp "Ask Mom" Card
                HStack(spacing: 12) {
                    Image(systemName: "message.fill")
                        .foregroundColor(KnotTheme.emerald)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("WhatsApp 'Ask Mom' Card")
                            .font(.caption.bold())
                            .foregroundColor(.white)
                        Text("One-tap polite message to ask your family for exact hospital birth time.")
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
                    .tint(KnotTheme.emerald)
                    .controlSize(.small)
                }
                .padding(12)
                .background(KnotTheme.emerald.opacity(0.08))
                .cornerRadius(10)
            }
            .padding(18)
            .background(KnotTheme.bgCard)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(KnotTheme.border, lineWidth: 1))
        }
    }
    
    // MARK: - Step 4: Success
    private var step4SuccessView: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle().fill(KnotTheme.emerald.opacity(0.15)).frame(width: 80, height: 80)
                Image(systemName: "checkmark.seal.fill").foregroundColor(KnotTheme.emerald).font(.system(size: 40))
            }
            
            Text("Verification Complete!")
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundColor(.white)
            
            Text("Your verified profile is established. Your first 3 curated introductions will arrive at 8:00 PM Shubh Muhurat.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 420)
            
            Button("Explore Daily Introductions") {
                if let done = onComplete {
                    done()
                } else {
                    currentStep = 1
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal, 28)
            .padding(.vertical, 14)
            .background(KnotTheme.goldGradient)
            .clipShape(Capsule())
            .shadow(color: KnotTheme.gold.opacity(0.3), radius: 8, y: 4)
            .buttonStyle(.plain)
            .padding(.top, 16)
        }
        .padding(.vertical, 60)
    }
    
    // MARK: - Live Preview Card (Right Side)
    private var livePreviewCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Mini Photo Card
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.35, green: 0.45, blue: 0.95), Color(red: 0.75, green: 0.35, blue: 0.85)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 240)
                
                LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .center, endPoint: .bottom)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(fullName.isEmpty ? "Your Name" : fullName)
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .foregroundColor(.white)
                        Text("28")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(.white.opacity(0.8))
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .font(.caption)
                    }
                    Text("\(workRole.isEmpty ? "Role" : workRole) • \(company.isEmpty ? "Company" : company)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.85))
                }
                .padding(14)
            }
            
            // Value Pills
            VStack(alignment: .leading, spacing: 6) {
                Text("YOUR VALUE PROFILE")
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                    .foregroundColor(KnotTheme.gold)
                
                HStack(spacing: 6) {
                    Text(financialPhilosophy.capitalized)
                        .font(.caption2.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(KnotTheme.bgCard)
                        .cornerRadius(6)
                    
                    Text(marriageTimeline)
                        .font(.caption2.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(KnotTheme.bgCard)
                        .cornerRadius(6)
                }
            }
        }
        .padding(14)
        .background(KnotTheme.bgDeep)
        .cornerRadius(18)
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(KnotTheme.border, lineWidth: 1))
    }
    
    // MARK: - Footer Navigation
    private var stepNavigationFooter: some View {
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
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(KnotTheme.goldGradient)
                .clipShape(Capsule())
                .buttonStyle(.plain)
            } else if currentStep == 3 {
                Button("Complete Verification") {
                    withAnimation { currentStep = 4 }
                }
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(KnotTheme.goldGradient)
                .clipShape(Capsule())
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 12)
    }
}
