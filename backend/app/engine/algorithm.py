"""
K.N.O.T. Multi-Vector Match Algorithm (KMVA)
Solves the fundamental loopholes of modern dating and traditional matrimony:
1. Binary Dosha Fatalism -> Classical Shastric Cancellation & Mitigation Engine
2. Unknown Birth Time -> Probabilistic Confidence-Weighted Ephemeris
3. Lifestyle Dealbreakers -> Multi-Vector Cosine Similarity & Hard Constraints
4. Swipe Addiction / Ghosting -> Active Concurrency Limit (Max 3 Active Convos)
"""

from dataclasses import dataclass
from typing import Dict, Any, List, Optional, Tuple
import math
from datetime import datetime, timezone

from .celestial import (
    calculate_julian_date,
    calculate_moon_longitude,
    get_sidereal_position,
    RASHIS,
    NAKSHATRAS,
    CelestialPosition
)

# --- 1. Classical Dosha Cancellation Engine ---
# Classical texts (Brihat Parashara, Muhurta Chintamani) define cancellations:
# Nadi Dosha is CANCELLED if:
# - Same Rashi but different Nakshatras
# - Same Nakshatra but different Rashis
# - Same Nakshatra Lord or Moon Sign Lord
# Bhakoot Dosha (6/8 or 9/5 Rashi placement) is CANCELLED if:
# - Moon Sign lords are natural friends or identical.

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

def check_dosha_cancellations(pos1: CelestialPosition, pos2: CelestialPosition) -> Dict[str, Any]:
    """
    Evaluates Nadi & Bhakoot status and checks for classical shastric cancellations.
    Prevents binary 0/36 rejection fatalism.
    """
    rashi1_idx = pos1.rashi["index"]
    rashi2_idx = pos2.rashi["index"]
    lord1 = pos1.rashi["ruler"]
    lord2 = pos2.rashi["ruler"]
    nak1_idx = pos1.nakshatra["index"]
    nak2_idx = pos2.nakshatra["index"]

    # Bhakoot check (distance)
    dist = (rashi2_idx - rashi1_idx) % 12
    is_bhakoot_dosha = dist in [5, 7, 8, 4]  # 6/8 (shadashtaka) or 9/5 (navapanchama)
    bhakoot_cancelled = False
    bhakoot_reason = ""

    if is_bhakoot_dosha:
        # Check cancellation: Same lord or friendly lords
        if lord1 == lord2 or lord2 in FRIENDLY_LORDS.get(lord1, []) or lord1 in FRIENDLY_LORDS.get(lord2, []):
            bhakoot_cancelled = True
            bhakoot_reason = f"Bhakoot Dosha cancelled: Planetary rulers ({lord1} & {lord2}) share mutual friendship."
        else:
            bhakoot_reason = "Bhakoot tension mitigated through complementary modern life pacing."

    # Nadi check (approximate through Nakshatra triads: Adi, Madhya, Antya)
    nadi1 = nak1_idx % 3
    nadi2 = nak2_idx % 3
    is_nadi_dosha = (nadi1 == nadi2)
    nadi_cancelled = False
    nadi_reason = ""

    if is_nadi_dosha:
        # Classical exceptions:
        if rashi1_idx == rashi2_idx and nak1_idx != nak2_idx:
            nadi_cancelled = True
            nadi_reason = "Nadi Dosha cancelled: Shared Rashi with distinct Nakshatras."
        elif nak1_idx == nak2_idx and rashi1_idx != rashi2_idx:
            nadi_cancelled = True
            nadi_reason = "Nadi Dosha cancelled: Nakshatra spans across distinct zodiac signs."
        elif lord1 == lord2 or lord2 in FRIENDLY_LORDS.get(lord1, []):
            nadi_cancelled = True
            nadi_reason = f"Nadi Dosha cancelled: Compatible planetary rulers ({lord1} & {lord2})."
        else:
            nadi_reason = "Potential lifestyle rhythm difference. Addressed via transparent daily routine boundaries."

    return {
        "bhakoot": {
            "has_dosha": is_bhakoot_dosha,
            "is_cancelled": bhakoot_cancelled,
            "explanation": bhakoot_reason if is_bhakoot_dosha else "Natural life pacing alignment (No Bhakoot friction)."
        },
        "nadi": {
            "has_dosha": is_nadi_dosha,
            "is_cancelled": nadi_cancelled,
            "explanation": nadi_reason if is_nadi_dosha else "Harmonious biological & lifestyle rhythms (No Nadi friction)."
        }
    }


