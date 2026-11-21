"""
K.N.O.T. Backend Unit Tests
Verifies astronomical calculations, value alignments, Shastric Dosha cancellations,
and KMVA multi-vector algorithm integrity.
"""

import unittest
from datetime import datetime, timezone
import sys
import os

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from app.engine.celestial import (
    calculate_julian_date,
    calculate_moon_longitude,
    get_sidereal_position
)
from app.engine.values import evaluate_values_synergy
from app.engine.algorithm import (
    run_kmva_match,
    check_dosha_cancellations,
    check_chat_concurrency
)


class TestKnotEngine(unittest.TestCase):

    def test_julian_date_calculation(self):
        dt = datetime(2000, 1, 1, 12, 0, tzinfo=timezone.utc)
        jd = calculate_julian_date(dt)
        self.assertAlmostEqual(jd, 2451545.0, places=2)

    def test_values_alignment_high_compatibility(self):
        v1 = {
            "financial_philosophy": "balanced",
            "career_pace": "balanced",
            "family_dynamics": "nuclear",
            "communication_style": "collaborative",
            "children_plan": "open_future"
        }
        v2 = dict(v1)
        result = evaluate_values_synergy(v1, v2)
        self.assertEqual(result["values_score"], 100.0)

    def test_anti_ghosting_concurrency_limit(self):
        # User with 1 chat can connect
        can_connect, _ = check_chat_concurrency(1)
        self.assertTrue(can_connect)

        # User holding 3 active chats is capped to prevent ghosting
        can_connect, msg = check_chat_concurrency(3)
        self.assertFalse(can_connect)
        self.assertIn("Active Chat Limit Reached", msg)

    def test_kmva_dealbreaker_mitigation(self):
        dt1 = datetime(1995, 5, 15, 14, 30, tzinfo=timezone.utc)
        v1 = {"children_plan": "definite_yes", "financial_philosophy": "investor"}
        
        dt2 = datetime(1996, 10, 22, 9, 15, tzinfo=timezone.utc)
        # Incompatible kids dealbreaker
        v2 = {"children_plan": "not_preferred", "financial_philosophy": "investor"}

        result = run_kmva_match(dt1, True, v1, dt2, True, v2)
        self.assertTrue(result["values_layer"]["dealbreaker_flag"])
        self.assertIn("Dealbreaker Detected", result["verdict"])
        # Score must be capped below 50
        self.assertLess(result["values_layer"]["values_score"], 50.0)

    def test_kmva_confidence_scaling(self):
        dt1 = datetime(1995, 5, 15, 14, 30, tzinfo=timezone.utc)
        v1 = {"financial_philosophy": "balanced"}
        dt2 = datetime(1996, 10, 22, 9, 15, tzinfo=timezone.utc)
        v2 = {"financial_philosophy": "balanced"}

        # Exact time provided
        res_full = run_kmva_match(dt1, True, v1, dt2, True, v2)
        self.assertEqual(res_full["confidence_level"], "High (Verified Chart)")

        # Exact time NOT provided (Birth Date only) -> Baseline confidence
        res_partial = run_kmva_match(dt1, False, v1, dt2, False, v2)
        self.assertEqual(res_partial["confidence_level"], "Baseline (Birth Date Ephemeris)")
        self.assertEqual(res_partial["celestial_layer"]["confidence_multiplier"], 0.85)


if __name__ == "__main__":
    unittest.main()
