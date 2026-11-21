import SwiftUI

public struct DateConciergeView: View {
    @State private var selectedPairing = "Earth & Water"
    @State private var selectedCity = "Bengaluru"
    @State private var bookedVenue = false
    
    public init() {}
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                // Header
                VStack(alignment: .leading, spacing: 6) {
                    Label("AI FIRST-DATE ARCHITECT", systemImage: "sparkles")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(KnotTheme.gold)
                    Text("Elemental First-Date Concierge")
                        .font(.system(size: 26, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                    Text("Solves post-match hesitation by designing bespoke dates tailored to your charts' elemental acoustics.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Selectors
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("PAIRING ELEMENT")
                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                            .foregroundColor(KnotTheme.gold)
                        Picker("", selection: $selectedPairing) {
                            Text("Earth & Water (Intimate & Grounded)").tag("Earth & Water")
                            Text("Fire & Air (Sunset & High Energy)").tag("Fire & Air")
                            Text("Earth & Earth (Heritage & High Tea)").tag("Earth & Earth")
                            Text("Fire & Fire (Active & Craft Tasting)").tag("Fire & Fire")
                        }
                        .pickerStyle(.menu)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("METRO CITY")
                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                            .foregroundColor(KnotTheme.gold)
                        Picker("", selection: $selectedCity) {
                            Text("Bengaluru (Indiranagar / Lavelle Rd)").tag("Bengaluru")
                            Text("Mumbai (Bandra / BKC)").tag("Mumbai")
                            Text("Delhi NCR (CyberHub / Mehrauli)").tag("Delhi NCR")
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                Divider().background(KnotTheme.border)
                
                // Itinerary Blueprint Card
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Curated Concept: Botanical Afternoon & Acoustic Jazz")
                                .font(.system(size: 16, weight: .bold, design: .serif))
                                .foregroundColor(.white)
                            Text("Acoustic Profile: Low-Decibel (< 55 dB) • Zero Awkward Staring")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Label("Elemental Sync", systemImage: "waveform.path.ecg")
                            .font(.caption.bold())
                            .foregroundColor(KnotTheme.emerald)
                    }
                    
                    // Venue Options
                    VStack(spacing: 12) {
                        venueRow(
                            name: "The Green Room Conservatory",
                            type: "Artisan Pour-Overs & Botanical Garden",
                            activity: "Unrushed conversation surrounded by natural greenery.",
                            tag: "Step 1 • 45 Mins"
                        )
                        venueRow(
                            name: "National Gallery of Modern Art (NGMA)",
                            type: "Curated Sculpture Walk",
                            activity: "Low-pressure strolling with organic visual conversation starters.",
                            tag: "Step 2 • 40 Mins"
                        )
                        venueRow(
                            name: "Windmills Craftworks / The Piano Man",
                            type: "Acoustic Jazz & Quiet Dining",
                            activity: "Intimate table seating with refined acoustics.",
                            tag: "Step 3 • Optional Dinner"
                        )
                    }
                    
                    // Conversation Spark
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "quote.opening")
                            .foregroundColor(KnotTheme.orange)
                            .font(.caption)
                            .padding(.top, 2)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("TAILORED CONVERSATION SPARK")
                                .font(.system(size: 8, weight: .bold, design: .monospaced))
                                .foregroundColor(KnotTheme.orange)
                            Text("\"Ask what childhood vacation memory made the deepest impression on their character.\"")
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(14)
                    .background(KnotTheme.orange.opacity(0.08))
                    .cornerRadius(10)
                    
                    // 1-Click Reservation Button
                    Button(action: { bookedVenue = true }) {
                        HStack {
                            Image(systemName: "calendar.badge.plus")
                            Text(bookedVenue ? "Reservation Reserved via Zomato/Dineout" : "1-Click Reservation & Send Invitation")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(KnotTheme.goldGradient)
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
                .padding(24)
                .background(KnotTheme.bgCard)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(KnotTheme.border, lineWidth: 1))
            }
            .padding(32)
            .frame(maxWidth: 720)
        }
        .background(KnotTheme.bgDeep)
    }
    
    private func venueRow(name: String, type: String, activity: String, tag: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle().fill(KnotTheme.gold.opacity(0.12)).frame(width: 36, height: 36)
                Image(systemName: "mappin.and.ellipse").foregroundColor(KnotTheme.gold).font(.caption)
            }
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(name).font(.subheadline.bold()).foregroundColor(.white)
                    Spacer()
                    Text(tag).font(.system(size: 9, weight: .bold, design: .monospaced)).foregroundColor(KnotTheme.gold)
                }
                Text(type).font(.caption2).foregroundColor(.secondary)
                Text(activity).font(.caption).foregroundColor(.white.opacity(0.8)).padding(.top, 2)
            }
        }
        .padding(12)
        .background(KnotTheme.bgDeep)
        .cornerRadius(10)
    }
}
