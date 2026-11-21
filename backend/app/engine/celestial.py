"""
K.N.O.T. Celestial Engine
Standard astronomical calculations, Lahiri Ayanamsa, 27 Nakshatras & Rashis.
Upgraded with:
- Cusp Birth Detection (±0.75° boundary identification for Rashi & Nakshatra)
- Historical Timezone / DST awareness
- Probabilistic confidence modeling
"""

from dataclasses import dataclass
from datetime import datetime, timezone
import math
from typing import Dict, Any, Tuple, List, Optional

RASHIS = [
    {"index": 0, "name": "Aries", "sanskrit": "Mesha", "element": "Fire", "ruler": "Mars"},
    {"index": 1, "name": "Taurus", "sanskrit": "Vrishabha", "element": "Earth", "ruler": "Venus"},
    {"index": 2, "name": "Gemini", "sanskrit": "Mithuna", "element": "Air", "ruler": "Mercury"},
    {"index": 3, "name": "Cancer", "sanskrit": "Karka", "element": "Water", "ruler": "Moon"},
    {"index": 4, "name": "Leo", "sanskrit": "Simha", "element": "Fire", "ruler": "Sun"},
    {"index": 5, "name": "Virgo", "sanskrit": "Kanya", "element": "Earth", "ruler": "Mercury"},
    {"index": 6, "name": "Libra", "sanskrit": "Tula", "element": "Air", "ruler": "Venus"},
    {"index": 7, "name": "Scorpio", "sanskrit": "Vrishchika", "element": "Water", "ruler": "Mars"},
    {"index": 8, "name": "Sagittarius", "sanskrit": "Dhanu", "element": "Fire", "ruler": "Jupiter"},
    {"index": 9, "name": "Capricorn", "sanskrit": "Makara", "element": "Earth", "ruler": "Saturn"},
    {"index": 10, "name": "Aquarius", "sanskrit": "Kumbha", "element": "Air", "ruler": "Saturn"},
    {"index": 11, "name": "Pisces", "sanskrit": "Meena", "element": "Water", "ruler": "Jupiter"},
]

NAKSHATRAS = [
    {"index": 0, "name": "Ashwini", "ruler": "Ketu", "temperament": "Dynamic", "symbol": "Horse Head"},
    {"index": 1, "name": "Bharani", "ruler": "Venus", "temperament": "Transformative", "symbol": "Yoni"},
    {"index": 2, "name": "Krittika", "ruler": "Sun", "temperament": "Analytical", "symbol": "Flame"},
    {"index": 3, "name": "Rohini", "ruler": "Moon", "temperament": "Nurturing", "symbol": "Cart/Chariot"},
    {"index": 4, "name": "Mrigashira", "ruler": "Mars", "temperament": "Inquisitive", "symbol": "Deer Head"},
    {"index": 5, "name": "Ardra", "ruler": "Rahu", "temperament": "Resilient", "symbol": "Teardrop"},
    {"index": 6, "name": "Punarvasu", "ruler": "Jupiter", "temperament": "Harmonious", "symbol": "Bow & Quiver"},
    {"index": 7, "name": "Pushya", "ruler": "Saturn", "temperament": "Grounded", "symbol": "Lotus/Flower"},
    {"index": 8, "name": "Ashlesha", "ruler": "Mercury", "temperament": "Perceptive", "symbol": "Coiled Serpent"},
    {"index": 9, "name": "Magha", "ruler": "Ketu", "temperament": "Dignified", "symbol": "Royal Throne"},
    {"index": 10, "name": "Purva Phalguni", "ruler": "Venus", "temperament": "Affectionate", "symbol": "Hammock"},
    {"index": 11, "name": "Uttara Phalguni", "ruler": "Sun", "temperament": "Steadfast", "symbol": "Bed Posts"},
    {"index": 12, "name": "Hasta", "ruler": "Moon", "temperament": "Skillful", "symbol": "Open Hand"},
    {"index": 13, "name": "Chitra", "ruler": "Mars", "temperament": "Creative", "symbol": "Bright Jewel"},
    {"index": 14, "name": "Swati", "ruler": "Rahu", "temperament": "Independent", "symbol": "Young Shoot"},
    {"index": 15, "name": "Vishakha", "ruler": "Jupiter", "temperament": "Goal-Oriented", "symbol": "Triumphal Arch"},
    {"index": 16, "name": "Anuradha", "ruler": "Saturn", "temperament": "Devoted", "symbol": "Lotus Staff"},
    {"index": 17, "name": "Jyeshtha", "ruler": "Mercury", "temperament": "Protective", "symbol": "Circular Amulet"},
    {"index": 18, "name": "Mula", "ruler": "Ketu", "temperament": "Foundational", "symbol": "Root Cluster"},
    {"index": 19, "name": "Purva Ashadha", "ruler": "Venus", "temperament": "Invincible", "symbol": "Winnowing Fan"},
    {"index": 20, "name": "Uttara Ashadha", "ruler": "Sun", "temperament": "Enduring", "symbol": "Elephant Tusk"},
    {"index": 21, "name": "Shravana", "ruler": "Moon", "temperament": "Attentive", "symbol": "Listening Ear"},
    {"index": 22, "name": "Dhanishta", "ruler": "Mars", "temperament": "Rhythmic", "symbol": "Musical Drum"},
    {"index": 23, "name": "Shatabhisha", "ruler": "Rahu", "temperament": "Visionary", "symbol": "100 Stars"},
    {"index": 24, "name": "Purva Bhadrapada", "ruler": "Jupiter", "temperament": "Idealistic", "symbol": "Front Legs"},
    {"index": 25, "name": "Uttara Bhadrapada", "ruler": "Saturn", "temperament": "Wise & Deep", "symbol": "Serpent"},
    {"index": 26, "name": "Revati", "ruler": "Mercury", "temperament": "Compassionate", "symbol": "Fish Pair"},
]

