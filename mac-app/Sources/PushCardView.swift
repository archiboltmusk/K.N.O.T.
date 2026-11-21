import SwiftUI

public struct PushCardView: View {
    @State private var selectedIndex = 0
    @State private var copiedNotice = false
    
    public struct CosmicQuote {
        public let kicker: String
        public let quote: String
        public let cosmicAspect: String
        public let actionableTip: String
    }
    
    private let quotes: [CosmicQuote] = [
        CosmicQuote(
            kicker: "MORNING REALITY CHECK • 8:00 AM",
            quote: "Check your investment balance before texting someone who takes six hours to reply.",
            cosmicAspect: "Mercury Trine Saturn in Capricorn",
            actionableTip: "High-value energy focuses on compounding freedom, not chasing ambivalent attention."
        ),
        CosmicQuote(
            kicker: "RELATIONSHIP HORIZON",
            quote: "Do not confuse nervous anxiety with romantic chemistry. Peace is the ultimate green flag.",
            cosmicAspect: "Venus Sextile Jupiter in Taurus",
            actionableTip: "Notice how your nervous system feels around them on an ordinary Tuesday evening."
        ),
        CosmicQuote(
            kicker: "SATURN EXPANSION",
            quote: "If you have to diminish your career ambitions to make them comfortable, you are in the wrong room.",
            cosmicAspect: "Mars Conjunct Sun in Leo",
            actionableTip: "The right life partner acts as your greatest catalyst, not your ceiling."
        ),
        CosmicQuote(
            kicker: "SHASTRIC WISDOM",
            quote: "A low Guna score is not a death sentence; lack of financial transparency is.",
            cosmicAspect: "Jupiter Station Direct",
            actionableTip: "True marital durability lives in honest budgeting conversations, not fear-based remedies."
        )
    ]
    
    public init() {}
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 6) {
                    Label("VIRAL COSMIC CARDS", systemImage: "sparkles")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.gold)
                    Text("Daily Shubh Muhurat Editorial Cards")
                        .font(.system(size: 26, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                    Text("Sharp psychological reflections formatted for Instagram Stories. Organic acquisition loop.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 24)
                
                // Story Card Preview (9:16 Aspect Ratio Look)
                storyCard(quote: quotes[selectedIndex])
                    .frame(maxWidth: 380)
                
                // Card Carousel Picker
                HStack(spacing: 12) {
                    ForEach(0..<quotes.count, id: \.self) { idx in
                        Circle()
                            .fill(idx == selectedIndex ? KnotTheme.gold : Color.white.opacity(0.15))
                            .frame(width: 8, height: 8)
                    }
                }
                
                // Actions
                HStack(spacing: 16) {
                    Button(action: nextQuote) {
                        Label("Next Card", systemImage: "arrow.clockwise")
                            .font(.subheadline.bold())
                    }
                    .buttonStyle(.bordered)
                    .tint(KnotTheme.gold)
                    
                    Button(action: copyToClipboard) {
                        Label(copiedNotice ? "Copied!" : "Share / Copy Card Text", systemImage: "square.and.arrow.up")
                            .font(.headline)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 12)
                    .background(KnotTheme.goldGradient)
                    .clipShape(Capsule())
                    .buttonStyle(.plain)
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 24)
        }
        .background(KnotTheme.bgDeep)
    }
    
    private func storyCard(quote: CosmicQuote) -> some View {
        VStack(alignment: .leading, spacing: 24) {
            // Card Header
            HStack {
                HStack(spacing: 6) {
                    Circle().stroke(KnotTheme.gold, lineWidth: 1).frame(width: 20, height: 20)
                        .overlay(Text("K").font(.system(size: 10, weight: .bold, design: .serif)).foregroundColor(KnotTheme.gold))
                    Text("K.N.O.T.")
                        .font(.system(size: 13, weight: .bold, design: .serif))
                        .foregroundColor(KnotTheme.gold)
                }
                Spacer()
                Text(quote.kicker)
                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                    .foregroundColor(.secondary)
            }
            
            Divider().background(KnotTheme.border)
            
            // Core Quote
            Text(quote.quote)
                .font(.system(size: 26, weight: .regular, design: .serif))
                .foregroundColor(.white)
                .lineSpacing(8)
                .padding(.vertical, 12)
            
            // Planetary Aspect & Tip
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "moon.stars.fill")
                        .font(.caption2)
                        .foregroundColor(KnotTheme.purple)
                    Text(quote.cosmicAspect)
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.purple)
                }
                
                Text(quote.actionableTip)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }
            .padding(14)
            .background(KnotTheme.bgDeep)
            .cornerRadius(12)
            
            // Watermark Footer
            HStack {
                Text("knot.app • Dating for Marriage")
                    .font(.system(size: 9, weight: .semibold, design: .monospaced))
                    .foregroundColor(.secondary)
                Spacer()
                Text("@knot.matrimony")
                    .font(.system(size: 9, weight: .semibold, design: .monospaced))
                    .foregroundColor(KnotTheme.gold.opacity(0.8))
            }
        }
        .padding(28)
        .background(
            LinearGradient(
                colors: [Color(red: 0.12, green: 0.12, blue: 0.18), Color(red: 0.08, green: 0.08, blue: 0.12)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(KnotTheme.borderGold, lineWidth: 1.5)
        )
        .shadow(color: Color.black.opacity(0.6), radius: 30, y: 15)
    }
    
    private func nextQuote() {
        withAnimation {
            selectedIndex = (selectedIndex + 1) % quotes.count
            copiedNotice = false
        }
    }
    
    private func copyToClipboard() {
        let q = quotes[selectedIndex]
        let text = "\(q.quote)\n\n— \(q.cosmicAspect)\nTip: \(q.actionableTip)\n\nvia K.N.O.T. (knot.app)"
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.setString(text, forType: .string)
        withAnimation { copiedNotice = true }
    }
}
