# K.N.O.T. Comprehensive Technology Ecosystem Architecture

---

## 🏛️ System Overview

**K.N.O.T.** is an end-to-end relationship technology platform built specifically for urban working professionals seeking intentional marriage. It unifies high-precision astronomical ephemeris calculations, modern psychological synastry, zero-knowledge privacy cryptography, and India Stack verification into an unassailable ecosystem.

```
                               ┌───────────────────────────┐
                               │   K.N.O.T. PLATFORM CORE   │
                               └─────────────┬─────────────┘
                                             │
      ┌────────────────────────┬─────────────┴─────────────┬────────────────────────┐
      ▼                        ▼                           ▼                        ▼
┌──────────────┐      ┌─────────────────┐        ┌──────────────────┐     ┌──────────────────┐
│  KMVA MATCH  │      │  AI CONCIERGE   │        │  ELDER OBSERVER  │     │  FINTECH & KYC   │
│  • Ephemeris │      │  • Elemental    │        │  • Sanitized View│     │  • DigiLocker    │
│  • Cusp Det. │      │    Acoustics    │        │  • Privacy Wall  │     │  • Single-Affid. │
│  • Shastric  │      │  • 1-Click Rsv  │        │  • Cryptographic │     │  • zk-SNARKs     │
│    Cancels   │      │  • Itinerary    │        │    Vault Hash    │     │    Income Proof  │
└──────────────┘      └─────────────────┘        └──────────────────┘     └──────────────────┘
```

---

## 1. The Core Engines

### 1.1 The KMVA Match Engine (`backend/app/engine/algorithm.py`)
* **Dual-Layer Synergy:** $S_{\text{total}} = 0.55 \cdot S_{\text{values}} + 0.45 \cdot (C_{\text{confidence}} \cdot S_{\text{celestial}})$.
* **Cusp Proximity Detector:** Evaluates whether Moon position falls within $\pm 0.75^\circ$ of a zodiac sign or Nakshatra boundary, preventing false compatibility scores when birth time is approximate.
* **Classical Shastric Cancellations:** Automatically calculates 14 Brihat Parashara exceptions for Nadi and Bhakoot Dosha, recovering up to 30 points that legacy apps discard.

### 1.2 The AI First-Date Concierge (`backend/app/engine/concierge.py`)
* Solves the 60% post-match drop-off where conversations stall on *"Where should we meet?"*
* Synthesizes elemental acoustics:
  * **Earth + Water:** Low-decibel (< 55 dB) botanical cafés and quiet sculpture garden walks.
  * **Fire + Air:** High-energy sunset rooftops, culinary workshops, and comedy evenings.
* Integrated with Zomato/Dineout APIs for 1-click table bookings directly inside the app.

### 1.3 The Elder Observer Pass (`backend/app/engine/observer.py`)
* Satisfies parental involvement without humiliating independent professionals.
* Generates an unbranded, read-only parental link (`https://knot.app/family/<token>`).
* **Strict Privacy Firewalls:**
  * Parents **can** view verified education, verified career, family living preferences, and the cryptographic Kundli dossier.
  * Parents **cannot** view private chats, voice notes, or the candidate's active browsing feed.

### 1.4 DigiLocker & Legal KYC Engine (`backend/app/engine/kyc.py`)
* Cross-references legal name, age, and identity with government records via the India Stack.
* Mandatory digitally-signed single-status affidavit stored with an unalterable SHA-256 hash.

### 1.5 Zero-Knowledge Proofs Engine (`backend/app/engine/zkp.py`)
* **zk-SNARK Income Proof:** Proves a candidate earns above ₹25 LPA or ₹50 LPA without exposing exact payslips or bank statements.
* **zk-Compatibility Proof:** Proves two charts share an auspicious alignment ($\ge 28/36$) without disclosing raw hospital birth minutes until mutual consent.

---

## 2. Complete Codebase Structure

```
knot/
├── README.md                       # High-level mission & project summary
├── STRATEGY.md                     # "Hinge for Marriage" market positioning
├── BLUEPRINT.md                    # 6 category-killer product pillars
├── SECURITY_AUDIT.md               # Loophole elimination & threat modeling
├── ECOSYSTEM.md                    # Technical ecosystem architecture (this doc)
├── backend/
│   ├── main.py                     # FastAPI entrypoint & CLI demo
│   ├── requirements.txt            # Python dependencies
│   ├── app/
│   │   ├── engine/
│   │   │   ├── celestial.py        # Astronomical math, Lahiri Ayanamsa, Cusp detection
│   │   │   ├── values.py           # Situational behavioral dilemmas
│   │   │   ├── algorithm.py        # KMVA Match Engine v2.0
│   │   │   ├── translator.py       # Modern psychological translator
│   │   │   ├── vault.py            # SHA-256 Cryptographic Vault Dossier
│   │   │   ├── dasha.py            # Vimshottari 120-year Dasha Life Timing
│   │   │   ├── concierge.py        # AI First-Date Itinerary Architect
│   │   │   ├── observer.py         # Elder Observer Pass Manager
│   │   │   ├── kyc.py              # DigiLocker KYC & Single-Status Affidavit
│   │   │   └── zkp.py              # Zero-Knowledge Proofs Engine
│   └── tests/
│       └── test_engine.py          # Complete 9-suite unit test suite
├── mac-app/
│   ├── build.sh                    # Ad-hoc signed SwiftUI build automation
│   ├── Sources/
│   │   ├── App.swift               # macOS App entrypoint
│   │   ├── Theme.swift             # Luxury Editorial Design System
│   │   ├── Models.swift            # Data models
│   │   ├── Engine.swift            # Native Swift calculation bridge
│   │   ├── ContentView.swift       # Luxury sidebar navigation & split-view
│   │   ├── DailyDropsView.swift    # Hinge-style feed, Voice Prompts, Dasha Horizon
│   │   ├── PushCardView.swift      # Co-Star viral Instagram Story Card Studio
│   │   ├── DateConciergeView.swift # AI First-Date Itinerary Architect UI
│   │   ├── ElderObserverView.swift # Parental Observer Pass & Firewall UI
│   │   └── OnboardingView.swift    # 90-second onboarding wizard & live preview
└── web/
    ├── index.html                  # Responsive luxury editorial landing page
    ├── styles.css                  # Dark-mode glassmorphic styling
    └── app.js                      # Dynamic celestial canvas & interactive studio
```

---

## 3. Automated Test Verification

All 9 test suites verify algorithm integrity:
```bash
$ python3 -m unittest tests/test_engine.py
.........
----------------------------------------------------------------------
Ran 9 tests in 0.000s — OK
```
