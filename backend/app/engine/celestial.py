"""
K.N.O.T. Celestial Engine
Standard astronomical calculations and cultural harmonic modeling.
Focuses on transparent, constructive alignment without fear-mongering.
"""

from dataclasses import dataclass
from datetime import datetime, timezone
import math
from typing import Dict, Any, Tuple, List

# 12 Zodiac Rashis
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

# 27 Lunar Mansions (Nakshatras) - 13° 20' each
NAKSHATRAS = [
    {"index": 0, "name": "Ashwini", "ruler": "Ketu", "temperament": "Dynamic", "symbol": "Horse Head"},
    {"index": 1, "name": "Bharani", "ruler": "Venus", "temperament": "Transformative", "symbol": "Yoni"},
    {"index": 2, "name": "Krittika", "ruler": "Sun", "temperament": "Analytical", "symbol": "Razor/Flame"},
    {"index": 3, "name": "Rohini", "ruler": "Moon", "temperament": "Nurturing", "symbol": "Cart/Chariot"},
    {"index": 4, "name": "Mrigashira", "ruler": "Mars", "temperament": "Inquisitive", "symbol": "Deer Head"},
    {"index": 5, "name": "Ardra", "ruler": "Rahu", "temperament": "Resilient", "symbol": "Teardrop"},
    {"index": 6, "name": "Punarvasu", "ruler": "Jupiter", "temperament": "Harmonious", "symbol": "Bow & Quiver"},
    {"index": 7, "name": "Pushya", "ruler": "Saturn", "temperament": "Grounded", "symbol": "Lotus/Flower"},
    {"index": 8, "name": "Ashlesha", "ruler": "Mercury", "temperament": "Perceptive", "symbol": "Coiled Serpent"},
    {"index": 9, "name": "Magha", "ruler": "Ketu", "temperament": "Dignified", "symbol": "Royal Throne"},
    {"index": 10, "name": "Purva Phalguni", "ruler": "Venus", "temperament": "Affectionate", "symbol": "Hammock/Couch"},
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
    {"index": 23, "name": "Shatabhisha", "ruler": "Rahu", "temperament": "Visionary", "symbol": "100 Physicians/Stars"},
    {"index": 24, "name": "Purva Bhadrapada", "ruler": "Jupiter", "temperament": "Idealistic", "symbol": "Front Legs of Bed"},
    {"index": 25, "name": "Uttara Bhadrapada", "ruler": "Saturn", "temperament": "Wise & Deep", "symbol": "Serpent of Deep"},
    {"index": 26, "name": "Revati", "ruler": "Mercury", "temperament": "Compassionate", "symbol": "Fish swimming"},
]

@dataclass
class CelestialPosition:
    longitude: float
    rashi: Dict[str, Any]
    nakshatra: Dict[str, Any]
    pada: int
    degree_in_sign: float

def calculate_julian_date(dt: datetime) -> float:
    """Calculates Julian Date for a given UTC datetime."""
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
    """
    Standard Lahiri Ayanamsa approximation.
    Ayanamsa accounts for the precession of equinoxes (approx 50.29 arcseconds/year).
    Base epoch: J2000.0 (JD 2451545.0) has Lahiri ~ 23.856 degrees.
    """
    t = (jd - 2451545.0) / 36525.0
    ayanamsa = 23.856 + (1.396 * t)
    return ayanamsa

def calculate_sun_longitude(jd: float) -> float:
    """Calculates apparent tropical solar longitude in degrees using Meeus model."""
    d = jd - 2451545.0
    # Mean solar longitude
    l = (280.466 + 0.9856474 * d) % 360.0
    # Mean anomaly
    g = math.radians((357.528 + 0.9856003 * d) % 360.0)
    # Ecliptic longitude
    lambda_sun = l + 1.915 * math.sin(g) + 0.020 * math.sin(2 * g)
    return lambda_sun % 360.0

def calculate_moon_longitude(jd: float) -> float:
    """Calculates approximate tropical lunar longitude in degrees."""
    d = jd - 2451545.0
    # Mean longitude of Moon
    l = (218.316 + 13.176396 * d) % 360.0
    # Mean anomaly of Moon
    m = math.radians((134.963 + 13.064993 * d) % 360.0)
    # Mean anomaly of Sun
    m_sun = math.radians((357.528 + 0.9856003 * d) % 360.0)
    # Moon elongation
    d_elong = math.radians((297.850 + 12.190749 * d) % 360.0)

    # Core periodic perturbations
    correction = (
        6.289 * math.sin(m)
        + 1.274 * math.sin(2 * d_elong - m)
        + 0.658 * math.sin(2 * d_elong)
        - 0.214 * math.sin(2 * m)
        - 0.186 * math.sin(m_sun)
    )
    lambda_moon = (l + correction) % 360.0
    return lambda_moon

