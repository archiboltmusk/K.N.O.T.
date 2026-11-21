import Foundation

public struct Engine {
    public static let rashis: [Rashi] = [
        Rashi(id: 0, name: "Aries", sanskrit: "Mesha", element: "Fire", ruler: "Mars"),
        Rashi(id: 1, name: "Taurus", sanskrit: "Vrishabha", element: "Earth", ruler: "Venus"),
        Rashi(id: 2, name: "Gemini", sanskrit: "Mithuna", element: "Air", ruler: "Mercury"),
        Rashi(id: 3, name: "Cancer", sanskrit: "Karka", element: "Water", ruler: "Moon"),
        Rashi(id: 4, name: "Leo", sanskrit: "Simha", element: "Fire", ruler: "Sun"),
        Rashi(id: 5, name: "Virgo", sanskrit: "Kanya", element: "Earth", ruler: "Mercury"),
        Rashi(id: 6, name: "Libra", sanskrit: "Tula", element: "Air", ruler: "Venus"),
        Rashi(id: 7, name: "Scorpio", sanskrit: "Vrishchika", element: "Water", ruler: "Mars"),
        Rashi(id: 8, name: "Sagittarius", sanskrit: "Dhanu", element: "Fire", ruler: "Jupiter"),
        Rashi(id: 9, name: "Capricorn", sanskrit: "Makara", element: "Earth", ruler: "Saturn"),
        Rashi(id: 10, name: "Aquarius", sanskrit: "Kumbha", element: "Air", ruler: "Saturn"),
        Rashi(id: 11, name: "Pisces", sanskrit: "Meena", element: "Water", ruler: "Jupiter")
    ]
    
    public static let nakshatras: [Nakshatra] = [
        Nakshatra(id: 0, name: "Ashwini", ruler: "Ketu", temperament: "Dynamic", symbol: "Horse Head"),
        Nakshatra(id: 1, name: "Bharani", ruler: "Venus", temperament: "Transformative", symbol: "Yoni"),
        Nakshatra(id: 2, name: "Krittika", ruler: "Sun", temperament: "Analytical", symbol: "Flame"),
        Nakshatra(id: 3, name: "Rohini", ruler: "Moon", temperament: "Nurturing", symbol: "Chariot"),
        Nakshatra(id: 4, name: "Mrigashira", ruler: "Mars", temperament: "Inquisitive", symbol: "Deer Head"),
        Nakshatra(id: 5, name: "Ardra", ruler: "Rahu", temperament: "Resilient", symbol: "Teardrop"),
        Nakshatra(id: 6, name: "Punarvasu", ruler: "Jupiter", temperament: "Harmonious", symbol: "Bow & Quiver"),
        Nakshatra(id: 7, name: "Pushya", ruler: "Saturn", temperament: "Grounded", symbol: "Lotus Flower"),
        Nakshatra(id: 8, name: "Ashlesha", ruler: "Mercury", temperament: "Perceptive", symbol: "Serpent"),
        Nakshatra(id: 9, name: "Magha", ruler: "Ketu", temperament: "Dignified", symbol: "Royal Throne"),
        Nakshatra(id: 10, name: "Purva Phalguni", ruler: "Venus", temperament: "Affectionate", symbol: "Hammock"),
        Nakshatra(id: 11, name: "Uttara Phalguni", ruler: "Sun", temperament: "Steadfast", symbol: "Bed Posts"),
        Nakshatra(id: 12, name: "Hasta", ruler: "Moon", temperament: "Skillful", symbol: "Open Hand"),
        Nakshatra(id: 13, name: "Chitra", ruler: "Mars", temperament: "Creative", symbol: "Bright Jewel"),
        Nakshatra(id: 14, name: "Swati", ruler: "Rahu", temperament: "Independent", symbol: "Young Shoot"),
        Nakshatra(id: 15, name: "Vishakha", ruler: "Jupiter", temperament: "Goal-Oriented", symbol: "Triumphal Arch"),
        Nakshatra(id: 16, name: "Anuradha", ruler: "Saturn", temperament: "Devoted", symbol: "Lotus Staff"),
        Nakshatra(id: 17, name: "Jyeshtha", ruler: "Mercury", temperament: "Protective", symbol: "Circular Amulet"),
        Nakshatra(id: 18, name: "Mula", ruler: "Ketu", temperament: "Foundational", symbol: "Root Cluster"),
        Nakshatra(id: 19, name: "Purva Ashadha", ruler: "Venus", temperament: "Invincible", symbol: "Fan"),
        Nakshatra(id: 20, name: "Uttara Ashadha", ruler: "Sun", temperament: "Enduring", symbol: "Elephant Tusk"),
        Nakshatra(id: 21, name: "Shravana", ruler: "Moon", temperament: "Attentive", symbol: "Listening Ear"),
        Nakshatra(id: 22, name: "Dhanishta", ruler: "Mars", temperament: "Rhythmic", symbol: "Drum"),
        Nakshatra(id: 23, name: "Shatabhisha", ruler: "Rahu", temperament: "Visionary", symbol: "100 Stars"),
        Nakshatra(id: 24, name: "Purva Bhadrapada", ruler: "Jupiter", temperament: "Idealistic", symbol: "Front Legs"),
        Nakshatra(id: 25, name: "Uttara Bhadrapada", ruler: "Saturn", temperament: "Wise & Deep", symbol: "Serpent"),
        Nakshatra(id: 26, name: "Revati", ruler: "Mercury", temperament: "Compassionate", symbol: "Pair of Fish")
    ]
    
