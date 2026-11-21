"""
K.N.O.T. Backend Unit Tests
Verifies astronomical calculations, value alignments, and edge cases.
"""

import unittest
from datetime import datetime, timezone
import sys
import os

# Ensure backend root is on sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from app.engine.celestial import (
    calculate_julian_date,
    calculate_moon_longitude,
    calculate_sun_longitude,
    get_sidereal_position,
    evaluate_celestial_synergy,
    RASHIS,
    NAKSHATRAS
)
from app.engine.values import evaluate_values_synergy
from app.engine.matchmaker import evaluate_dual_compatibility


class TestKnotEngine(unittest.TestCase):

    def test_julian_date_calculation(self):
        # Known standard astronomical epoch: J2000.0 is 2000-01-01 12:00 UTC = 2451545.0
        dt = datetime(2000, 1, 1, 12, 0, tzinfo=timezone.utc)
        jd = calculate_julian_date(dt)
        self.assertAlmostEqual(jd, 2451545.0, places=2)

    def test_sidereal_position_structure(self):
        dt = datetime(1995, 8, 15, 6, 30, tzinfo=timezone.utc)
        jd = calculate_julian_date(dt)
        moon_deg = calculate_moon_longitude(jd)
        pos = get_sidereal_position(moon_deg, jd)

        self.assertIn("name", pos.rashi)
        self.assertIn("sanskrit", pos.rashi)
        self.assertIn("element", pos.rashi)
        self.assertIn("name", pos.nakshatra)
        self.assertIn("temperament", pos.nakshatra)
        self.assertTrue(1 <= pos.pada <= 4)
        self.assertTrue(0.0 <= pos.degree_in_sign <= 30.0)

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
        # Fully identical values should yield maximum 100 points
        self.assertEqual(result["values_score"], 100.0)
        self.assertIn("recommended_prompts", result)

    def test_dual_compatibility_flow(self):
        dt1 = datetime(1992, 4, 10, 8, 0, tzinfo=timezone.utc)
        v1 = {
            "financial_philosophy": "investor",
            "career_pace": "high_drive",
            "family_dynamics": "close_proximity",
            "communication_style": "direct",
            "children_plan": "definite_yes"
        }

        dt2 = datetime(1994, 9, 25, 18, 30, tzinfo=timezone.utc)
        v2 = {
            "financial_philosophy": "balanced",
            "career_pace": "balanced",
            "family_dynamics": "close_proximity",
            "communication_style": "collaborative",
            "children_plan": "definite_yes"
        }

        report = evaluate_dual_compatibility(dt1, v1, dt2, v2)

        self.assertIn("knot_index", report)
        self.assertTrue(0 <= report["knot_index"] <= 100)
        self.assertIn("celestial_layer", report)
        self.assertIn("values_layer", report)
        self.assertIn("verdict", report)
        self.assertIn("summary", report)


if __name__ == "__main__":
    unittest.main()
