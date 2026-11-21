import SwiftUI

// MARK: - Design System Tokens
public struct KnotTheme {
    public static let bgDeep = Color(red: 0.04, green: 0.04, blue: 0.06)
    public static let bgSurface = Color(red: 0.08, green: 0.08, blue: 0.12)
    public static let bgCard = Color(red: 0.11, green: 0.11, blue: 0.16)
    public static let bgCardHover = Color(red: 0.15, green: 0.15, blue: 0.22)
    
    public static let gold = Color(red: 0.91, green: 0.81, blue: 0.58)
    public static let goldLight = Color(red: 0.98, green: 0.93, blue: 0.78)
    public static let goldDark = Color(red: 0.72, green: 0.58, blue: 0.33)
    
    public static let goldGradient = LinearGradient(
        colors: [goldLight, gold, goldDark],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let indigo = Color(red: 0.39, green: 0.40, blue: 0.95)
    public static let purple = Color(red: 0.66, green: 0.33, blue: 0.97)
    public static let emerald = Color(red: 0.06, green: 0.73, blue: 0.51)
    public static let orange = Color(red: 0.98, green: 0.45, blue: 0.09)
    
    public static let border = Color.white.opacity(0.08)
    public static let borderGold = gold.opacity(0.35)
}

// MARK: - Candidate Profile Model
public struct CandidateCardData: Identifiable {
    public let id = UUID()
    public let name: String
    public let age: Int
    public let role: String
    public let company: String
    public let city: String
    public let height: String
    public let education: String
    public let knotIndex: Int
    public let moonSign: String
    public let nakshatra: String
    public let element: String
    
    public let prompt1Title: String
    public let prompt1Answer: String
    public let prompt2Title: String
    public let prompt2Answer: String
    
    public let financialLabel: String
    public let careerLabel: String
    public let familyLabel: String
    public let conflictLabel: String
    
    public let banterScore: String
    public let banterDesc: String
    public let pacingScore: String
    public let pacingDesc: String
    
    public let avatarGrad: [Color]
}

// Sample Data
public struct SampleCandidates {
    public static let candidates: [CandidateCardData] = [
        CandidateCardData(
            name: "Ananya Iyer",
            age: 28,
            role: "Senior Strategy Consultant",
            company: "McKinsey & Company",
            city: "Bangalore (Indiranagar)",
            height: "5'6\"",
            education: "IIM Ahmedabad • B.Tech IIT Madras",
            knotIndex: 92,
            moonSign: "Taurus (Vrishabha)",
            nakshatra: "Rohini",
            element: "Earth",
            prompt1Title: "A non-negotiable Sunday ritual...",
            prompt1Answer: "Early filter coffee at Brahmin's, reading historical non-fiction, followed by an uninterrupted 10km run before opening Slack.",
            prompt2Title: "The hill I will defend to the death...",
            prompt2Answer: "Financial independence is not about being stingy—it's about buying freedom so you never have to stay in a room you've outgrown.",
            financialLabel: "Disciplined Investor (Equities & Index)",
            careerLabel: "High-Drive Executive",
            familyLabel: "Close Proximity (Private Home)",
            conflictLabel: "Collaborative Discussion",
            banterScore: "Banter Score: 94%",
            banterDesc: "Both of you process high-stress workloads through dry, rapid humor.",
            pacingScore: "Passion & Pacing: 88%",
            pacingDesc: "You crave spontaneous weekend getaways; she needs a 48h plan. Perfect complementary balance.",
            avatarGrad: [Color(red: 0.95, green: 0.55, blue: 0.65), Color(red: 0.55, green: 0.35, blue: 0.95)]
        ),
        CandidateCardData(
            name: "Dr. Siddharth Mehta",
            age: 30,
            role: "Pediatric Cardiothoracic Surgeon",
            company: "Manipal Hospital",
            city: "Mumbai / Bangalore",
            height: "5'11\"",
            education: "MS Surgery, AIIMS Delhi",
            knotIndex: 88,
            moonSign: "Virgo (Kanya)",
            nakshatra: "Hasta",
            element: "Earth",
            prompt1Title: "My most controversial opinion...",
            prompt1Answer: "Couples who argue about in-laws usually haven't had an honest conversation about boundary-setting before getting married.",
            prompt2Title: "Together, we could...",
            prompt2Answer: "Build a life that feels peaceful on ordinary Tuesday nights, not just memorable on vacation.",
            financialLabel: "Balanced & Prudent Growth",
            careerLabel: "High-Drive Surgeon Pace",
            familyLabel: "Close Proximity to Parents",
            conflictLabel: "Reflective & Calm",
            banterScore: "Intellectual Complicity: 90%",
            banterDesc: "Effortless conversational depth across books, career ambition, and ethics.",
            pacingScore: "Circadian Sync: 86%",
            pacingDesc: "Both disciplined early risers with focused morning routines.",
            avatarGrad: [Color(red: 0.35, green: 0.65, blue: 0.95), Color(red: 0.25, green: 0.35, blue: 0.85)]
        ),
        CandidateCardData(
            name: "Meera Sen",
            age: 29,
            role: "Founding Product Designer",
            company: "Series-A FinTech",
            city: "Delhi NCR / Remote",
            height: "5'5\"",
            education: "NID Ahmedabad",
            knotIndex: 84,
            moonSign: "Pisces (Meena)",
            nakshatra: "Revati",
            element: "Water",
            prompt1Title: "What my friends love most about me...",
            prompt1Answer: "I can turn any chaotic week into an aesthetic, candlelit dinner with handmade pasta and deep conversation.",
            prompt2Title: "I'm looking for someone who...",
            prompt2Answer: "Has huge professional ambitions but can leave their laptop in the other room when we're talking about life.",
            financialLabel: "Experiential & Prudent",
            careerLabel: "Entrepreneurial / Dynamic",
            familyLabel: "Independent Nuclear Living",
            conflictLabel: "Reflective & Empathetic",
            banterScore: "Creative Synergy: 87%",
            banterDesc: "Mutual respect for creative freedom and independent professional identities.",
            pacingScore: "Fluid Momentum: 82%",
            pacingDesc: "Dynamic rhythms that flourish outside rigid corporate 9-to-5s.",
            avatarGrad: [Color(red: 0.95, green: 0.75, blue: 0.35), Color(red: 0.95, green: 0.45, blue: 0.25)]
        )
    ]
}
