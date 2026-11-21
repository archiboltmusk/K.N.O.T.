"""
K.N.O.T. Values Engine
Evaluates real-world psychological and lifestyle compatibility.
Focuses on financial alignment, career pacing, family expectations, and communication.
"""

from typing import Dict, Any, List

def evaluate_values_synergy(p1: Dict[str, Any], p2: Dict[str, Any]) -> Dict[str, Any]:
    """
    Evaluates real-world compatibility across core marriage pillars.
    p1 and p2 must contain values:
    - financial_philosophy: 'saver', 'investor', 'balanced', 'experiential'
    - career_pace: 'high_drive', 'balanced', 'entrepreneurial'
    - family_dynamics: 'nuclear', 'joint', 'close_proximity', 'independent'
    - communication_style: 'direct', 'reflective', 'collaborative'
    - children_plan: 'definite_yes', 'open_future', 'not_preferred'
    """
    prompts: List[str] = []
    
    # 1. Financial Alignment (0-25 pts)
    fin1 = p1.get("financial_philosophy", "balanced")
    fin2 = p2.get("financial_philosophy", "balanced")
    
    if fin1 == fin2:
        fin_score = 25.0
        fin_note = f"Identical financial approach ({fin1.capitalize()}) minimizes friction in budgeting and joint assets."
    elif {fin1, fin2} in [{"saver", "investor"}, {"balanced", "saver"}, {"balanced", "investor"}]:
        fin_score = 22.0
        fin_note = "Complementary financial mindsets—one focuses on growth/security, the other maintains healthy equilibrium."
    else:
        fin_score = 16.0
        fin_note = f"Different spending/saving philosophies ({fin1} vs {fin2}). High priority for pre-marital transparency."
        prompts.append("Discuss your expectations for shared bank accounts vs personal spending autonomy.")

    # 2. Career Pacing & Work-Life Balance (0-25 pts)
    career1 = p1.get("career_pace", "balanced")
    career2 = p2.get("career_pace", "balanced")

    if career1 == career2:
        career_score = 25.0
        career_note = f"Aligned professional ambition ({career1.replace('_', ' ').title()}) creates balanced home expectations."
    elif "balanced" in [career1, career2]:
        career_score = 22.0
        career_note = "A high-drive partner paired with a balanced partner often creates a stable, supportive domestic foundation."
    else:
        career_score = 18.0
        career_note = "Both partners have intense or distinct professional demands; intentional quality time will be essential."
        prompts.append("How do you plan to handle household responsibilities during peak work seasons?")

    # 3. Family Dynamics & Living Preferences (0-25 pts)
    fam1 = p1.get("family_dynamics", "nuclear")
    fam2 = p2.get("family_dynamics", "nuclear")

    if fam1 == fam2:
        fam_score = 25.0
        fam_note = f"Mutual agreement on living arrangements ({fam1.replace('_', ' ').title()}) prevents future in-law tension."
    elif {fam1, fam2} in [{"nuclear", "close_proximity"}, {"joint", "close_proximity"}]:
        fam_score = 21.0
        fam_note = "Nearby living preferences allow strong family connections while preserving couple autonomy."
    else:
        fam_score = 15.0
        fam_note = "Differing expectations regarding extended family living or proximity."
        prompts.append("What are your expectations for holiday traditions, vacations, and frequency of visiting in-laws?")

    # 4. Communication & Conflict Resolution (0-25 pts)
    comm1 = p1.get("communication_style", "collaborative")
    comm2 = p2.get("communication_style", "collaborative")

    if comm1 == comm2:
        comm_score = 25.0
        comm_note = f"Matching communication rhythm ({comm1.capitalize()}) allows swift conflict resolution."
    elif "collaborative" in [comm1, comm2]:
        comm_score = 23.0
        comm_note = "A collaborative communicator acts as a healthy mediator when tensions arise."
    else:
        comm_score = 18.0
        comm_note = f"Contrasting styles ({comm1} vs {comm2}). One partner may need time to process while the other seeks immediate resolution."
        prompts.append("When an argument gets heated, do you prefer solving it immediately or taking space to cool down?")

    # Kids alignment sanity check
    kids1 = p1.get("children_plan", "open_future")
    kids2 = p2.get("children_plan", "open_future")
    if kids1 != kids2 and (kids1 == "not_preferred" or kids2 == "not_preferred") and (kids1 == "definite_yes" or kids2 == "definite_yes"):
        # Significant life milestone divergence
        fin_score = max(10.0, fin_score - 5.0)
        prompts.append("Important: Have an early, honest conversation regarding children and family planning timelines.")

    total_values_score = round(fin_score + career_score + fam_score + comm_score, 1)

    return {
        "values_score": total_values_score,
        "financial_alignment": {"score": fin_score, "max": 25.0, "summary": fin_note},
        "career_alignment": {"score": career_score, "max": 25.0, "summary": career_note},
        "family_alignment": {"score": fam_score, "max": 25.0, "summary": fam_note},
        "communication_alignment": {"score": comm_score, "max": 25.0, "summary": comm_note},
        "recommended_prompts": prompts if prompts else [
            "What does a successful weekend together look like to recharge?",
            "How do your personal definitions of long-term financial security align?"
        ]
    }