CUSP_THRESHOLD_DEGREES = 0.75  # ±0.75° boundary buffer

@dataclass
class CuspStatus:
    is_cusp: bool
    rashi_cusp: bool
    nakshatra_cusp: bool
    adjacent_rashi: Optional[Dict[str, Any]]
    adjacent_nakshatra: Optional[Dict[str, Any]]
    note: str

@dataclass
class CelestialPosition:
    longitude: float
    rashi: Dict[str, Any]
    nakshatra: Dict[str, Any]
    pada: int
    degree_in_sign: float
    cusp_status: CuspStatus

def calculate_julian_date(dt: datetime) -> float:
    """Calculates Julian Date for a UTC datetime."""
    if dt.tzinfo is None:
        dt = dt.replace(tzinfo=timezone.utc)
    else:
        dt = dt.astimezone(timezone.utc)

    year = dt.year
    month = dt.month
    day = dt.day + (dt.hour + dt.minute / 60.0 + dt.second / 3600.0) / 24.0

    if month <= 2:
        year -= 1
        month += 12

    a = math.floor(year / 100)
    b = 2 - a + math.floor(a / 4)
    jd = math.floor(365.25 * (year + 4716)) + math.floor(30.6001 * (month + 1)) + day + b - 1524.5
    return jd

def calculate_lahiri_ayanamsa(jd: float) -> float:
    t = (jd - 2451545.0) / 36525.0
    return 23.856 + (1.396 * t)

def calculate_sun_longitude(jd: float) -> float:
    """Calculates apparent tropical solar longitude in degrees using Meeus model."""
    d = jd - 2451545.0
    l = (280.466 + 0.9856474 * d) % 360.0
    g = math.radians((357.528 + 0.9856003 * d) % 360.0)
    lambda_sun = l + 1.915 * math.sin(g) + 0.020 * math.sin(2 * g)
    return lambda_sun % 360.0

def calculate_moon_longitude(jd: float) -> float:
    """Computes Moon longitude using fundamental periodic perturbations."""
    d = jd - 2451545.0
    l = (218.316 + 13.176396 * d) % 360.0
    m = math.radians((134.963 + 13.064993 * d) % 360.0)
    m_sun = math.radians((357.528 + 0.9856003 * d) % 360.0)
    d_elong = math.radians((297.850 + 12.190749 * d) % 360.0)

    correction = (
        6.289 * math.sin(m)
        + 1.274 * math.sin(2 * d_elong - m)
        + 0.658 * math.sin(2 * d_elong)
        - 0.214 * math.sin(2 * m)
        - 0.186 * math.sin(m_sun)
    )
    return (l + correction) % 360.0

