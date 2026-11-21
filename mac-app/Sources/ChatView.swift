import SwiftUI

public struct MatchMessage: Identifiable {
    public let id: String
    public let sender: String
    public let text: String
    public let timestamp: String
    public let isMe: Bool
    public let promptAttachment: String?
}

public struct MatchConversation: Identifiable {
    public let id: String
    public let name: String
    public let age: Int
    public let profession: String
    public let city: String
    public let matchScore: Int
    public let nakshatra: String
    public let ghostingHoursLeft: Int
    public let lastMessage: String
    public let unreadCount: Int
    public let avatarColor: Color
    public var messages: [MatchMessage]
    public let suggestedDateVenue: String
}

public struct ChatView: View {
    @State private var conversations: [MatchConversation] = [
        MatchConversation(
            id: "conv_1",
            name: "Ananya Iyer",
            age: 28,
            profession: "Senior Consultant @ McKinsey",
            city: "Indiranagar, Bengaluru",
            matchScore: 92,
            nakshatra: "Rohini (Moon in Taurus)",
            ghostingHoursLeft: 38,
            lastMessage: "I completely agree about the sabbatical in Kyoto! Have you stayed in Gion?",
            unreadCount: 1,
            avatarColor: Color(red: 0.85, green: 0.65, blue: 0.4),
            messages: [
                MatchMessage(
                    id: "m1",
                    sender: "K.N.O.T. Concierge",
                    text: "✨ KMVA Match formed at 8:00 PM Shubh Muhurat. Synastry highlights: Earth & Water harmony with shared high-drive career pace.",
                    timestamp: "Yesterday",
                    isMe: false,
                    promptAttachment: nil
                ),
                MatchMessage(
                    id: "m2",
                    sender: "Ananya",
                    text: "Hey! Loved your note on balancing venture building with quiet weekend hikes.",
                    timestamp: "Yesterday 9:15 PM",
                    isMe: false,
                    promptAttachment: "Prompt: The rhythm that keeps me sane"
                ),
                MatchMessage(
                    id: "m3",
                    sender: "You",
                    text: "Hi Ananya! Thanks. Kabini and Coorg have been my go-to resets lately. Also noticed we both have Kyoto on our 3-year bucket list!",
                    timestamp: "Today 10:20 AM",
                    isMe: true,
                    promptAttachment: nil
                ),
                MatchMessage(
                    id: "m4",
                    sender: "Ananya",
                    text: "I completely agree about the sabbatical in Kyoto! Have you stayed in Gion?",
                    timestamp: "Today 2:45 PM",
                    isMe: false,
                    promptAttachment: nil
                )
            ],
            suggestedDateVenue: "Blue Tokai Coffee Roasters, 12th Main Indiranagar"
        ),
        MatchConversation(
            id: "conv_2",
            name: "Dr. Maya Sen",
            age: 29,
            profession: "Cardiothoracic Surgeon @ Manipal",
            city: "Koramangala, Bengaluru",
            matchScore: 89,
            nakshatra: "Uttara Phalguni (Moon in Leo)",
            ghostingHoursLeft: 19,
            lastMessage: "That sounds like a great plan. Friday evening after 7 PM works!",
            unreadCount: 0,
            avatarColor: Color(red: 0.7, green: 0.5, blue: 0.85),
            messages: [
                MatchMessage(
                    id: "m20",
                    sender: "K.N.O.T. Concierge",
                    text: "✨ 89% Truthful Match. Mutual agreement on 50/50 dual career commitments.",
                    timestamp: "2 days ago",
                    isMe: false,
                    promptAttachment: nil
                ),
                MatchMessage(
                    id: "m21",
                    sender: "You",
                    text: "Would love to grab a quiet pour-over and hear about your research.",
                    timestamp: "Yesterday",
                    isMe: true,
                    promptAttachment: nil
                ),
                MatchMessage(
                    id: "m22",
                    sender: "Dr. Maya",
                    text: "That sounds like a great plan. Friday evening after 7 PM works!",
                    timestamp: "Yesterday 8:00 PM",
                    isMe: false,
                    promptAttachment: nil
                )
            ],
            suggestedDateVenue: "Third Wave Coffee Reserve, Koramangala 4th Block"
        )
    ]
    
