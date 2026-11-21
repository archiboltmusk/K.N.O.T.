"""
K.N.O.T. Intent-Density Guard & Anti-Ghosting Policy Engine
------------------------------------------------------------
Solves the "Single-Dot / Low-Effort Grace Timer Bypass" loophole common on
platforms like Bumble. A match slot is only protected and the 48h grace timer
only resets if the message meets quantifiable semantic and communicative depth.
"""

from typing import Dict, Any, List
import re

LOW_EFFORT_PATTERNS = [
    r"^\.+$",                  # "." or ".."
    r"^(hey|hi|hello|sup|yo|hola)\s*[\!\.]*$", # bare greetings
    r"^[👍👋❤️🔥😊🙏]+$",      # bare emojis
    r"^(k|kk|ok|okay|cool|nice|lol|haha)\s*[\!\.]*$" # one-word dismissives
]

def analyze_intent_density(message: str) -> Dict[str, Any]:
    """
    Evaluates message length, question density, and rejects canned low-effort evasion.
    Returns:
        - is_valid_intent: bool (True if message is sufficient to reset grace timer)
        - intent_score: float (0.0 to 100.0)
        - failure_reason: Optional[str]
    """
    clean = message.strip()
    
    # 1. Minimum character length check
    if len(clean) < 12:
        for pat in LOW_EFFORT_PATTERNS:
            if re.match(pat, clean.lower()):
                return {
                    "is_valid_intent": False,
                    "intent_score": 10.0,
                    "failure_reason": "Low-effort evasion detected. Acknowledge a prompt or ask an intentional question to maintain match slot."
                }
        if len(clean) < 6:
            return {
                "is_valid_intent": False,
                "intent_score": 15.0,
                "failure_reason": "Message is too brief to signify genuine marital intent."
            }

    # 2. Score calculation
    word_count = len(clean.split())
    has_question = "?" in clean
    has_prompt_reference = any(keyword in clean.lower() for keyword in ["noticed", "agree", "values", "career", "travel", "family", "goal", "think", "shared"])
    
    score = 50.0
    if word_count >= 10:
        score += 25.0
    elif word_count >= 5:
        score += 15.0
        
    if has_question:
        score += 15.0
    if has_prompt_reference:
        score += 10.0
        
    final_score = min(100.0, score)
    
    return {
        "is_valid_intent": final_score >= 40.0,
        "intent_score": final_score,
        "failure_reason": None if final_score >= 40.0 else "Message lacks communicative depth."
    }

def evaluate_7day_milestone(days_since_match: int, dates_scheduled: int) -> Dict[str, Any]:
    """
    Solves the 'Endless Pen-Pal' loophole. If 7 days have passed without
    scheduling an in-person or verified video date, triggers a Meet-or-Release prompt.
    """
    if days_since_match >= 7 and dates_scheduled == 0:
        return {
            "status": "MEET_OR_RELEASE_TRIGGERED",
            "prompt": "You have been conversing for 7 days. Intentional matrimony requires transitioning beyond text. Use AI Date Concierge or release this slot.",
            "requires_action": True
        }
    return {
        "status": "HEALTHY_MOMENTUM",
        "prompt": "Healthy conversational trajectory.",
        "requires_action": False
    }
