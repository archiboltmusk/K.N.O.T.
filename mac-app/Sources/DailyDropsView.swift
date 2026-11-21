import SwiftUI

public struct DailyDropsView: View {
    @State private var currentIndex: Int = 0
    @State private var blurPhotos: Bool = false
    @State private var showingVaultModal: Bool = false
    @State private var showingRoseModal: Bool = false
    @State private var intentionNoteText: String = ""
    @State private var likedPrompt: String? = nil
    
    private let candidates = SampleCandidates.candidates
    
    public init() {}
    
    public var body: some View {
        HStack(spacing: 0) {
            // Main Feed Area (Phone / Card Viewport)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Top Bar
                    feedHeader
                    
                    if currentIndex < candidates.count {
                        let candidate = candidates[currentIndex]
                        
                        // Hinge / Raya Style Profile Card Deck
                        VStack(spacing: 16) {
                            // 1. Hero Photo Card with Scrim & Badges
                            heroPhotoCard(candidate: candidate)
                            
                            // 2. Voice Prompt Audio Card (Inspired by Hinge)
                            voicePromptCard(candidate: candidate)
                            
                            // 3. Dasha Horizon Timing Curve (Inspired by The Pattern)
                            dashaTimingCurveCard(candidate: candidate)
                            
                            // 4. Cosmic & Psychological Translation Card
                            cosmicSynergyCard(candidate: candidate)
                            
                            // 5. Prompt Card 1 (Hinge Style)
                            promptCard(
                                title: candidate.prompt1Title,
                                answer: candidate.prompt1Answer
                            )
                            
                            // 6. The 4 Reality Values Card
                            valuesOverviewCard(candidate: candidate)
                            
                            // 7. Prompt Card 2
                            promptCard(
                                title: candidate.prompt2Title,
                                answer: candidate.prompt2Answer
                            )
                        }
                        .frame(maxWidth: 580)
                        
                        // Floating Bottom Action Bar
                        actionDock(candidate: candidate)
                            .frame(maxWidth: 580)
                            .padding(.top, 12)
                            .padding(.bottom, 40)
                    } else {
                        emptyStateView
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity)
            .background(KnotTheme.bgDeep)
            
            Divider()
                .background(KnotTheme.border)
            
            // Right-Side Live Match Inspector (Desktop Power Feature)
            if currentIndex < candidates.count {
                inspectorSidebar(candidate: candidates[currentIndex])
                    .frame(width: 340)
                    .background(KnotTheme.bgSurface)
            }
        }
        .sheet(isPresented: $showingVaultModal) {
            if currentIndex < candidates.count {
                vaultDossierModal(candidate: candidates[currentIndex])
            }
        }
        .sheet(isPresented: $showingRoseModal) {
            if currentIndex < candidates.count {
                roseIntentionModal(candidate: candidates[currentIndex])
            }
        }
    }
    