    @State private var selectedConversationId: String = "conv_1"
    @State private var newMessageText: String = ""
    @State private var showingDateModal: Bool = false
    @State private var showingObserverModal: Bool = false
    @State private var showingWeMetModal: Bool = false
    
    public init() {}
    
    public var selectedConversation: MatchConversation? {
        conversations.first(where: { $0.id == selectedConversationId })
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            // Left Panel: Conversations List
            conversationsListPane
                .frame(width: 320)
                .background(KnotTheme.bgSurface)
            
            Divider().background(KnotTheme.border)
            
            // Right Panel: Active Chat & Intent Intelligence
            if let conv = selectedConversation {
                activeChatPane(conv: conv)
            } else {
                Text("Select a verified match to begin intentional conversation")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .sheet(isPresented: $showingDateModal) {
            dateBookingModal
        }
        .sheet(isPresented: $showingObserverModal) {
            observerShareModal
        }
        .sheet(isPresented: $showingWeMetModal) {
            weMetFeedbackModal
        }
    }
    
    // MARK: - Conversations List
    private var conversationsListPane: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Intentional Matches")
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .foregroundColor(KnotTheme.gold)
                    Text("Strict 3-concurrency active limit")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                    .foregroundColor(KnotTheme.gold)
            }
            .padding(16)
            