# --- 2. Multi-Vector Values Compatibility Engine ---

VALUE_VECTOR_WEIGHTS = {
    "financial": 0.30,
    "career": 0.25,
    "family": 0.25,
    "communication": 0.20
}

def evaluate_multi_vector_values(p1: Dict[str, Any], p2: Dict[str, Any]) -> Dict[str, Any]:
    """
    Computes weighted multi-vector lifestyle alignment.
    Checks for critical dealbreakers (e.g. mutually exclusive family goals).
    """
    dealbreaker_flag = False
    dealbreaker_reason = ""

    # Check non-negotiable dealbreakers
    kids1 = p1.get("children_plan", "open_future")
    kids2 = p2.get("children_plan", "open_future")
    if (kids1 == "definite_yes" and kids2 == "not_preferred") or (kids1 == "not_preferred" and kids2 == "definite_yes"):
        dealbreaker_flag = True
        dealbreaker_reason = "Critical Divergence: Irreconcilable differences on children/family planning."

    # Financial Score (0 - 100)
    f1, f2 = p1.get("financial_philosophy", "balanced"), p2.get("financial_philosophy", "balanced")
    if f1 == f2:
        f_score = 100.0
    elif {f1, f2} in [{"saver", "investor"}, {"balanced", "saver"}, {"balanced", "investor"}]:
        f_score = 88.0
    else:
        f_score = 65.0

    # Career Score (0 - 100)
    c1, c2 = p1.get("career_pace", "balanced"), p2.get("career_pace", "balanced")
    if c1 == c2:
        c_score = 100.0
    elif "balanced" in [c1, c2]:
        c_score = 88.0
    else:
        c_score = 72.0

    # Family Score (0 - 100)
    fam1, fam2 = p1.get("family_dynamics", "nuclear"), p2.get("family_dynamics", "nuclear")
    if fam1 == fam2:
        fam_score = 100.0
    elif {fam1, fam2} in [{"nuclear", "close_proximity"}, {"joint", "close_proximity"}]:
        fam_score = 85.0
    else:
        fam_score = 60.0

    # Communication Score (0 - 100)
    comm1, comm2 = p1.get("communication_style", "collaborative"), p2.get("communication_style", "collaborative")
    if comm1 == comm2:
        comm_score = 100.0
    elif "collaborative" in [comm1, comm2]:
        comm_score = 90.0
    else:
        comm_score = 70.0

    weighted_score = (
        (f_score * VALUE_VECTOR_WEIGHTS["financial"]) +
        (c_score * VALUE_VECTOR_WEIGHTS["career"]) +
        (fam_score * VALUE_VECTOR_WEIGHTS["family"]) +
        (comm_score * VALUE_VECTOR_WEIGHTS["communication"])
    )

    if dealbreaker_flag:
        weighted_score = min(weighted_score, 45.0)

    return {
        "values_score": round(weighted_score, 1),
        "dealbreaker_flag": dealbreaker_flag,
        "dealbreaker_reason": dealbreaker_reason,
        "vector_breakdown": {
            "financial": f_score,
            "career": c_score,
            "family": fam_score,
            "communication": comm_score
        }
    }


# --- 3. Anti-Ghosting Concurrency Manager ---
MAX_CONCURRENT_CHATS = 3

def check_chat_concurrency(active_chat_count: int) -> Tuple[bool, str]:
    """
    Prevents swipe-hoarding and ghosting.
    Users cannot open more than 3 active conversations at once.
    """
    if active_chat_count >= MAX_CONCURRENT_CHATS:
        return (
            False,
            f"Active Chat Limit Reached ({active_chat_count}/{MAX_CONCURRENT_CHATS}). "
            "To maintain high intent and respect everyone's time, please either continue or politely close an existing conversation."
        )
    return True, "Eligible to connect."


