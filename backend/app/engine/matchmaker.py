"""
K.N.O.T. Matchmaker Engine
Fuses Layer 1 (Celestial & Cultural Harmony) with Layer 2 (Real-world Values).
Produces the final Dual Compatibility Scorecard.
"""

from datetime import datetime
from typing import Dict, Any
from .celestial import (
    calculate_julian_date,
    calculate_moon_longitude,
    get_sidereal_position,
    evaluate_celestial_synergy,
    CelestialPosition
)
from .values import evaluate_values_synergy

def evaluate_dual_compatibility(
    user1_birth_utc: datetime,
    user1_values: Dict[str, Any],
    user2_birth_utc: datetime,
    user2_values: Dict[str, Any]
) -> Dict[str, Any]:
    """
    Evaluates end-to-end Dual-Layer compatibility between two candidates.
    Returns:
    - knot_index: Final composite score (0-100)
    - celestial_layer: Detailed astronomical & cultural breakdown
    - values_layer: Real-world lifestyle & communication breakdown
    - verdict: Constructive, empowering guidance
    """
    # 1. Compute Celestial Positions
    jd1 = calculate_julian_date(user1_birth_utc)
    moon1_deg = calculate_moon_longitude(jd1)
    pos1 = get_sidereal_position(moon1_deg, jd1)

    jd2 = calculate_julian_date(user2_birth_utc)
    moon2_deg = calculate_moon_longitude(jd2)
    pos2 = get_sidereal_position(moon2_deg, jd2)

    # 2. Evaluate Layer 1: Cultural & Celestial
    celestial_result = evaluate_celestial_synergy(pos1, pos2)

    # 3. Evaluate Layer 2: Real-World Values
    values_result = evaluate_values_synergy(user1_values, user2_values)

    # 4. Composite K.N.O.T. Index (50% Values + 50% Celestial)
    c_score = celestial_result["celestial_score"]
    v_score = values_result["values_score"]
    knot_index = round((0.50 * v_score) + (0.50 * c_score), 1)

    # 5. Meaningful Insight Generation
    if knot_index >= 85.0:
        verdict = "Exceptional Synergy: Rare harmony across both daily practical values and long-term temperament."
    elif knot_index >= 75.0:
        verdict = "Strong Natural Alignment: Highly compatible foundations with complementary communication dynamics."
    elif knot_index >= 65.0:
        verdict = "Constructive Growth Partnership: Balanced differences that foster mutual maturity through active conversation."
    else:
        verdict = "Deliberate Exploration Needed: Diverse personal values require transparent early dialogue on core goals."

    return {
        "knot_index": knot_index,
        "verdict": verdict,
        "summary": {
            "values_score": v_score,
            "celestial_score": c_score,
            "user1_profile": {
                "moon_sign": pos1.rashi["name"],
                "sanskrit_rashi": pos1.rashi["sanskrit"],
                "nakshatra": pos1.nakshatra["name"],
                "pada": pos1.pada,
                "element": pos1.rashi["element"]
            },
            "user2_profile": {
                "moon_sign": pos2.rashi["name"],
                "sanskrit_rashi": pos2.rashi["sanskrit"],
                "nakshatra": pos2.nakshatra["name"],
                "pada": pos2.pada,
                "element": pos2.rashi["element"]
            }
        },
        "celestial_layer": celestial_result,
        "values_layer": values_result
    }