            Divider().background(KnotTheme.border)
            
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(conversations) { conv in
                        Button(action: { selectedConversationId = conv.id }) {
                            HStack(spacing: 12) {
                                // Avatar circle
                                ZStack {
                                    Circle()
                                        .fill(conv.avatarColor.opacity(0.3))
                                        .frame(width: 48, height: 48)
                                    Text(String(conv.name.prefix(1)))
                                        .font(.system(size: 20, weight: .bold, design: .serif))
                                        .foregroundColor(conv.avatarColor)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(conv.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Spacer()
                                        // Match badge
                                        Text("\(conv.matchScore)%")
                                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                                            .foregroundColor(KnotTheme.gold)
                                    }
                                    
                                    Text(conv.lastMessage)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                    
                                    // Anti-ghosting timer badge
                                    HStack(spacing: 4) {
                                        Image(systemName: "clock.arrow.circlepath")
                                            .font(.system(size: 9))
                                        Text("⏳ \(conv.ghostingHoursLeft)h grace left")
                                            .font(.system(size: 9, weight: .semibold, design: .monospaced))
                                    }
                                    .foregroundColor(conv.ghostingHoursLeft < 24 ? .orange : KnotTheme.gold)
                                    .padding(.top, 2)
                                }
                            }
                            .padding(12)
                            .background(selectedConversationId == conv.id ? KnotTheme.bgCard : Color.clear)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedConversationId == conv.id ? KnotTheme.borderGold : Color.clear, lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(12)
            }
        }
    }
    
    // MARK: - Active Chat Pane
    private func activeChatPane(conv: MatchConversation) -> some View {
        VStack(spacing: 0) {
            // Chat Header
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 8) {
                        Text(conv.name)
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .foregroundColor(.white)
                        Text(", \(conv.age)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .font(.caption)
                    }
                    Text("\(conv.profession) • \(conv.nakshatra)")
                        .font(.caption)
                        .foregroundColor(KnotTheme.gold)
                }
                
                Spacer()
                
                // Action Buttons (Date Concierge, Elder Observer, We Met)
                HStack(spacing: 10) {
                    Button(action: { showingWeMetModal = true }) {
                        HStack(spacing: 4) {
                            Image(systemName: "hand.wave.fill")
                            Text("We Met")
                        }
                        .font(.caption.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.secondary.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: { showingObserverModal = true }) {
                        HStack(spacing: 4) {
                            Image(systemName: "person.2.fill")
                            Text("Elder Pass")
                        }
                        .font(.caption.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.secondary.opacity(0.15))
                        .foregroundColor(KnotTheme.gold)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: { showingDateModal = true }) {
                        HStack(spacing: 4) {
                            Image(systemName: "cup.and.saucer.fill")
                            Text("Book Date")
                        }
                        .font(.caption.bold())
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(KnotTheme.gold)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(16)
            .background(KnotTheme.bgCard)
            
            Divider().background(KnotTheme.border)
            
            // Ghosting Grace Alert Banner
            HStack(spacing: 8) {
                Image(systemName: "hourglass")
                    .foregroundColor(conv.ghostingHoursLeft < 24 ? .orange : KnotTheme.gold)
                Text("Zero-Ghosting Policy: \(conv.ghostingHoursLeft) hours remaining to maintain match momentum and slot concurrency.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("Active Slot: 1 of 3")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(KnotTheme.gold)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.black.opacity(0.4))
            
            // 7-Day Meet-or-Release Banner (Anti-Pen-Pal Loophole Fix)
            HStack(spacing: 8) {
                Image(systemName: "calendar.badge.clock")
                    .foregroundColor(.orange)
                Text("Meet-or-Release Protocol: Day 6 of 7. Transition from endless texting to an in-person coffee via the AI Date Concierge, or release slot.")
                    .font(.caption2)
                    .foregroundColor(.orange)
                Spacer()
                Button("Book Venue") { showingDateModal = true }
                    .buttonStyle(.plain)
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.orange.opacity(0.2))
                    .foregroundColor(.orange)
                    .cornerRadius(6)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color.orange.opacity(0.08))
            
            // Messages Scroll
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(conv.messages) { msg in
                        messageBubble(msg: msg)
                    }
                }
                .padding(20)
            }
            
            Divider().background(KnotTheme.border)
            
            // Dynamic KMVA Icebreaker Pill
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .foregroundColor(KnotTheme.gold)
                Text("Vedic-Value Spark: Discuss your 5-year outlook on city living vs nature retreats.")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Button(action: {
                    newMessageText = "I noticed our alignment on city pace — do you prefer staying in central Bangalore or having a weekend sanctuary?"
                }) {
                    Text("Use Spark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(KnotTheme.gold)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(KnotTheme.bgSurface)
            
            // Input Bar
            VStack(spacing: 6) {
                if !newMessageText.isEmpty {
                    HStack(spacing: 6) {
                        Image(systemName: newMessageText.count < 12 ? "exclamationmark.triangle.fill" : "checkmark.circle.fill")
                            .font(.system(size: 10))
                            .foregroundColor(newMessageText.count < 12 ? .orange : KnotTheme.emerald)
                        Text(newMessageText.count < 12 ? "⚠️ Intent Density: 25% (Low-Effort). Write a meaningful thought or question to reset the 48h grace timer." : "✓ Intent Density: 95% (High Intent). Will protect match slot and extend 48h grace timer.")
                            .font(.system(size: 10, weight: .semibold, design: .monospaced))
                            .foregroundColor(newMessageText.count < 12 ? .orange : KnotTheme.emerald)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .transition(.opacity)
                }
                
                HStack(spacing: 12) {
                    TextField("Send an intentional message...", text: $newMessageText)
                        .textFieldStyle(.plain)
                        .padding(10)
                        .background(KnotTheme.bgCard)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(KnotTheme.border, lineWidth: 1)
                        )
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(KnotTheme.gold)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    .disabled(newMessageText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
            .background(KnotTheme.bgSurface)
        }
    }
    
    private func messageBubble(msg: MatchMessage) -> some View {
        HStack {
            if msg.isMe { Spacer() }
            
            VStack(alignment: msg.isMe ? .trailing : .leading, spacing: 4) {
                if let prompt = msg.promptAttachment {
                    Text(prompt)
                        .font(.system(size: 10, weight: .bold, design: .serif))
                        .foregroundColor(KnotTheme.gold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(6)
                }
                
                Text(msg.text)
                    .font(.subheadline)
                    .foregroundColor(msg.isMe ? .black : .white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(msg.isMe ? KnotTheme.gold : KnotTheme.bgCard)
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(msg.isMe ? Color.clear : KnotTheme.border, lineWidth: 1)
                    )
                
                Text(msg.timestamp)
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 4)
            }
            .frame(maxWidth: 480, alignment: msg.isMe ? .trailing : .leading)
            
            if !msg.isMe { Spacer() }
        }
    }
    
    private func sendMessage() {
        guard !newMessageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        if let idx = conversations.firstIndex(where: { $0.id == selectedConversationId }) {
            let newMsg = MatchMessage(
                id: "m_\(Date().timeIntervalSince1970)",
                sender: "You",
                text: newMessageText,
                timestamp: "Just now",
                isMe: true,
                promptAttachment: nil
            )
            conversations[idx].messages.append(newMsg)
            newMessageText = ""
        }
    }
    
    // MARK: - Modals
    private var dateBookingModal: some View {
        VStack(spacing: 20) {
            Image(systemName: "cup.and.saucer.fill")
                .font(.system(size: 40))
                .foregroundColor(KnotTheme.gold)
            
            Text("AI Date Concierge Reservation")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            Text("K.N.O.T. curated a low-decibel, high-comfort first date itinerary based on your combined Earth & Water elemental acoustics.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(KnotTheme.gold)
                    Text("Blue Tokai Coffee Roasters, Indiranagar 12th Main")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(KnotTheme.gold)
                    Text("Suggested Time: Saturday 4:30 PM (Mercury Hora)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(16)
            .background(KnotTheme.bgCard)
            .cornerRadius(12)
            
            Button("Send Invitation to Ananya") {
                showingDateModal = false
                newMessageText = "Would you like to meet at Blue Tokai Indiranagar this Saturday at 4:30 PM for a relaxed pour-over?"
                sendMessage()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(KnotTheme.gold)
            .foregroundColor(.black)
            .cornerRadius(10)
            .buttonStyle(.plain)
        }
        .padding(32)
        .frame(width: 500, height: 420)
        .background(KnotTheme.bgDeep)
    }
    
    private var observerShareModal: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.2.fill")
                .font(.system(size: 40))
                .foregroundColor(KnotTheme.gold)
            
            Text("Elder Observer Pass")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            Text("Generate a read-only, parent-dignified dossier link. Private chats and casual photos are cryptographically blocked; only verified educational, career, and Guna credentials are visible.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack {
                Text("https://knot.love/pass/e-8f92b7401")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(KnotTheme.gold)
                Spacer()
                Button("Copy Link") {}
                    .buttonStyle(.plain)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(KnotTheme.gold.opacity(0.2))
                    .foregroundColor(KnotTheme.gold)
                    .cornerRadius(6)
            }
            .padding(14)
            .background(KnotTheme.bgCard)
            .cornerRadius(10)
            
            Button("Done") { showingObserverModal = false }
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(Color.secondary.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(8)
                .buttonStyle(.plain)
        }
        .padding(32)
        .frame(width: 520, height: 380)
        .background(KnotTheme.bgDeep)
    }
    
    private var weMetFeedbackModal: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.text.square.fill")
                .font(.system(size: 40))
                .foregroundColor(KnotTheme.gold)
            
            Text("We Met Feedback")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            Text("Hinge-inspired private feedback loop. Did you meet in person? Your answer is 100% private and helps the KMVA engine calibrate future daily drops.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 12) {
                Button(action: { showingWeMetModal = false }) {
                    HStack {
                        Text("Yes, and we want to keep seeing each other! 🎉")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(14)
                    .background(KnotTheme.bgCard)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .buttonStyle(.plain)
                
                Button(action: { showingWeMetModal = false }) {
                    HStack {
                        Text("Yes, but not the right fit for marriage")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(14)
                    .background(KnotTheme.bgCard)
                    .foregroundColor(.secondary)
                    .cornerRadius(10)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(32)
        .frame(width: 480, height: 360)
        .background(KnotTheme.bgDeep)
    }
}