# --- 4. The Unified KMVA Engine ---
def run_kmva_match(
    user1_birth_date: datetime,
    user1_has_exact_time: bool,
    user1_values: Dict[str, Any],
    user2_birth_date: datetime,
    user2_has_exact_time: bool,
    user2_values: Dict[str, Any],
    user1_active_chats: int = 1
) -> Dict[str, Any]:
    """
    Full K.N.O.T. Multi-Vector Match Algorithm (KMVA).
    Outputs confidence-calibrated, shastric-cancelled, dealbreaker-checked report.
    """
    # Check anti-ghosting concurrency
    can_connect, concurrency_msg = check_chat_concurrency(user1_active_chats)

    # 1. Ephemeris Confidence Weighting
    # If exact birth time is missing, confidence is 0.82 (calculates Sun/Moon without exact ascendant/pada)
    confidence = 1.0 if (user1_has_exact_time and user2_has_exact_time) else 0.85

    jd1 = calculate_julian_date(user1_birth_date)
    moon1_deg = calculate_moon_longitude(jd1)
    pos1 = get_sidereal_position(moon1_deg, jd1)

    jd2 = calculate_julian_date(user2_birth_date)
    moon2_deg = calculate_moon_longitude(jd2)
    pos2 = get_sidereal_position(moon2_deg, jd2)

    # 2. Shastric Dosha Cancellations
    cancellations = check_dosha_cancellations(pos1, pos2)

    # 3. Base Celestial Calculation
    elem1 = pos1.rashi["element"]
    elem2 = pos2.rashi["element"]
    if elem1 == elem2:
        elem_pts = 30.0
    elif {elem1, elem2} in [{"Fire", "Air"}, {"Earth", "Water"}]:
        elem_pts = 28.0
    else:
        elem_pts = 20.0

    # Nakshatra points
    temp1 = pos1.nakshatra["temperament"]
    temp2 = pos2.nakshatra["temperament"]
    temp_pts = 38.0 if temp1 == temp2 else 32.0

    # Shastric cancellation bonus (reclaims points that traditional apps strip away)
    cancellation_bonus = 0.0
    if cancellations["bhakoot"]["is_cancelled"]:
        cancellation_bonus += 15.0
    if cancellations["nadi"]["is_cancelled"]:
        cancellation_bonus += 15.0

    raw_celestial = min(100.0, elem_pts + temp_pts + cancellation_bonus + 10.0)
    adjusted_celestial = round(raw_celestial * confidence, 1)

    # 4. Values Multi-Vector
    val_result = evaluate_multi_vector_values(user1_values, user2_values)
    values_score = val_result["values_score"]

    # 5. Composite K.N.O.T. Index (55% Values + 45% Celestial)
    knot_index = round((0.55 * values_score) + (0.45 * adjusted_celestial), 1)

    # Verdict
    if val_result["dealbreaker_flag"]:
        verdict = f"Dealbreaker Detected: {val_result['dealbreaker_reason']}"
    elif knot_index >= 88.0:
        verdict = "Exceptional Synergy: Dual-layer harmony across practical life goals and celestial timing."
    elif knot_index >= 75.0:
        verdict = "Strong Foundation: Complementary values with balanced communication flow."
    elif knot_index >= 60.0:
        verdict = "Moderate Synergy: Growth opportunities requiring intentional early dialogue."
    else:
        verdict = "Low Alignment: Divergent priorities on core marriage foundations."

    return {
        "knot_index": knot_index,
        "verdict": verdict,
        "confidence_level": "High (Verified Chart)" if confidence == 1.0 else "Baseline (Birth Date Ephemeris)",
        "can_initiate_chat": can_connect,
        "concurrency_status": concurrency_msg,
        "celestial_layer": {
            "score": adjusted_celestial,
            "raw_score": raw_celestial,
            "confidence_multiplier": confidence,
            "cancellations": cancellations,
            "user1": {"sign": pos1.rashi["name"], "nakshatra": pos1.nakshatra["name"]},
            "user2": {"sign": pos2.rashi["name"], "nakshatra": pos2.nakshatra["name"]}
        },
        "values_layer": val_result
    }
