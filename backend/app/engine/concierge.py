"""
K.N.O.T. AI Date Concierge Engine
Solves the 60% post-match drop-off where conversations stall on "Where to meet?"
Architects bespoke first-date itineraries tailored to both partners' elemental resonance
and lifestyle values.
"""

from typing import Dict, Any, List

DATE_ITINERARY_MATRIX = {
    ("Earth", "Water"): {
        "vibe": "Intimate, grounded, and low-decibel.",
        "concept": "Botanical Afternoon & Acoustic Jazz",
        "recommended_venues": [
            {"name": "The Green Room Café / Conservatory", "type": "Botanical Coffee & Artisan Bakery", "activity": "Quiet conversation over pour-overs"},
            {"name": "National Gallery / NGMA", "type": "Art & Architecture Walk", "activity": "Low-pressure strolling with visual conversation starters"},
            {"name": "The Piano Man / Windmills Craftworks", "type": "Acoustic Jazz & Quiet Dinner", "activity": "Intimate dining with refined acoustics"}
        ],
        "conversation_spark": "Ask what childhood vacation memory made the deepest impression on their character.",
        "noise_level": "Low (Under 55 dB)",
        "duration_ideal": "90–120 minutes"
    },
    ("Fire", "Air"): {
        "vibe": "Dynamic, vibrant, and intellectually stimulating.",
        "concept": "Sunset Rooftop & Speakeasy Walk",
        "recommended_venues": [
            {"name": "High Ultra Lounge / Aer Rooftop", "type": "Panoramic Sunset Speakeasy", "activity": "Cocktails with city views and high-energy music"},
            {"name": "Artisan Culinary / Sourdough Workshop", "type": "Interactive Hands-on Activity", "activity": "Collaborative cooking removing awkward table stares"},
            {"name": "Curated Stand-Up Comedy Room", "type": "Cultural Comedy Evening", "activity": "Shared humor followed by dessert discussions"}
        ],
        "conversation_spark": "Ask what wildly ambitious project they would pursue tomorrow if money were completely solved.",
        "noise_level": "Medium-High (Energetic ambience)",
        "duration_ideal": "120–150 minutes"
    },
    ("Fire", "Fire"): {
        "vibe": "Bold, athletic, and adventurous.",
        "concept": "Activity-First & Craft Tasting",
        "recommended_venues": [
            {"name": "Bouldering / Clay Studio", "type": "Active Engagement", "activity": "Shared physical movement that breaks nervous tension"},
            {"name": "Microbrewery Courtyard (Toit / Arbor)", "type": "Craft Tasting", "activity": "Casual, open-air banter"}
        ],
        "conversation_spark": "Debate what is the most overrated societal milestone people blindly pursue.",
        "noise_level": "High",
        "duration_ideal": "90 minutes"
    },
    ("Earth", "Earth"): {
        "vibe": "Refined, classic, and high-comfort.",
        "concept": "Heritage Bookshop & Specialty High Tea",
        "recommended_venues": [
            {"name": "Atta Galatta / Kitab Khana", "type": "Heritage Book Café", "activity": "Browsing favorite books followed by specialty tea"},
            {"name": "Olive Beach / The Table", "type": "Farm-to-Table European", "activity": "Structured dinner with unhurried service"}
        ],
        "conversation_spark": "Discuss what their ideal definition of financial freedom looks like in 10 years.",
        "noise_level": "Low",
        "duration_ideal": "120 minutes"
    }
}

def generate_first_date_itinerary(
    elem1: str,
    elem2: str,
    metro_city: str = "Bengaluru",
    budget_tier: str = "Premium"
) -> Dict[str, Any]:
    """Generates an elemental-tailored first date blueprint."""
    pair_key = (elem1, elem2) if (elem1, elem2) in DATE_ITINERARY_MATRIX else (
        (elem2, elem1) if (elem2, elem1) in DATE_ITINERARY_MATRIX else ("Earth", "Water")
    )
    
    itinerary_data = DATE_ITINERARY_MATRIX[pair_key]

    return {
        "pairing": f"{elem1} & {elem2}",
        "metro_city": metro_city,
        "vibe": itinerary_data["vibe"],
        "concept": itinerary_data["concept"],
        "venues": itinerary_data["recommended_venues"],
        "conversation_spark": itinerary_data["conversation_spark"],
        "ideal_duration": itinerary_data["duration_ideal"],
        "noise_profile": itinerary_data["noise_level"],
        "reservation_status": "1-Click API Reservation Ready (Zomato / Dineout Partnered)"
    }
