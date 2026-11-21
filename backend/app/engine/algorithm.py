"""
K.N.O.T. Multi-Vector Match Algorithm (KMVA) - Production v2.0
Fully upgraded to eliminate all major loopholes:
1. Cusp Birth Detection (±0.75° boundary identification)
2. Situational Behavioral Dilemmas (Anti-Profile Gaming)
3. Shastric Dosha Cancellations (Brihat Parashara exceptions)
4. Anti-Ghosting Concurrency & 48-Hour Grace Timer
5. Cryptographic Family Vault Verification
"""

from dataclasses import dataclass
from typing import Dict, Any, List, Optional, Tuple
from datetime import datetime, timezone, timedelta

from .celestial import (
    calculate_julian_date,
    calculate_moon_longitude,
    get_sidereal_position,
    CelestialPosition
)
from .values import evaluate_values_synergy
from .vault import generate_vault_dossier

# Friendly lords matrix for shastric cancellations
FRIENDLY_LORDS = {
    "Sun": ["Moon", "Mars", "Jupiter"],
    "Moon": ["Sun", "Mercury"],
    "Mars": ["Sun", "Moon", "Jupiter"],
    "Mercury": ["Sun", "Venus"],
    "Jupiter": ["Sun", "Moon", "Mars"],
    "Venus": ["Mercury", "Saturn"],
    "Saturn": ["Mercury", "Venus"],
    "Rahu": ["Venus", "Saturn"],
    "Ketu": ["Mars", "Jupiter"]
}

MAX_CONCURRENT_CHATS = 3
FIRST_MESSAGE_GRACE_HOURS = 48

def check_chat_concurrency_and_ghosting(
    active_chats: List[Dict[str, Any]]
) -> Tuple[bool, str, List[str]]:
    """
    Solves Loophole 2.2 (Ghosting & Slot Hoarding):
    - Caps active chats at 3.
    - If a matched conversation has 0 messages after 48 hours, auto-releases the slot.
    - Provides instant slot release for responsive users whose matches have ghosted.
    """
    now = datetime.now(timezone.utc)
    releasable_slots = []
    strictly_active_count = 0

    for chat in active_chats:
        matched_at = chat.get("matched_at", now)
        msg_count = chat.get("message_count", 0)
        hours_passed = (now - matched_at).total_seconds() / 3600.0

        if msg_count == 0 and hours_passed >= FIRST_MESSAGE_GRACE_HOURS:
            releasable_slots.append(chat.get("chat_id", "unknown"))
        else:
            strictly_active_count += 1

    if strictly_active_count >= MAX_CONCURRENT_CHATS:
        return (
            False,
            f"Active Chat Limit Reached ({strictly_active_count}/{MAX_CONCURRENT_CHATS}). "
            "To respect everyone's time, please either continue or politely close an existing conversation.",
            releasable_slots
        )

    return True, "Eligible to connect.", releasable_slots

def check_dosha_cancellations(pos1: CelestialPosition, pos2: CelestialPosition) -> Dict[str, Any]:
    """Calculates classical Brihat Parashara cancellations for Bhakoot and Nadi."""
    rashi1_idx = pos1.rashi["index"]
    rashi2_idx = pos2.rashi["index"]
    lord1 = pos1.rashi["ruler"]
    lord2 = pos2.rashi["ruler"]
    nak1_idx = pos1.nakshatra["index"]
    nak2_idx = pos2.nakshatra["index"]

    dist = (rashi2_idx - rashi1_idx) % 12
    is_bhakoot_dosha = dist in [5, 7, 8, 4]
    bhakoot_cancelled = False
    bhakoot_reason = ""

    if is_bhakoot_dosha:
        if lord1 == lord2 or lord2 in FRIENDLY_LORDS.get(lord1, []) or lord1 in FRIENDLY_LORDS.get(lord2, []):
            bhakoot_cancelled = True
            bhakoot_reason = f"Bhakoot Dosha cancelled: Planetary rulers ({lord1} & {lord2}) share friendship."
        else:
            bhakoot_reason = "Bhakoot tension balanced through complementary life pacing."

    nadi1 = nak1_idx % 3
    nadi2 = nak2_idx % 3
    is_nadi_dosha = (nadi1 == nadi2)
    nadi_cancelled = False
    nadi_reason = ""

    if is_nadi_dosha:
        if rashi1_idx == rashi2_idx and nak1_idx != nak2_idx:
            nadi_cancelled = True
            nadi_reason = "Nadi Dosha cancelled: Shared Rashi with distinct Nakshatras."
        elif nak1_idx == nak2_idx and rashi1_idx != rashi2_idx:
            nadi_cancelled = True
            nadi_reason = "Nadi Dosha cancelled: Nakshatra transitions across distinct signs."
        elif lord1 == lord2 or lord2 in FRIENDLY_LORDS.get(lord1, []):
            nadi_cancelled = True
            nadi_reason = f"Nadi Dosha cancelled: Compatible planetary rulers ({lord1} & {lord2})."
        else:
            nadi_reason = "Potential circadian rhythm difference; addressed via transparent routine boundaries."

    return {
        "bhakoot": {
            "has_dosha": is_bhakoot_dosha,
            "is_cancelled": bhakoot_cancelled,
            "explanation": bhakoot_reason if is_bhakoot_dosha else "Harmonious life pacing (No Bhakoot friction)."
        },
        "nadi": {
            "has_dosha": is_nadi_dosha,
            "is_cancelled": nadi_cancelled,
            "explanation": nadi_reason if is_nadi_dosha else "Harmonious biological & lifestyle rhythms (No Nadi friction)."
        }
    }

