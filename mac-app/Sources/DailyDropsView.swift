import SwiftUI

public struct DailyDropsView: View {
    @State private var blurPhotosForPrivacy = false
    @State private var showingDossierModal = false
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header & Privacy Toggle
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Today's 3 Cosmic Drops (8:00 PM Window)")
                            .font(.title2.bold())
                        Text("Curated via Vedic synastry (Ashtakoota + D9) and values alignment. No infinite swiping.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 6) {
                        Toggle(isOn: $blurPhotosForPrivacy) {
                            HStack(spacing: 4) {
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(.purple)
                                Text("Blur Photos Until Match")
                                    .font(.caption.bold())
                            }
                        }
                        .toggleStyle(.switch)
                        .controlSize(.mini)
                        
                        Text("Women-First Privacy Shield")
                            .font(.system(size: 9))
                            .foregroundColor(.secondary)
                    }
                }
                
                Divider()
                
                // Drop 1
                candidateCard(
                    name: "Ananya Iyer",
                    age: 28,
                    role: "Senior Consultant @ McKinsey",
                    city: "Bangalore",
                    knotIndex: 91,
                    banterScore: "Banter Score: 94%",
                    banterDesc: "Both of you process high-stress workloads through dry wit.",
                    pacingBadge: "Passion & Pacing: 88%",
                    pacingDesc: "You crave spontaneous trips; they need 48h notice. Perfect balance.",
                    icebreaker: "Your Mars harmonizes with her Venus: Ask her what's the one trivial opinion she will defend to the death.",
                    moonSign: "Taurus (Rohini)",
                    blurred: blurPhotosForPrivacy,
                    accentColor: .indigo
                )
                
                // Drop 2
                candidateCard(
                    name: "Dr. Siddharth Mehta",
                    age: 30,
                    role: "Surgeon @ Manipal Hospital",
                    city: "Mumbai / Bangalore",
                    knotIndex: 86,
                    banterScore: "Intellectual Complicity: 90%",
                    banterDesc: "Effortless conversation flow across books, ethics, and career growth.",
                    pacingBadge: "Shared Body Clock: 85%",
                    pacingDesc: "Both early risers with disciplined morning focus.",
                    icebreaker: "Classic Scorpio meets Virgo: Ask him about his favorite rainy-day comfort food.",
                    moonSign: "Virgo (Hasta)",
                    blurred: blurPhotosForPrivacy,
                    accentColor: .purple
                )
                
                // Drop 3
                candidateCard(
                    name: "Meera Sen",
                    age: 29,
                    role: "Founding Designer @ Series-A FinTech",
                    city: "Delhi NCR / Remote",
                    knotIndex: 81,
                    banterScore: "Creative Synergy: 86%",
                    banterDesc: "Both driven by aesthetic clarity and entrepreneurial autonomy.",
                    pacingBadge: "Fluid Momentum: 80%",
                    pacingDesc: "Flexible rhythms that thrive outside strict corporate 9-to-5s.",
                    icebreaker: "Fire meets Air: Ask her what wildly ambitious side project she's daydreaming about.",
                    moonSign: "Pisces (Revati)",
                    blurred: blurPhotosForPrivacy,
                    accentColor: .blue
                )
            }
            .padding(28)
            .frame(maxWidth: 840)
        }
        .background(Color(NSColor.windowBackgroundColor))
        .sheet(isPresented: $showingDossierModal) {
            familyVaultModal
        }
    }
    
    private func candidateCard(
        name: String,
        age: Int,
        role: String,
        city: String,
        knotIndex: Int,
        banterScore: String,
        banterDesc: String,
        pacingBadge: String,
        pacingDesc: String,
        icebreaker: String,
        moonSign: String,
        blurred: Bool,
        accentColor: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 14) {
                // Avatar with blur privacy option
                ZStack {
                    Circle()
                        .fill(accentColor.opacity(0.15))
                        .frame(width: 58, height: 58)
                    Text(String(name.prefix(1)))
                        .font(.title.bold())
                        .foregroundColor(accentColor)
                        .blur(radius: blurred ? 8 : 0)
                    
                    if blurred {
                        Image(systemName: "lock.fill")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 8) {
                        Text("\(name), \(age)")
                            .font(.headline)
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .font(.caption)
                            .help("Verified Work & Identity Profile")
                        
                        Text("Verified Kundli")
                            .font(.system(size: 9, weight: .bold))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.purple.opacity(0.12))
                            .foregroundColor(.purple)
                            .cornerRadius(4)
                    }
                    Text(role)
                        .font(.subheadline)
                    Text("\(city) • Moon in \(moonSign)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Composite Score
                VStack(spacing: 2) {
                    Text("\(knotIndex)")
                        .font(.title2.bold())
                        .foregroundColor(accentColor)
                    Text("K.N.O.T.")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color(NSColor.textBackgroundColor))
                .cornerRadius(10)
            }
            
            // Modern Psychological Translation Badges
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Label(banterScore, systemImage: "face.smiling.fill")
                        .font(.caption.bold())
                        .foregroundColor(.indigo)
                    Text(banterDesc)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.indigo.opacity(0.06))
                .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 2) {
                    Label(pacingBadge, systemImage: "flame.fill")
                        .font(.caption.bold())
                        .foregroundColor(.purple)
                    Text(pacingDesc)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.purple.opacity(0.06))
                .cornerRadius(8)
            }
            
            // Dynamic Icebreaker Prompt
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "sparkles")
                    .foregroundColor(.orange)
                    .font(.caption)
                    .padding(.top, 2)
                VStack(alignment: .leading, spacing: 2) {
                    Text("COSMIC ICEBREAKER")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.orange)
                    Text(icebreaker)
                        .font(.caption)
                        .foregroundColor(.primary)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.orange.opacity(0.08))
            .cornerRadius(8)
            
            // Actions
            HStack(spacing: 12) {
                Button(action: {}) {
                    Label("Send Intent", systemImage: "paperplane.fill")
                }
                .buttonStyle(.borderedProminent)
                .tint(accentColor)
                
                Button(action: { showingDossierModal = true }) {
                    Label("Family Vault Dossier", systemImage: "doc.badge.arrow.up")
                }
                .buttonStyle(.bordered)
                .help("Download 1-page parent-friendly Kundli & Bio-data")
                
                Spacer()
                
                Button(action: {}) {
                    Label("Deep-Dive ₹49", systemImage: "bolt.shield.fill")
                }
                .buttonStyle(.plain)
                .font(.caption.bold())
                .foregroundColor(.indigo)
            }
            .padding(.top, 4)
        }
        .padding(20)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(12)
    }
    
    // MARK: - Family Vault Dossier Modal
    private var familyVaultModal: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Family-Ready Vault Dossier")
                        .font(.headline)
                    Text("A clean, dignified 1-page Kundli & Bio-data document designed to share with parents.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button("Done") { showingDossierModal = false }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Text("CONFIDENTIAL MARRIAGE DOSSIER")
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("VERIFIED HOROSCOPE")
                        .font(.caption.bold())
                        .foregroundColor(.green)
                }
                
                Text("Ananya Iyer & Rahul Sharma")
                    .font(.title3.bold())
                
                Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 10) {
                    GridRow {
                        Text("Guna Milan Score:").font(.caption.bold())
                        Text("31 / 36 (Auspicious Alignment)").foregroundColor(.green).font(.caption)
                    }
                    GridRow {
                        Text("Manglik Status:").font(.caption.bold())
                        Text("Compatible (No Dosha friction)").font(.caption)
                    }
                    GridRow {
                        Text("Education & Role:").font(.caption.bold())
                        Text("MBA / Senior Consultant @ McKinsey").font(.caption)
                    }
                    GridRow {
                        Text("Cultural Alignment:").font(.caption.bold())
                        Text("Vedic Sidereal Lahiri Ephemeris Verified").font(.caption)
                    }
                }
                .padding(14)
                .background(Color(NSColor.textBackgroundColor))
                .cornerRadius(8)
                
                Text("💡 Note: This document mentions zero dating apps or swipe terminology. It is formatted specifically as an authentic matrimonial horoscope and bio-data sheet for family review.")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(10)
            
            HStack {
                Button("Print / Save as PDF") {
                    showingDossierModal = false
                }
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
            }
        }
        .padding(24)
        .frame(width: 540, height: 420)
    }
}