    public static func julianDate(from date: Date) -> Double {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        
        var year = cal.component(.year, from: date)
        var month = cal.component(.month, from: date)
        let day = Double(cal.component(.day, from: date))
        let hour = Double(cal.component(.hour, from: date))
        let minute = Double(cal.component(.minute, from: date))
        let second = Double(cal.component(.second, from: date))
        
        let dayFraction = day + (hour + minute / 60.0 + second / 3600.0) / 24.0
        
        if month <= 2 {
            year -= 1
            month += 12
        }
        
        let a = floor(Double(year) / 100.0)
        let b = 2.0 - a + floor(a / 4.0)
        let jd = floor(365.25 * Double(year + 4716)) + floor(30.6001 * Double(month + 1)) + dayFraction + b - 1524.5
        return jd
    }
    
    public static func lahiriAyanamsa(jd: Double) -> Double {
        let t = (jd - 2451545.0) / 36525.0
        return 23.856 + (1.396 * t)
    }
    
    public static func calculateMoonLongitude(jd: Double) -> Double {
        let d = jd - 2451545.0
        let l = (218.316 + 13.176396 * d).truncatingRemainder(dividingBy: 360.0)
        let m = ((134.963 + 13.064993 * d).truncatingRemainder(dividingBy: 360.0)) * .pi / 180.0
        let mSun = ((357.528 + 0.9856003 * d).truncatingRemainder(dividingBy: 360.0)) * .pi / 180.0
        let dElong = ((297.850 + 12.190749 * d).truncatingRemainder(dividingBy: 360.0)) * .pi / 180.0
        
        let correction = (
            6.289 * sin(m)
            + 1.274 * sin(2.0 * dElong - m)
            + 0.658 * sin(2.0 * dElong)
            - 0.214 * sin(2.0 * m)
            - 0.186 * sin(mSun)
        )
        var lambda = (l + correction).truncatingRemainder(dividingBy: 360.0)
        if lambda < 0 { lambda += 360.0 }
        return lambda
    }
    
    public static func siderealPosition(tropicalDegrees: Double, jd: Double) -> CelestialPosition {
        let ayanamsa = lahiriAyanamsa(jd: jd)
        var sidereal = (tropicalDegrees - ayanamsa).truncatingRemainder(dividingBy: 360.0)
        if sidereal < 0 { sidereal += 360.0 }
        
        let rashiIdx = Int(sidereal / 30.0) % 12
        let degInSign = sidereal.truncatingRemainder(dividingBy: 30.0)
        
        let nakshatraSpan = 360.0 / 27.0
        let nakshatraIdx = Int(sidereal / nakshatraSpan) % 27
        let degInNak = sidereal.truncatingRemainder(dividingBy: nakshatraSpan)
        let pada = Int(degInNak / (nakshatraSpan / 4.0)) + 1
        
        return CelestialPosition(
            longitude: (sidereal * 10.0).rounded() / 10.0,
            rashi: rashis[rashiIdx],
            nakshatra: nakshatras[nakshatraIdx],
            pada: pada,
            degreeInSign: (degInSign * 10.0).rounded() / 10.0
        )
    }
    