def run_kmva_match(
    user1_name: str,
    user1_birth_date: datetime,
    user1_has_exact_time: bool,
    user1_profile: Dict[str, Any],
    user2_name: str,
    user2_birth_date: datetime,
    user2_has_exact_time: bool,
    user2_profile: Dict[str, Any],
    user1_active_chats: Optional[List[Dict[str, Any]]] = None
) -> Dict[str, Any]:
    """
    Unified KMVA Match Engine v2.0
    Executes Cusp check, Shastric Dosha cancellations, Situational Dilemmas, and Vault Signing.
    """
    if user1_active_chats is None:
        user1_active_chats = []

    # 1. Anti-Ghosting & Concurrency
    can_connect, concurrency_msg, releasable = check_chat_concurrency_and_ghosting(user1_active_chats)

    # 2. Celestial Positions & Cusp Analysis (Solves Loophole 1.1)
    jd1 = calculate_julian_date(user1_birth_date)
    moon1_deg = calculate_moon_longitude(jd1)
    pos1 = get_sidereal_position(moon1_deg, jd1)

    jd2 = calculate_julian_date(user2_birth_date)
    moon2_deg = calculate_moon_longitude(jd2)
    pos2 = get_sidereal_position(moon2_deg, jd2)

    confidence = 1.0 if (user1_has_exact_time and user2_has_exact_time) else 0.85

    # 3. Shastric Dosha Cancellations
    cancellations = check_dosha_cancellations(pos1, pos2)

    elem1, elem2 = pos1.rashi["element"], pos2.rashi["element"]
    elem_pts = 30.0 if elem1 == elem2 else (28.0 if {elem1, elem2} in [{"Fire", "Air"}, {"Earth", "Water"}] else 20.0)
    temp_pts = 38.0 if pos1.nakshatra["temperament"] == pos2.nakshatra["temperament"] else 32.0

    bonus = 0.0
    if cancellations["bhakoot"]["is_cancelled"]:
        bonus += 15.0
    if cancellations["nadi"]["is_cancelled"]:
        bonus += 15.0

    raw_celestial = min(100.0, elem_pts + temp_pts + bonus + 10.0)
    adjusted_celestial = round(raw_celestial * confidence, 1)

    # 4. Values & Situational Dilemma Scoring (Solves Loophole 2.1)
    val_result = evaluate_values_synergy(user1_profile, user2_profile)
    values_score = val_result["values_score"]

    # 5. Composite K.N.O.T. Index
    knot_index = round((0.55 * values_score) + (0.45 * adjusted_celestial), 1)

    # Cusp warnings
    cusp_notes = []
    if pos1.cusp_status.is_cusp:
        cusp_notes.append(f"{user1_name}: {pos1.cusp_status.note}")
    if pos2.cusp_status.is_cusp:
        cusp_notes.append(f"{user2_name}: {pos2.cusp_status.note}")

    # 6. Generate Cryptographic Family Vault Dossier (Solves Loophole 5.1)
    dossier = generate_vault_dossier(
        candidate1_name=user1_name,
        candidate1_birth_utc=user1_birth_date.isoformat(),
        candidate1_rashi=pos1.rashi["name"],
        candidate1_nakshatra=pos1.nakshatra["name"],
        candidate2_name=user2_name,
        candidate2_birth_utc=user2_birth_date.isoformat(),
        candidate2_rashi=pos2.rashi["name"],
        candidate2_nakshatra=pos2.nakshatra["name"],
        guna_score=int(knot_index * 36.0 / 100.0),
        dosha_cancellations="Active Shastric Exceptions Applied" if (bonus > 0) else "Harmonious"
    )

    verdict = "Exceptional Synergy: Verified alignment across behavioral dilemmas and celestial timing."
    if knot_index < 75.0:
        verdict = "Balanced Dynamic: Divergent situational responses offer growth through open conversation."

    return {
        "knot_index": knot_index,
        "verdict": verdict,
        "confidence_level": "High (Verified Chart)" if confidence == 1.0 else "Baseline (Birth Date Ephemeris)",
        "can_initiate_chat": can_connect,
        "concurrency_status": concurrency_msg,
        "auto_releasable_slots": releasable,
        "celestial_layer": {
            "score": adjusted_celestial,
            "raw_score": raw_celestial,
            "confidence_multiplier": confidence,
            "cancellations": cancellations,
            "cusp_analysis": {
                "has_cusp": len(cusp_notes) > 0,
                "notes": cusp_notes
            },
            "user1": {"sign": pos1.rashi["name"], "nakshatra": pos1.nakshatra["name"]},
            "user2": {"sign": pos2.rashi["name"], "nakshatra": pos2.nakshatra["name"]}
        },
        "values_layer": val_result,
        "family_vault_dossier": dossier
    }
