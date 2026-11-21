import Foundation

public struct Rashi: Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let sanskrit: String
    public let element: String
    public let ruler: String
}

public struct Nakshatra: Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let ruler: String
    public let temperament: String
    public let symbol: String
}

public struct CelestialPosition: Hashable {
    public let longitude: Double
    public let rashi: Rashi
    public let nakshatra: Nakshatra
    public let pada: Int
    public let degreeInSign: Double
}

public struct PersonProfile: Hashable {
    public var name: String
    public var birthDate: Date
    public var financialPhilosophy: String // "investor", "saver", "balanced", "experiential"
    public var careerPace: String          // "high_drive", "balanced", "entrepreneurial"
    public var familyDynamics: String       // "close_proximity", "nuclear", "joint", "independent"
    public var communicationStyle: String    // "direct", "reflective", "collaborative"
    public var childrenPlan: String         // "definite_yes", "open_future", "not_preferred"
    
    public init(
        name: String = "Candidate",
        birthDate: Date = Date(),
        financialPhilosophy: String = "balanced",
        careerPace: String = "balanced",
        familyDynamics: String = "nuclear",
        communicationStyle: String = "collaborative",
        childrenPlan: String = "open_future"
    ) {
        self.name = name
        self.birthDate = birthDate
        self.financialPhilosophy = financialPhilosophy
        self.careerPace = careerPace
        self.familyDynamics = familyDynamics
        self.communicationStyle = communicationStyle
        self.childrenPlan = childrenPlan
    }
}

public struct CompatibilityResult {
    public let knotIndex: Double
    public let verdict: String
    public let celestialScore: Double
    public let valuesScore: Double
    
    public let user1Moon: CelestialPosition
    public let user2Moon: CelestialPosition
    
    public let elementalSummary: String
    public let temperamentSummary: String
    public let angularSummary: String
    
    public let financialSummary: String
    public let careerSummary: String
    public let familySummary: String
    public let communicationSummary: String
    
    public let conversationPrompts: [String]
}