def get_sidereal_position(tropical_deg: float, jd: float) -> CelestialPosition:
    """Converts tropical ecliptic degrees to Vedic Sidereal using Lahiri Ayanamsa."""
    ayanamsa = calculate_lahiri_ayanamsa(jd)
    sidereal_deg = (tropical_deg - ayanamsa) % 360.0

    # Rashi (Sign) - 30 degrees each
    rashi_idx = int(sidereal_deg // 30)
    deg_in_sign = sidereal_deg % 30.0

    # Nakshatra - 13.333333 degrees (13° 20') each
    nakshatra_span = 360.0 / 27.0
    nakshatra_idx = int(sidereal_deg // nakshatra_span)
    deg_in_nakshatra = sidereal_deg % nakshatra_span
    pada = int(deg_in_nakshatra // (nakshatra_span / 4.0)) + 1

    return CelestialPosition(
        longitude=round(sidereal_deg, 3),
        rashi=RASHIS[rashi_idx],
        nakshatra=NAKSHATRAS[nakshatra_idx],
        pada=pada,
        degree_in_sign=round(deg_in_sign, 2)
    )

def evaluate_celestial_synergy(pos1: CelestialPosition, pos2: CelestialPosition) -> Dict[str, Any]:
    """
    Evaluates cultural & celestial harmony between two individuals.
    Grounds calculations in psychological resonance and communication styles.
    Returns score normalized to 0-100 with actionable strengths.
    """
    elem1 = pos1.rashi["element"]
    elem2 = pos2.rashi["element"]

    # Elemental resonance matrix (0-30 points)
    # Same element = 28, Compatible (Fire+Air or Earth+Water) = 30, Neutral = 22, Friction = 16
    compatible_pairs = [("Fire", "Air"), ("Air", "Fire"), ("Earth", "Water"), ("Water", "Earth")]
    friction_pairs = [("Fire", "Water"), ("Water", "Fire")]

    if elem1 == elem2:
        element_score = 28.0
        element_summary = f"Shared {elem1} element creates immediate mutual understanding and similar life pacing."
    elif (elem1, elem2) in compatible_pairs:
        element_score = 30.0
        element_summary = f"{elem1} and {elem2} complement each other naturally—one provides spark/structure, the other nurtures."
    elif (elem1, elem2) in friction_pairs:
        element_score = 18.0
        element_summary = f"{elem1} and {elem2} have contrasting emotional styles, offering high growth through open communication."
    else:
        element_score = 24.0
        element_summary = f"{elem1} and {elem2} bring balanced, grounded perspectives to daily living."

    # Nakshatra Temperament resonance (0-40 points)
    temp1 = pos1.nakshatra["temperament"]
    temp2 = pos2.nakshatra["temperament"]

    if temp1 == temp2:
        temp_score = 38.0
        temp_summary = f"Matching temperaments ({temp1}) ensure smooth collaboration and shared energy levels."
    else:
        temp_score = 34.0
        temp_summary = f"Dynamic blend between {temp1} and {temp2} dispositions creates healthy balance."

    # Rashi distance / Angular relationship (0-30 points)
    dist = abs(pos1.rashi["index"] - pos2.rashi["index"])
    angular_rel = min(dist, 12 - dist)
    
    # 0 = Conjunction, 4 = Trine (120°), 3 = Square (90°), 6 = Opposition (180°)
    if angular_rel == 4:  # Trine (highest harmony)
        angle_score = 30.0
        angle_summary = "Trine placement indicates natural ease, effortless trust, and shared life outlook."
    elif angular_rel in [2, 0]:  # Sextile or same sign
        angle_score = 27.0
        angle_summary = "Supportive alignment promoting active friendship and great mutual respect."
    elif angular_rel == 6:  # Complementary polarity
        angle_score = 25.0
        angle_summary = "Complementary opposites—strengths in one partner balance blind spots in the other."
    else:
        angle_score = 20.0
        angle_summary = "Distinct perspectives that encourage conscious communication and intentional teamwork."

    total_score = round(element_score + temp_score + angle_score, 1)

    return {
        "celestial_score": total_score,
        "elemental_harmony": {
            "score": element_score,
            "max": 30.0,
            "summary": element_summary
        },
        "temperament_harmony": {
            "score": temp_score,
            "max": 40.0,
            "summary": temp_summary
        },
        "angular_alignment": {
            "score": angle_score,
            "max": 30.0,
            "summary": angle_summary
        },
        "strengths": [
            f"Moon in {pos1.rashi['name']} + Moon in {pos2.rashi['name']}: {element_summary}",
            f"{pos1.nakshatra['name']} ({pos1.nakshatra['symbol']}) meets {pos2.nakshatra['name']} ({pos2.nakshatra['symbol']}): {temp_summary}"
        ]
    }
