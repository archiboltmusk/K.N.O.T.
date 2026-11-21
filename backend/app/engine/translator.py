"""
K.N.O.T. Psychological Translation Engine
Translates classical Sanskrit Vedic astrology concepts (Ashtakoota & Doshas)
into actionable, relatable, modern psychological insights.
"""

from typing import Dict, Any, List

# Classical Ashtakoota mapped to modern psychological dynamics
KOOTA_TRANSLATIONS = {
    "Nadi": {
        "modern_name": "Biological & Lifestyle Rhythm",
        "description": "How your physical energy, stress recovery, and daily routines align.",
        "high_match": "Synced Body Clocks: You naturally adapt to each other's sleep, eating, and recovery habits.",
        "low_match": "Contrasting Energy Rhythms: One of you thrives on early mornings, the other on late nights. Clear routine boundaries keep you both energized."
    },
    "Bhakoot": {
        "modern_name": "Passion & Life Pacing",
        "description": "How you manage spontaneity versus long-term planning.",
        "high_match": "Harmonious Momentum: You move through major life transitions and financial decisions at the exact same speed.",
        "low_match": "High Spark, Different Pacing: One partner craves impromptu weekend getaways; the other needs a calendar 5 days in advance."
    },
    "Gana": {
        "modern_name": "Social Energy & Banter Score",
        "description": "Your sense of humor, conflict resilience, and how you process social stress.",
        "high_match": "Banter Score 96%: You share an intuitive wavelength and process daily stress through shared humor.",
        "low_match": "Complementary Social Balance: One partner brings grounded serenity to large gatherings while the other brings infectious warmth."
    },
    "Graha_Maitri": {
        "modern_name": "Intellectual & Emotional Friendship",
        "description": "Can you be best friends first before romantic partners?",
        "high_match": "Deep Intellectual Complicity: Conversations never run dry; mutual respect comes effortlessly.",
        "low_match": "Diverse Worldviews: You introduce each other to fresh perspectives and challenge each other's assumptions."
    },
    "Yoni": {
        "modern_name": "Physical Chemistry & Intimacy Rhythm",
        "description": "Subconscious attraction and tactile comfort.",
        "high_match": "Effortless Comfort: Natural, unforced physical ease around each other.",
        "low_match": "Gradual Spark: Chemistry deepens with emotional safety and shared experiences over time."
    },
    "Tara": {
        "modern_name": "Destiny & Mutual Luck",
        "description": "How your presence elevates each other's emotional well-being.",
        "high_match": "Mutual Catalyst: Being together inspires confidence and clarity in individual pursuits.",
        "low_match": "Independent Growth: You thrive by keeping personal achievements distinct from relationship milestones."
    }
}

def translate_koota_breakdown(scores: Dict[str, bool]) -> List[Dict[str, Any]]:
    """Translates Ashtakoota test booleans into modern psychological cards."""
    results = []
    for koota, is_high in scores.items():
        data = KOOTA_TRANSLATIONS.get(koota)
        if data:
            results.append({
                "classical_term": koota.replace("_", " "),
                "modern_title": data["modern_name"],
                "summary": data["high_match"] if is_high else data["low_match"],
                "is_aligned": is_high
            })
    return results

def generate_dynamic_icebreakers(rashi1: str, rashi2: str, elem1: str, elem2: str) -> List[str]:
    """Generates punchy, personalized first-message conversation starters."""
    prompts = []
    
    if elem1 == elem2:
        prompts.append(f"We're both {elem1} signs—be honest: what's one habit of our sign that secretly annoys you?")
    elif {elem1, elem2} == {"Fire", "Air"}:
        prompts.append("Fire and Air either build an empire or burn the kitchen down. What's the wildest idea you've had this week?")
    elif {elem1, elem2} == {"Earth", "Water"}:
        prompts.append("Earth and Water: what's your ultimate comfort food or rainy weekend ritual?")
    else:
        prompts.append(f"Classic {rashi1} meets {rashi2}: What's a hill you are absolutely willing to die on?")
        
    prompts.append("If we had a completely free Sunday with zero work notifications, where are we going?")
    return prompts

def generate_ask_mom_whatsapp_message(user_name: str) -> str:
    """Generates the polite, low-friction WhatsApp card for parents."""
    return (
        f"Hey Maa/Papa, I'm filling out a verified marriage profile and need my exact birth details. "
        f"Could you check my birth certificate or Kundli chart and share:\n"
        f"1. Exact time of birth (AM/PM)\n"
        f"2. Hospital / City of birth\n"
        f"Thank you!"
    )