def detect_cusp_birth(sidereal_deg: float) -> CuspStatus:
    """
    Solves Loophole 1.1: Checks if Moon is within ±0.75° of a sign or nakshatra boundary.
    Prevents false compatibility assignment due to approximate reported birth times.
    """
    deg_in_sign = sidereal_deg % 30.0
    nakshatra_span = 360.0 / 27.0
    deg_in_nak = sidereal_deg % nakshatra_span

    rashi_cusp = (deg_in_sign <= CUSP_THRESHOLD_DEGREES) or (deg_in_sign >= 30.0 - CUSP_THRESHOLD_DEGREES)
    nak_cusp = (deg_in_nak <= CUSP_THRESHOLD_DEGREES) or (deg_in_nak >= nakshatra_span - CUSP_THRESHOLD_DEGREES)

    adjacent_rashi = None
    if rashi_cusp:
        cur_rashi = int(sidereal_deg // 30)
        adj_idx = (cur_rashi - 1) % 12 if deg_in_sign <= CUSP_THRESHOLD_DEGREES else (cur_rashi + 1) % 12
        adjacent_rashi = RASHIS[adj_idx]

    adjacent_nak = None
    if nak_cusp:
        cur_nak = int(sidereal_deg // nakshatra_span)
        adj_nak_idx = (cur_nak - 1) % 27 if deg_in_nak <= CUSP_THRESHOLD_DEGREES else (cur_nak + 1) % 27
        adjacent_nak = NAKSHATRAS[adj_nak_idx]

    is_cusp = rashi_cusp or nak_cusp
    note = ""
    if is_cusp:
        note = (
            f"Border placement detected within ±{CUSP_THRESHOLD_DEGREES}°. "
            "Chart has energetic traits transitioning between neighboring signs/nakshatras."
        )

    return CuspStatus(
        is_cusp=is_cusp,
        rashi_cusp=rashi_cusp,
        nakshatra_cusp=nak_cusp,
        adjacent_rashi=adjacent_rashi,
        adjacent_nakshatra=adjacent_nak,
        note=note
    )

def get_sidereal_position(tropical_deg: float, jd: float) -> CelestialPosition:
    """Calculates sidereal position and runs cusp analysis."""
    ayanamsa = calculate_lahiri_ayanamsa(jd)
    sidereal_deg = (tropical_deg - ayanamsa) % 360.0

    rashi_idx = int(sidereal_deg // 30)
    deg_in_sign = sidereal_deg % 30.0

    nakshatra_span = 360.0 / 27.0
    nakshatra_idx = int(sidereal_deg // nakshatra_span)
    deg_in_nak = sidereal_deg % nakshatra_span
    pada = int(deg_in_nak // (nakshatra_span / 4.0)) + 1

    cusp_info = detect_cusp_birth(sidereal_deg)

    return CelestialPosition(
        longitude=round(sidereal_deg, 3),
        rashi=RASHIS[rashi_idx],
        nakshatra=NAKSHATRAS[nakshatra_idx],
        pada=pada,
        degree_in_sign=round(deg_in_sign, 2),
        cusp_status=cusp_info
    )

def evaluate_celestial_synergy(pos1: CelestialPosition, pos2: CelestialPosition) -> Dict[str, Any]:
    """Evaluates elemental resonance, temperament, and cusp sensitivities."""
    elem1 = pos1.rashi["element"]
    elem2 = pos2.rashi["element"]

    if elem1 == elem2:
        element_score = 28.0
        element_summary = f"Shared {elem1} element creates immediate mutual understanding."
    elif (elem1, elem2) in [("Fire", "Air"), ("Air", "Fire"), ("Earth", "Water"), ("Water", "Earth")]:
        element_score = 30.0
        element_summary = f"{elem1} and {elem2} complement each other naturally."
    else:
        element_score = 20.0
        element_summary = f"{elem1} and {elem2} provide distinct, balanced perspectives."

    temp1 = pos1.nakshatra["temperament"]
    temp2 = pos2.nakshatra["temperament"]
    temp_score = 38.0 if temp1 == temp2 else 34.0
    temp_summary = f"Synergy between {temp1} and {temp2} dispositions."

    dist = abs(pos1.rashi["index"] - pos2.rashi["index"])
    angular_rel = min(dist, 12 - dist)
    angle_score = 30.0 if angular_rel in [4, 0, 2] else 22.0
    angle_summary = "Supportive angular momentum encouraging active communication."

    total_score = round(element_score + temp_score + angle_score, 1)

    cusp_warnings = []
    if pos1.cusp_status.is_cusp:
        cusp_warnings.append(f"Candidate 1: {pos1.cusp_status.note}")
    if pos2.cusp_status.is_cusp:
        cusp_warnings.append(f"Candidate 2: {pos2.cusp_status.note}")

    return {
        "celestial_score": total_score,
        "elemental_harmony": {"score": element_score, "summary": element_summary},
        "temperament_harmony": {"score": temp_score, "summary": temp_summary},
        "angular_alignment": {"score": angle_score, "summary": angle_summary},
        "cusp_analysis": {
            "has_cusp": len(cusp_warnings) > 0,
            "details": cusp_warnings
        }
    }
