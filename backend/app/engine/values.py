"""
K.N.O.T. Situational Dilemma Values Engine
Solves Loophole 2.1: Social Desirability Bias & Gaming.
Replaces flat self-reported values with situational behavioral dilemma cross-validation.
"""

from typing import Dict, Any, List

# Situational Dilemma Matrix
# Maps concrete choices to underlying psychological phenotypes
DILEMMAS = {
    "financial_bonus": {
        "scenario": "You receive an unexpected ₹3,00,000 post-tax annual performance bonus. How do you allocate it?",
        "options": {
            "A": {"label": "Put 80% into equity index funds/prepay debt, 20% on a family dinner.", "phenotype": "investor"},
            "B": {"label": "Split 50% into savings, 30% for a vacation, 20% for personal enjoyment.", "phenotype": "balanced"},
            "C": {"label": "100% into liquid emergency fixed deposit.", "phenotype": "saver"},
            "D": {"label": "Book an international diving/skiing trip immediately.", "phenotype": "experiential"}
        }
    },
    "career_crunch": {
        "scenario": "Your team enters a 3-week critical release crunch requiring 12-hour days, right around an anniversary weekend.",
        "options": {
            "A": {"label": "Work through the crunch; celebrate the milestone lavishly once the release ships.", "phenotype": "high_drive"},
            "B": {"label": "Protect the anniversary evening strictly; delegate or push remaining tasks.", "phenotype": "balanced"},
            "C": {"label": "Propose shifting hours (work late Sunday, take Friday evening off).", "phenotype": "entrepreneurial"}
        }
    },
    "family_boundary": {
        "scenario": "Your parents or in-laws offer a generous down payment on an apartment in their immediate building.",
        "options": {
            "A": {"label": "Gratefully accept; multi-generational proximity makes daily life and future child-care easier.", "phenotype": "joint"},
            "B": {"label": "Politely decline the building; look for a home 15-20 minutes away for healthy boundaries.", "phenotype": "close_proximity"},
            "C": {"label": "Decline the financial aid; purchase independently wherever works best for the couple.", "phenotype": "nuclear"}
        }
    },
    "conflict_response": {
        "scenario": "A disagreement about holiday travel schedules becomes tense during dinner.",
        "options": {
            "A": {"label": "Pause immediately, take a 30-minute walk, and resume when emotions have cooled.", "phenotype": "reflective"},
            "B": {"label": "Stay at the table and resolve it then and there before sleeping.", "phenotype": "direct"},
            "C": {"label": "Write down both viewpoints on paper and look for a pragmatic compromise.", "phenotype": "collaborative"}
        }
    }
}

def evaluate_situational_dilemmas(answers1: Dict[str, str], answers2: Dict[str, str]) -> Dict[str, Any]:
    """
    Evaluates behavioral dilemmas rather than self-reported claims.
    Computes true behavioral overlap across finances, career, family, and conflict.
    """
    points = 0.0
    total_dilemmas = len(DILEMMAS)
    breakdown = {}

    for key, data in DILEMMAS.items():
        ans1 = answers1.get(key, "B")
        ans2 = answers2.get(key, "B")
        
        opt1 = data["options"].get(ans1, data["options"]["B"])
        opt2 = data["options"].get(ans2, data["options"]["B"])
        
        pheno1 = opt1["phenotype"]
        pheno2 = opt2["phenotype"]

        if pheno1 == pheno2:
            match_score = 25.0
            note = f"Direct alignment on {key.replace('_', ' ')}: Shared instinct."
        elif {pheno1, pheno2} in [{"investor", "balanced"}, {"close_proximity", "nuclear"}, {"collaborative", "reflective"}]:
            match_score = 21.0
            note = f"Complementary instincts on {key.replace('_', ' ')}."
        else:
            match_score = 14.0
            note = f"Contrasting instinctive response ({pheno1} vs {pheno2})."

        points += match_score
        breakdown[key] = {
            "candidate1_choice": opt1["label"],
            "candidate2_choice": opt2["label"],
            "score": match_score,
            "note": note
        }

    return {
        "dilemma_score": round(points, 1),
        "dilemma_breakdown": breakdown
    }

def evaluate_values_synergy(p1: Dict[str, Any], p2: Dict[str, Any]) -> Dict[str, Any]:
    """
    Combines self-reported priorities with situational dilemma validation.
    """
    d1 = p1.get("dilemmas", {})
    d2 = p2.get("dilemmas", {})

    dilemma_result = evaluate_situational_dilemmas(d1, d2)
    dilemma_score = dilemma_result["dilemma_score"]

    prompts = [
        "If you received an unexpected windfall, what percentage would go to security vs celebration?",
        "When emotions run high in a disagreement, what is your signal to take a breather?"
    ]

    return {
        "values_score": dilemma_score,
        "dilemma_audit": dilemma_result,
        "recommended_prompts": prompts
    }