    public static func evaluate(p1: PersonProfile, p2: PersonProfile) -> CompatibilityResult {
        let jd1 = julianDate(from: p1.birthDate)
        let moon1 = calculateMoonLongitude(jd: jd1)
        let pos1 = siderealPosition(tropicalDegrees: moon1, jd: jd1)
        
        let jd2 = julianDate(from: p2.birthDate)
        let moon2 = calculateMoonLongitude(jd: jd2)
        let pos2 = siderealPosition(tropicalDegrees: moon2, jd: jd2)
        
        // --- 1. Layer 1: Celestial / Cultural Harmony ---
        let elem1 = pos1.rashi.element
        let elem2 = pos2.rashi.element
        var elemScore = 24.0
        var elemSummary = "\(elem1) and \(elem2) bring balanced, grounded perspectives to daily living."
        
        if elem1 == elem2 {
            elemScore = 28.0
            elemSummary = "Shared \(elem1) element creates immediate mutual understanding and similar life pacing."
        } else if (elem1 == "Fire" && elem2 == "Air") || (elem1 == "Air" && elem2 == "Fire") ||
                  (elem1 == "Earth" && elem2 == "Water") || (elem1 == "Water" && elem2 == "Earth") {
            elemScore = 30.0
            elemSummary = "\(elem1) and \(elem2) complement each other naturally—one provides spark/structure, the other nurtures."
        } else if (elem1 == "Fire" && elem2 == "Water") || (elem1 == "Water" && elem2 == "Fire") {
            elemScore = 18.0
            elemSummary = "\(elem1) and \(elem2) have contrasting emotional styles, offering high growth through open communication."
        }
        
        var tempScore = 34.0
        var tempSummary = "Dynamic blend between \(pos1.nakshatra.temperament) and \(pos2.nakshatra.temperament) dispositions."
        if pos1.nakshatra.temperament == pos2.nakshatra.temperament {
            tempScore = 38.0
            tempSummary = "Matching temperaments (\(pos1.nakshatra.temperament)) ensure smooth collaboration and shared energy."
        }
        
        let dist = abs(pos1.rashi.id - pos2.rashi.id)
        let angularRel = min(dist, 12 - dist)
        var angleScore = 20.0
        var angleSummary = "Distinct perspectives that encourage conscious communication and intentional teamwork."
        
        if angularRel == 4 { // Trine
            angleScore = 30.0
            angleSummary = "Trine placement (120°) indicates natural ease, effortless trust, and shared life outlook."
        } else if angularRel == 2 || angularRel == 0 { // Sextile or Conjunction
            angleScore = 27.0
            angleSummary = "Supportive alignment promoting active friendship and great mutual respect."
        } else if angularRel == 6 { // Complementary polarity
            angleScore = 25.0
            angleSummary = "Complementary opposites—strengths in one partner balance blind spots in the other."
        }
        
        let celestialScore = elemScore + tempScore + angleScore
        
        // --- 2. Layer 2: Values & Reality ---
        var prompts: [String] = []
        var finScore = 22.0
        var finSummary = "Complementary financial mindsets—one focuses on growth/security, the other maintains healthy equilibrium."
        if p1.financialPhilosophy == p2.financialPhilosophy {
            finScore = 25.0
            finSummary = "Identical financial approach (\(p1.financialPhilosophy.capitalized)) minimizes friction in budgeting and joint assets."
        } else if (p1.financialPhilosophy == "saver" && p2.financialPhilosophy == "experiential") ||
                  (p1.financialPhilosophy == "experiential" && p2.financialPhilosophy == "saver") {
            finScore = 16.0
            finSummary = "Different spending/saving philosophies. Transparent budgeting discussions recommended early."
            prompts.append("Discuss your expectations for shared bank accounts vs personal spending autonomy.")
        }
        
        var careerScore = 22.0
        var careerSummary = "A high-drive partner paired with a balanced partner often creates a stable, supportive domestic foundation."
        if p1.careerPace == p2.careerPace {
            careerScore = 25.0
            careerSummary = "Aligned professional ambition creates balanced home and scheduling expectations."
        } else {
            prompts.append("How do you plan to handle household responsibilities during peak work seasons?")
        }
        
        var famScore = 21.0
        var famSummary = "Nearby living preferences allow strong family connections while preserving couple autonomy."
        if p1.familyDynamics == p2.familyDynamics {
            famScore = 25.0
            famSummary = "Mutual agreement on living arrangements prevents future extended-family tension."
        } else {
            prompts.append("What are your expectations for holiday traditions and frequency of visiting in-laws?")
        }
        
        var commScore = 23.0
        var commSummary = "A collaborative communicator acts as a healthy mediator when tensions arise."
        if p1.communicationStyle == p2.communicationStyle {
            commScore = 25.0
            commSummary = "Matching communication rhythm allows swift conflict resolution."
        } else {
            prompts.append("When an argument gets heated, do you prefer solving it immediately or taking space to cool down?")
        }
        
        let valuesScore = finScore + careerScore + famScore + commScore
        
        // --- 3. Composite K.N.O.T. Index ---
        let knotIndex = ((0.50 * valuesScore) + (0.50 * celestialScore) * 10.0).rounded() / 10.0
        
        let verdict: String
        if knotIndex >= 85.0 {
            verdict = "Exceptional Synergy: Rare harmony across both daily practical values and long-term temperament."
        } else if knotIndex >= 75.0 {
            verdict = "Strong Natural Alignment: Highly compatible foundations with complementary communication dynamics."
        } else if knotIndex >= 65.0 {
            verdict = "Constructive Growth Partnership: Balanced differences that foster mutual maturity through active conversation."
        } else {
            verdict = "Deliberate Exploration Needed: Diverse personal values require transparent early dialogue on core goals."
        }
        
        if prompts.isEmpty {
            prompts.append("What does a successful weekend together look like to recharge?")
            prompts.append("How do your personal definitions of long-term financial security align?")
        }
        
        return CompatibilityResult(
            knotIndex: knotIndex,
            verdict: verdict,
            celestialScore: celestialScore,
            valuesScore: valuesScore,
            user1Moon: pos1,
            user2Moon: pos2,
            elementalSummary: elemSummary,
            temperamentSummary: tempSummary,
            angularSummary: angleSummary,
            financialSummary: finSummary,
            careerSummary: careerSummary,
            familySummary: famSummary,
            communicationSummary: commSummary,
            conversationPrompts: prompts
        )
    }
}
