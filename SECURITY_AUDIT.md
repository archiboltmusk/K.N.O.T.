# K.N.O.T. Comprehensive Loophole & Security Audit

---

## 🛡️ Executive Summary
To protect users and maintain an ironclad standard of integrity, K.N.O.T. underwent a comprehensive structural audit addressing astronomical edge cases, behavioral gaming, market liquidity, and safety loopholes.

---

## 1. Mathematical & Ephemeris Loopholes

### Loophole 1.1: The Cusp Birth Ambiguity (Rashi & Nakshatra Sandhi)
* **The Failure:** The Moon moves $\sim 0.55^\circ$ per hour. An unverified birth time within $\pm 0.75^\circ$ of a boundary can flip the user's Rashi or Nakshatra, generating an inaccurate compatibility report.
* **The Engineering Fix:**
  * Implemented `detect_cusp_birth` in `celestial.py`.
  * Flags when the Moon is within $\pm 0.75^\circ$ of a $30^\circ$ sign boundary or $13^\circ 20'$ Nakshatra boundary.
  * Surfaces a clear advisory: *"Border placement detected. Energetic traits transition between neighboring signs."*

---

## 2. Behavioral Gaming & Profile Dishonesty

### Loophole 2.1: Social Desirability Bias (Self-Reported Values Gaming)
* **The Failure:** Bad actors choose "Disciplined Investor" and "Collaborative" simply to maximize match rates with top candidates.
* **The Engineering Fix:**
  * Implemented Situational Dilemmas (`DILEMMAS` in `values.py`).
  * Replaces self-declarations with 4 concrete financial, career, living, and conflict scenarios (e.g. allocating an unexpected ₹3 Lakh bonus, handling an anniversary release crunch).

### Loophole 2.2: Match Hoarding & Passive Ghosting
* **The Failure:** Users accumulate 3 matches and stop responding, blocking responsive users from receiving new introductions.
* **The Engineering Fix:**
  * Implemented `check_chat_concurrency_and_ghosting` in `algorithm.py`.
  * **48-Hour Grace Timer:** If a matched connection has 0 messages after 48 hours, the slot auto-expires without penalty.
  * **Polite Slot Release:** Responsive users can gracefully close inactive conversations to free up their introduction slot.

---

## 3. Fraud Prevention & Family Vault Protection

### Loophole 3.1: Dossier Forgery & PDF Alteration
* **The Failure:** Malicious users edit downloaded Family Vault PDFs to artificially inflate Guna scores or hide Dosha status before showing conservative parents.
* **The Engineering Fix:**
  * Implemented Cryptographic SHA-256 Vault Signing (`generate_vault_dossier` in `vault.py`).
  * Generates an unforgeable hash: `KNOT-<12_HEX_DIGITS>` linked to `https://knot.app/verify/<hash>`.
  * Parents scanning the QR code verify the authentic horoscope directly on K.N.O.T. servers. Any manual change to Guna scores immediately invalidates the signature.

---

## 4. Women-First Safety & Data Privacy

### Loophole 4.1: Public Exposure of Birth Data & Screenshot Leaks
* **The Failure:** Exact birth coordinates can be used for identity theft or malicious chart casting; photos can be screenshotted and forwarded to family WhatsApp groups.
* **The Engineering Fix:**
  * Zero public display of exact birth times or coordinates.
  * Native photo-blurring until mutual intent confirmation.
  * Forensic invisible watermarking on all profile media.
