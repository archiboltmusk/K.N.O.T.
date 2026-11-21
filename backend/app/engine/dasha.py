"""
K.N.O.T. Vimshottari Dasha Life-Timing Engine (Inspired by The Pattern)
Calculates current planetary life-phases (Mahadasha & Antardasha) based on the Moon's
exact degree in its birth Nakshatra within the standard 120-year Vedic cycle.
"""

from typing import Dict, Any, List, Tuple
from datetime import datetime, timezone, timedelta

# Standard 120-year Vimshottari Dasha planetary sequence and year allocations
DASHA_PERIODS = [
    ("Ketu", 7),
    ("Venus", 20),
    ("Sun", 6),
    ("Moon", 10),
    ("Mars", 7),
    ("Rahu", 18),
    ("Jupiter", 16),
    ("Saturn", 19),
    ("Mercury", 17)
]

# Nakshatra ruling planet mapping (cycle of 9 repeats 3 times for 27 nakshatras)
NAKSHATRA_LORDS = [
    "Ketu", "Venus", "Sun", "Moon", "Mars", "Rahu", "Jupiter", "Saturn", "Mercury",
    "Ketu", "Venus", "Sun", "Moon", "Mars", "Rahu", "Jupiter", "Saturn", "Mercury",
    "Ketu", "Venus", "Sun", "Moon", "Mars", "Rahu", "Jupiter", "Saturn", "Mercury"
]

DASHA_PSYCHOLOGICAL_THEMES = {
    "Jupiter": {
        "theme": "Expansion, Mentorship & High Wisdom",
        "relationship_focus": "Seeking intellectual growth, mutual values, and stable long-term architecture."
    },
    "Venus": {
        "theme": "Love, Aesthetic Harmony & Partnership Nesting",
        "relationship_focus": "High romantic readiness; prioritizing emotional intimacy, shared home, and beauty."
    },
    "Mercury": {
        "theme": "Intellectual Commerce, Networking & Strategy",
        "relationship_focus": "Craves conversational agility, shared professional ambitions, and sharp wit."
    },
    "Moon": {
        "theme": "Emotional Foundation, Nurturing & Intuition",
        "relationship_focus": "Deep nesting instinct; seeking emotional safety, comfort, and family closeness."
    },
    "Sun": {
        "theme": "Leadership, Purpose & Authority",
        "relationship_focus": "Clarifying personal legacy and independence; requires mutual respect without ego clashes."
    },
    "Mars": {
        "theme": "Drive, Initiative & Physical Ambition",
        "relationship_focus": "High passion and momentum; needs shared physical/athletic energy and fast pacing."
    },
    "Saturn": {
        "theme": "Structural Maturation, Responsibility & Duty",
        "relationship_focus": "Pragmatic, serious commitment; focused on building enduring generational foundations."
    },
    "Rahu": {
        "theme": "Disruptive Growth, Global Ambition & Unconventional Paths",
        "relationship_focus": "Attracted to bold, unconventional partnerships and global relocation."
    },
    "Ketu": {
        "theme": "Introspection, Mastery & Spiritual Grounding",
        "relationship_focus": "Values simplicity, deep authenticity, and quiet companionship over flashiness."
    }
}

def calculate_current_dasha(birth_dt: datetime, moon_longitude: float, current_dt: datetime = None) -> Dict[str, Any]:
    """
    Calculates the candidate's active planetary life-phase (Mahadasha).
    """
    if current_dt is None:
        current_dt = datetime.now(timezone.utc)
    if birth_dt.tzinfo is None:
        birth_dt = birth_dt.replace(tzinfo=timezone.utc)

    nakshatra_span = 360.0 / 27.0
    nak_idx = int(moon_longitude // nakshatra_span) % 27
    deg_in_nak = moon_longitude % nakshatra_span

    # Fraction of nakshatra elapsed
    fraction_elapsed = deg_in_nak / nakshatra_span
    starting_lord = NAKSHATRA_LORDS[nak_idx]

    # Find starting lord index in 120-year cycle
    start_lord_idx = [p[0] for p in DASHA_PERIODS].index(starting_lord)
    start_total_years = DASHA_PERIODS[start_lord_idx][1]

    # Remaining years at birth
    remaining_years_at_birth = start_total_years * (1.0 - fraction_elapsed)

    # Age in years
    age_in_years = (current_dt - birth_dt).total_seconds() / (365.25 * 86400.0)

    # Accumulate through cycle
    cur_idx = start_lord_idx
    years_in_cur_period = remaining_years_at_birth

    if age_in_years < years_in_cur_period:
        active_lord = DASHA_PERIODS[cur_idx][0]
    else:
        elapsed = years_in_cur_period
        cur_idx = (cur_idx + 1) % 9
        while elapsed + DASHA_PERIODS[cur_idx][1] < age_in_years:
            elapsed += DASHA_PERIODS[cur_idx][1]
            cur_idx = (cur_idx + 1) % 9
        active_lord = DASHA_PERIODS[cur_idx][0]

    theme_data = DASHA_PSYCHOLOGICAL_THEMES.get(active_lord, {
        "theme": "Balanced Growth",
        "relationship_focus": "Steady development across personal and shared goals."
    })

    return {
        "active_dasha_lord": active_lord,
        "life_phase_theme": theme_data["theme"],
        "relationship_readiness": theme_data["relationship_focus"]
    }

def evaluate_dasha_timing_synergy(dasha1: Dict[str, Any], dasha2: Dict[str, Any]) -> Dict[str, Any]:
    """
    Evaluates whether both partners' timing curves are in harmonious alignment.
    """
    l1 = dasha1["active_dasha_lord"]
    l2 = dasha2["active_dasha_lord"]

    # Highly compatible life-timing combinations
    synergy_pairs = [
        {"Jupiter", "Venus"}, {"Venus", "Moon"}, {"Mercury", "Jupiter"},
        {"Sun", "Mars"}, {"Saturn", "Jupiter"}, {"Venus", "Venus"}
    ]

    is_high_synergy = (l1 == l2) or ({l1, l2} in synergy_pairs)

    if is_high_synergy:
        summary = (
            f"Timing in Sync ({l1} & {l2}): Both partners are in complementary life phases "
            "where personal aspirations and relationship commitment naturally support each other."
        )
        score = 94.0
    else:
        summary = (
            f"Distinct Life Horizons ({l1} & {l2}): One partner is focused on {dasha1['life_phase_theme'].split(',')[0]} "
            f"while the other emphasizes {dasha2['life_phase_theme'].split(',')[0]}. Awareness of each other's schedules is key."
        )
        score = 82.0

    return {
        "timing_score": score,
        "is_in_sync": is_high_synergy,
        "summary": summary
    }
