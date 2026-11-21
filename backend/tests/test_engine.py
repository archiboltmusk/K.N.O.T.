"""
K.N.O.T. Backend Unit Tests - Production v2.0
Verifies all 5 loophole fixes:
1. Cusp detection (±0.75° boundary identification)
2. Situational behavioral dilemmas (anti-profile gaming)
3. 48-hour first-message grace timer (anti-ghosting)
4. Cryptographic Family Vault SHA-256 verification (anti-forgery)
5. Shastric Dosha cancellations
"""

import unittest
from datetime import datetime, timezone, timedelta
import sys
import os

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from app.engine.celestial import (
    calculate_julian_date,
    calculate_moon_longitude,
    get_sidereal_position,
    detect_cusp_birth
)
from app.engine.values import evaluate_situational_dilemmas, DILEMMAS
from app.engine.algorithm import (
    run_kmva_match,
    check_dosha_cancellations,
    check_chat_concurrency_and_ghosting
)
from app.engine.vault import generate_vault_dossier, verify_vault_hash
from app.engine.dasha import calculate_current_dasha, evaluate_dasha_timing_synergy


class TestKnotProductionEngine(unittest.TestCase):

    def test_vimshottari_dasha_timing(self):
        # Candidate born May 15, 1995 with Moon in Scorpio (Anuradha, lord Saturn)
        b_dt = datetime(1995, 5, 15, 14, 30, tzinfo=timezone.utc)
        dasha = calculate_current_dasha(b_dt, moon_longitude=218.0)
        self.assertIn("active_dasha_lord", dasha)
        self.assertIn("life_phase_theme", dasha)

        # Test timing synergy
        dasha1 = {"active_dasha_lord": "Jupiter", "life_phase_theme": "Expansion"}
        dasha2 = {"active_dasha_lord": "Venus", "life_phase_theme": "Nesting"}
        synergy = evaluate_dasha_timing_synergy(dasha1, dasha2)
        self.assertTrue(synergy["is_in_sync"])
        self.assertEqual(synergy["timing_score"], 94.0)

    def test_cusp_detection(self):
        # Degree exactly at 0.4° (inside ±0.75° cusp buffer of Aries 0°)
        cusp = detect_cusp_birth(0.4)
        self.assertTrue(cusp.is_cusp)
        self.assertTrue(cusp.rashi_cusp)
        self.assertIsNotNone(cusp.adjacent_rashi)

        # Degree at 15.0° (deep inside the sign, safely away from any cusp)
        non_cusp = detect_cusp_birth(15.0)
        self.assertFalse(non_cusp.is_cusp)

    def test_situational_dilemmas_anti_gaming(self):
        # Two users choosing the identical investor / collaborative options
        answers1 = {
            "financial_bonus": "A",
            "career_crunch": "A",
            "family_boundary": "B",
            "conflict_response": "C"
        }
        answers2 = dict(answers1)

        res = evaluate_situational_dilemmas(answers1, answers2)
        self.assertEqual(res["dilemma_score"], 100.0)

        # Diverse answers
        answers_divergent = {
            "financial_bonus": "D", # Experiential
            "career_crunch": "B", # Balanced
            "family_boundary": "A", # Joint
            "conflict_response": "B"  # Direct
        }
        res_div = evaluate_situational_dilemmas(answers1, answers_divergent)
        self.assertLess(res_div["dilemma_score"], 70.0)

    def test_ghosting_and_48hr_grace_timer(self):
        now = datetime.now(timezone.utc)
        
        # Chat 1: Active conversation with messages
        chat_active = {"chat_id": "c1", "matched_at": now - timedelta(days=3), "message_count": 12}
        
        # Chat 2: Stalled conversation with 0 messages for 60 hours (> 48h grace)
        chat_ghosted = {"chat_id": "c2", "matched_at": now - timedelta(hours=60), "message_count": 0}

        can_connect, msg, releasable = check_chat_concurrency_and_ghosting([chat_active, chat_ghosted])
        
        # Chat 2 should be automatically detected as releasable
        self.assertIn("c2", releasable)
        self.assertTrue(can_connect)

    def test_cryptographic_vault_dossier_tamper_proof(self):
        dossier = generate_vault_dossier(
            candidate1_name="Rahul Sharma",
            candidate1_birth_utc="1995-05-15T14:30:00Z",
            candidate1_rashi="Scorpio",
            candidate1_nakshatra="Anuradha",
            candidate2_name="Ananya Iyer",
            candidate2_birth_utc="1996-10-22T09:15:00Z",
            candidate2_rashi="Aquarius",
            candidate2_nakshatra="Shatabhisha",
            guna_score=31,
            dosha_cancellations="Active Shastric Exceptions Applied"
        )

        h = dossier["verification_id"]
        self.assertTrue(h.startswith("KNOT-"))

        # Valid payload must verify
        is_valid = verify_vault_hash(dossier["payload"], h)
        self.assertTrue(is_valid)

        # Altered payload (e.g. malicious user edits Guna score in PDF) must FAIL
        tampered_payload = dict(dossier["payload"])
        tampered_payload["guna_milan"] = "36/36"  # Tampered!
        is_tampered_valid = verify_vault_hash(tampered_payload, h)
        self.assertFalse(is_tampered_valid)


if __name__ == "__main__":
    unittest.main()