    // MARK: - Feed Header
    private var feedHeader: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 8) {
                    Text("3 Cosmic Drops")
                        .font(.system(size: 22, weight: .bold, design: .serif))
                        .foregroundColor(KnotTheme.gold)
                    Text("• 8:00 PM Shubh Muhurat")
                        .font(.system(size: 11, weight: .semibold, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                Text("Curated via Vedic synastry (Ashtakoota + D9) and lifestyle values.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            // Privacy Shield Toggle
            Button(action: { withAnimation { blurPhotos.toggle() } }) {
                HStack(spacing: 6) {
                    Image(systemName: blurPhotos ? "eye.slash.fill" : "eye.fill")
                        .font(.caption)
                    Text(blurPhotos ? "Shield Active" : "Blur Photos")
                        .font(.caption.bold())
                }
                .foregroundColor(blurPhotos ? KnotTheme.purple : .secondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(blurPhotos ? KnotTheme.purple.opacity(0.15) : KnotTheme.bgCard)
                .overlay(
                    Capsule()
                        .stroke(blurPhotos ? KnotTheme.purple.opacity(0.4) : KnotTheme.border, lineWidth: 1)
                )
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
            .help("Women-first privacy shield to prevent screenshots")
        }
        .frame(maxWidth: 580)
    }
    
    // MARK: - Hero Photo Card
    private func heroPhotoCard(candidate: CandidateCardData) -> some View {
        ZStack(alignment: .bottomLeading) {
            // Gradient Mesh Background simulating high-end photography
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: candidate.avatarGrad,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 480)
                .overlay(
                    // Luxury Monogram watermark
                    Text(String(candidate.name.prefix(1)))
                        .font(.system(size: 180, weight: .ultraLight, design: .serif))
                        .foregroundColor(.white.opacity(0.15))
                        .blur(radius: blurPhotos ? 24 : 0)
                )
                .blur(radius: blurPhotos ? 18 : 0)
            
            // Scrim Overlay
            LinearGradient(
                colors: [.clear, .black.opacity(0.4), .black.opacity(0.92)],
                startPoint: .center,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
            // Profile Info Overlay
            VStack(alignment: .leading, spacing: 10) {
                // Verified & Kundli Chips
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                        Text("Verified Identity")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    
                    HStack(spacing: 4) {
                        Image(systemName: "sparkles")
                            .foregroundColor(KnotTheme.gold)
                        Text("Verified Kundli")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(KnotTheme.gold)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    
                    HStack(spacing: 4) {
                        Image(systemName: "lock.shield.fill")
                            .foregroundColor(KnotTheme.purple)
                        Text("KNOT-A94F81C")
                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                            .foregroundColor(.white.opacity(0.85))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(KnotTheme.purple.opacity(0.2))
                    .clipShape(Capsule())
                    
                    Spacer()
                    
                    // Score Disc
                    ZStack {
                        Circle()
                            .fill(KnotTheme.bgDeep.opacity(0.85))
                            .frame(width: 46, height: 46)
                            .overlay(
                                Circle().stroke(KnotTheme.gold.opacity(0.4), lineWidth: 1.5)
                            )
                        VStack(spacing: 0) {
                            Text("\(candidate.knotIndex)")
                                .font(.system(size: 16, weight: .bold, design: .serif))
                                .foregroundColor(KnotTheme.gold)
                            Text("KMVA")
                                .font(.system(size: 7, weight: .bold, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // Name & Age
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(candidate.name)
                        .font(.system(size: 32, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                    Text("\(candidate.age)")
                        .font(.system(size: 26, weight: .light, design: .serif))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                // Profession & Education
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Image(systemName: "briefcase.fill")
                            .font(.caption2)
                            .foregroundColor(KnotTheme.gold)
                        Text("\(candidate.role) • \(candidate.company)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    HStack(spacing: 6) {
                        Image(systemName: "graduationcap.fill")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(candidate.education)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.75))
                    }
                    
                    HStack(spacing: 6) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text("\(candidate.city) • \(candidate.height)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.75))
                    }
                }
            }
            .padding(24)
        }
        .frame(height: 480)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(KnotTheme.border, lineWidth: 1)
        )
    }
    
    // MARK: - Voice Prompt Card (Hinge Inspired)
    @State private var isPlayingVoice = false
    
    private func voicePromptCard(candidate: CandidateCardData) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("VOICE PROMPT • 0:28", systemImage: "waveform")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(KnotTheme.gold)
                Spacer()
                Text("Recorded Yesterday")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            Text("\"The most spontaneous decision I've made this year...\"")
                .font(.system(size: 16, weight: .semibold, design: .serif))
                .foregroundColor(.white)
            
            // Audio Playback Bar & Waveform
            HStack(spacing: 14) {
                Button(action: { isPlayingVoice.toggle() }) {
                    ZStack {
                        Circle().fill(KnotTheme.goldGradient).frame(width: 44, height: 44)
                        Image(systemName: isPlayingVoice ? "pause.fill" : "play.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
                .buttonStyle(.plain)
                
                // Animated Waveform Simulation
                HStack(spacing: 3) {
                    ForEach(0..<24, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(isPlayingVoice ? KnotTheme.gold : Color.white.opacity(0.2))
                            .frame(width: 4, height: CGFloat(sin(Double(i) * 0.8) * 12.0 + 16.0))
                            .animation(.easeInOut(duration: 0.3).repeatForever().delay(Double(i) * 0.04), value: isPlayingVoice)
                    }
                }
                
                Spacer()
                
                Text(isPlayingVoice ? "0:14" : "0:28")
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(.secondary)
            }
            .padding(14)
            .background(KnotTheme.bgDeep)
            .cornerRadius(12)
        }
        .padding(20)
        .background(KnotTheme.bgCard)
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(KnotTheme.border, lineWidth: 1))
    }
    
    // MARK: - Dasha Horizon Timing Curve (The Pattern Inspired)
    private func dashaTimingCurveCard(candidate: CandidateCardData) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Label("DASHA HORIZON • LIFE TIMING", systemImage: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(KnotTheme.purple)
                Spacer()
                Text("Timing in Sync: 94%")
                    .font(.caption.bold())
                    .foregroundColor(KnotTheme.emerald)
            }
            
            Divider().background(KnotTheme.border)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Circle().fill(KnotTheme.indigo).frame(width: 8, height: 8)
                    Text("Your Life Phase: Jupiter-Mercury")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                    Spacer()
                    Text("Career & Intellectual Expansion")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 8) {
                    Circle().fill(KnotTheme.gold).frame(width: 8, height: 8)
                    Text("\(candidate.name)'s Phase: Venus-Moon")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                    Spacer()
                    Text("Partnership & Nesting Readiness")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .padding(12)
            .background(KnotTheme.bgDeep)
            .cornerRadius(10)
            
            Text("Timing Analysis: Both of you are entering complementary multi-year periods where personal career achievements naturally stabilize to welcome long-term marriage.")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineSpacing(3)
        }
        .padding(20)
        .background(KnotTheme.bgCard)
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(KnotTheme.border, lineWidth: 1))
    }
    
    // MARK: - Cosmic Synergy Card (Psychological Translation)
    private func cosmicSynergyCard(candidate: CandidateCardData) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Label("Cosmic Synergy & Banter", systemImage: "sparkles")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(KnotTheme.gold)
                    .textCase(.uppercase)
                Spacer()
                Text("Moon in \(candidate.moonSign)")
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
            }
            
            Divider().background(KnotTheme.border)
            
            // Translated Badges
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(candidate.banterScore)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(KnotTheme.indigo)
                    Text(candidate.banterDesc)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(KnotTheme.bgDeep)
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(candidate.pacingScore)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(KnotTheme.purple)
                    Text(candidate.pacingDesc)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(KnotTheme.bgDeep)
                .cornerRadius(12)
            }
            
            // Dynamic Icebreaker Prompt
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "quote.opening")
                    .font(.caption)
                    .foregroundColor(KnotTheme.orange)
                    .padding(.top, 2)
                VStack(alignment: .leading, spacing: 2) {
                    Text("COSMIC ICEBREAKER")
                        .font(.system(size: 8, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.orange)
                    Text("Your Mars harmonizes with her Venus: Ask her what's the one trivial opinion she will defend to the death.")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
            }
            .padding(12)
            .background(KnotTheme.orange.opacity(0.08))
            .cornerRadius(10)
        }
        .padding(20)
        .background(KnotTheme.bgCard)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(KnotTheme.border, lineWidth: 1)
        )
    }
    
    // MARK: - Prompt Card (Hinge Style with Like Heart)
    private func promptCard(title: String, answer: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                    .foregroundColor(KnotTheme.gold)
                    .textCase(.uppercase)
                Spacer()
                Button(action: {
                    likedPrompt = title
                }) {
                    Image(systemName: likedPrompt == title ? "heart.fill" : "heart")
                        .foregroundColor(likedPrompt == title ? .red : .secondary)
                        .font(.system(size: 16))
                }
                .buttonStyle(.plain)
            }
            
            Text(answer)
                .font(.system(size: 18, weight: .regular, design: .serif))
                .foregroundColor(.white)
                .lineSpacing(6)
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(KnotTheme.bgCard)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(KnotTheme.border, lineWidth: 1)
        )
    }
    
    // MARK: - Values Overview Card
    private func valuesOverviewCard(candidate: CandidateCardData) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Real-World Marriage Foundations", systemImage: "heart.text.square.fill")
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundColor(KnotTheme.gold)
                .textCase(.uppercase)
            
            Divider().background(KnotTheme.border)
            
            VStack(spacing: 10) {
                valuePillRow(icon: "chart.line.uptrend.xyaxis", label: "Finances", value: candidate.financialLabel)
                valuePillRow(icon: "briefcase.fill", label: "Career Pacing", value: candidate.careerLabel)
                valuePillRow(icon: "house.fill", label: "Living Dynamics", value: candidate.familyLabel)
                valuePillRow(icon: "bubble.left.and.bubble.right.fill", label: "Conflict Style", value: candidate.conflictLabel)
            }
        }
        .padding(20)
        .background(KnotTheme.bgCard)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(KnotTheme.border, lineWidth: 1)
        )
    }
    
    private func valuePillRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(KnotTheme.gold)
                .frame(width: 20)
            Text(label)
                .font(.caption.bold())
                .foregroundColor(.secondary)
                .frame(width: 90, alignment: .leading)
            Spacer()
            Text(value)
                .font(.caption)
                .foregroundColor(.primary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(KnotTheme.bgDeep)
        .cornerRadius(8)
    }
    
    // MARK: - Action Dock (Pass, Vault, Rose, Connect)
    private func actionDock(candidate: CandidateCardData) -> some View {
        HStack(spacing: 16) {
            // Pass Button
            Button(action: nextCandidate) {
                ZStack {
                    Circle()
                        .fill(KnotTheme.bgCard)
                        .frame(width: 52, height: 52)
                        .overlay(Circle().stroke(KnotTheme.border, lineWidth: 1))
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)
            .help("Pass introduction")
            
            // Send Rose with Note (Hinge Standout Feature)
            Button(action: { showingRoseModal = true }) {
                ZStack {
                    Circle()
                        .fill(KnotTheme.bgCard)
                        .frame(width: 52, height: 52)
                        .overlay(Circle().stroke(Color.pink.opacity(0.5), lineWidth: 1.5))
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.pink)
                }
            }
            .buttonStyle(.plain)
            .help("Send a Rose with an Intention Note")
            
            // Family-Ready Vault Button
            Button(action: { showingVaultModal = true }) {
                HStack(spacing: 6) {
                    Image(systemName: "doc.badge.shield.checkmark.fill")
                        .foregroundColor(KnotTheme.gold)
                    Text("Family Vault")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .frame(height: 52)
                .background(KnotTheme.bgCard)
                .overlay(
                    Capsule().stroke(KnotTheme.gold.opacity(0.35), lineWidth: 1.5)
                )
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
            .help("1-Page Parent-Ready Kundli Dossier")
            
            // Send Intent Button (Primary CTA)
            Button(action: nextCandidate) {
                HStack(spacing: 8) {
                    Image(systemName: "ring.circle.fill")
                    Text("Send Intent")
                        .font(.headline)
                }
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .frame(height: 52)
                .background(KnotTheme.goldGradient)
                .clipShape(Capsule())
                .shadow(color: KnotTheme.gold.opacity(0.3), radius: 10, y: 4)
            }
            .buttonStyle(.plain)
        }
    }
    
    // MARK: - Rose with Intention Note Modal
    private func roseIntentionModal(candidate: CandidateCardData) -> some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.fill")
                .font(.system(size: 40))
                .foregroundColor(.pink)
            
            Text("Send Intention Rose to \(candidate.name)")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            Text("Skip the queue. Sending a Rose with a thoughtful intention note has a 3.4x higher response rate among verified high-intent members.")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $intentionNoteText)
                .font(.body)
                .padding(10)
                .background(KnotTheme.bgCard)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(KnotTheme.borderGold, lineWidth: 1)
                )
                .frame(height: 120)
            
            HStack(spacing: 12) {
                Button("Cancel") {
                    showingRoseModal = false
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.secondary.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(8)
                .buttonStyle(.plain)
                
                Button("Send Rose & Note") {
                    showingRoseModal = false
                    intentionNoteText = ""
                    nextCandidate()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(KnotTheme.gold)
                .foregroundColor(.black)
                .cornerRadius(8)
                .buttonStyle(.plain)
            }
        }
        .padding(28)
        .frame(width: 480, height: 380)
        .background(KnotTheme.bgDeep)
    }
    
    // MARK: - Right Inspector Sidebar
    private func inspectorSidebar(candidate: CandidateCardData) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Match Insights")
                    .font(.system(size: 16, weight: .bold, design: .serif))
                    .foregroundColor(KnotTheme.gold)
                
                // Concurrency Monitor
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Label("Active Concurrency", systemImage: "clock.badge.checkmark.fill")
                            .font(.caption.bold())
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("1 / 3 Slots")
                            .font(.caption.bold())
                            .foregroundColor(KnotTheme.emerald)
                    }
                    ProgressView(value: 1, total: 3)
                        .tint(KnotTheme.emerald)
                    Text("Anti-Ghosting Protected: 48h reply grace timer active on new connections.")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
                .padding(14)
                .background(KnotTheme.bgCard)
                .cornerRadius(12)
                
                // Shastric Exception Status
                VStack(alignment: .leading, spacing: 8) {
                    Label("Shastric Status", systemImage: "checkmark.seal.fill")
                        .font(.caption.bold())
                        .foregroundColor(KnotTheme.gold)
                    
                    Text("✓ Bhakoot Dosha Cancelled: Planetary rulers share mutual friendship.")
                        .font(.caption2)
                        .foregroundColor(.primary)
                    Text("✓ Manglik Neutral: No adverse Mars placements.")
                        .font(.caption2)
                        .foregroundColor(.primary)
                }
                .padding(14)
                .background(KnotTheme.bgCard)
                .cornerRadius(12)
                
                // Quick UPI Deep Dive (₹49)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Label("Pre-Date Deep-Dive", systemImage: "bolt.shield.fill")
                            .font(.caption.bold())
                            .foregroundColor(.orange)
                        Spacer()
                        Text("₹49 via UPI")
                            .font(.caption.bold())
                            .foregroundColor(.orange)
                    }
                    Text("Unlock full AI + Vedic breakdown: Red flags, green flags, and where to take her on a first date.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    
                    Button("Unlock Deep Dive (₹49)") {}
                        .buttonStyle(.borderedProminent)
                        .tint(KnotTheme.orange)
                        .controlSize(.small)
                        .frame(maxWidth: .infinity)
                }
                .padding(14)
                .background(KnotTheme.orange.opacity(0.08))
                .cornerRadius(12)
            }
            .padding(20)
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "moon.stars.fill")
                .font(.system(size: 54))
                .foregroundColor(KnotTheme.gold)
            Text("You've Reviewed Today's 3 Drops")
                .font(.title2.bold())
            Text("To protect intentionality, K.N.O.T. curates introductions once per day. Your next 3 verified matches arrive tomorrow at 8:00 PM.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 420)
            
            Button("Review Again") {
                currentIndex = 0
            }
            .buttonStyle(.bordered)
            .tint(KnotTheme.gold)
        }
        .padding(.vertical, 80)
    }
    
    // MARK: - Family Vault Modal
    private func vaultDossierModal(candidate: CandidateCardData) -> some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Family-Ready Vault Dossier")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("A museum-grade, parent-ready horoscope sheet with cryptographic verification.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button("Done") { showingVaultModal = false }
                    .foregroundColor(.black)
            }
            
            Divider()
            
            // Ivory Sheet
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Text("CONFIDENTIAL MARRIAGE HOROSCOPE & BIO-DATA")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("KNOT-7F2A9B1C • VERIFIED")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(red: 0.04, green: 0.5, blue: 0.3))
                }
                
                Text("\(candidate.name) & Candidate")
                    .font(.system(size: 20, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                
                Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
                    GridRow {
                        Text("Guna Milan Score:").font(.caption.bold()).foregroundColor(.black)
                        Text("32 / 36 Auspicious Alignment").font(.caption).foregroundColor(Color(red: 0.04, green: 0.5, blue: 0.3))
                    }
                    GridRow {
                        Text("Education & Career:").font(.caption.bold()).foregroundColor(.black)
                        Text("\(candidate.education) • \(candidate.role)").font(.caption).foregroundColor(.black)
                    }
                    GridRow {
                        Text("Family Living:").font(.caption.bold()).foregroundColor(.black)
                        Text(candidate.familyLabel).font(.caption).foregroundColor(.black)
                    }
                    GridRow {
                        Text("Ephemeris Source:").font(.caption.bold()).foregroundColor(.black)
                        Text("Vedic Sidereal Lahiri (Swiss Ephemeris Precision)").font(.caption).foregroundColor(.gray)
                    }
                }
                .padding(14)
                .background(Color.black.opacity(0.04))
                .cornerRadius(8)
                
                // Classical Shastra Cancellation Citation Box
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image(systemName: "scroll.fill")
                            .foregroundColor(Color(red: 0.7, green: 0.5, blue: 0.1))
                        Text("Shastric Pandit Defense Brief (Certified Canonical Citations)")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.black)
                    }
                    Text("एकराशौ पृथग्ऋक्षे स्यातां वा तद्विपर्यये। नाडीदोषो न मन्तव्यो वरकन्यकयोः खलु॥")
                        .font(.system(size: 11, design: .serif))
                        .foregroundColor(.black)
                        .italic()
                    Text("— Muhurta Chintamani, Vivaha Prakarana, Shloka 38: 'Same Rashi, Different Nakshatras categorically NULLIFIES Nadi Dosha.' Certified proof for family astrologer.")
                        .font(.system(size: 10))
                        .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                }
                .padding(10)
                .background(Color(red: 0.95, green: 0.93, blue: 0.85))
                .cornerRadius(8)
                
                Text("Notice for Family: Formatted strictly as an authentic matrimonial horoscope. Contains zero dating app terminology, preserving family dignity.")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .italic()
            }
            .padding(24)
            .background(Color(red: 0.99, green: 0.99, blue: 0.97))
            .cornerRadius(12)
            
            HStack {
                Button("Print / Export 1-Page PDF") {
                    showingVaultModal = false
                }
                .buttonStyle(.borderedProminent)
                .tint(KnotTheme.indigo)
            }
        }
        .padding(24)
        .frame(width: 580, height: 460)
        .background(Color(red: 0.96, green: 0.96, blue: 0.94))
    }
    
    private func nextCandidate() {
        withAnimation(.easeInOut(duration: 0.2)) {
            currentIndex += 1
            likedPrompt = nil
        }
    }
}
