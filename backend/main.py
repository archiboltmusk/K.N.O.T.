"""
K.N.O.T. Backend Entrypoint & CLI Runner
Run with:
  python3 backend/main.py demo
Or with uvicorn (if installed):
  uvicorn app.main:app --reload
"""

import sys
import json
from datetime import datetime, timezone

try:
    from fastapi import FastAPI, HTTPException
    from pydantic import BaseModel, Field
    from typing import Optional, Dict, Any

    app = FastAPI(
        title="K.N.O.T. Dual-Layer Match Engine API",
        version="1.0.0",
        description="Intentional Matrimony & Dual Compatibility for Modern Working Professionals."
    )

    class BirthData(BaseModel):
        year: int = Field(..., example=1995)
        month: int = Field(..., ge=1, le=12, example=5)
        day: int = Field(..., ge=1, le=31, example=15)
        hour: int = Field(0, ge=0, le=23, example=14)
        minute: int = Field(0, ge=0, le=59, example=30)

    class ValuesData(BaseModel):
        financial_philosophy: str = Field("balanced", example="investor")
        career_pace: str = Field("balanced", example="high_drive")
        family_dynamics: str = Field("nuclear", example="close_proximity")
        communication_style: str = Field("collaborative", example="direct")
        children_plan: str = Field("open_future", example="definite_yes")

    class CompatibilityRequest(BaseModel):
        candidate_1_birth: BirthData
        candidate_1_values: ValuesData
        candidate_2_birth: BirthData
        candidate_2_values: ValuesData

    @app.get("/")
    def root():
        return {
            "platform": "K.N.O.T.",
            "status": "operational",
            "mission": "Intentional matrimony for working professionals aged 25-35.",
            "standard": "Truthful, privacy-first, zero fear-mongering"
        }

    @app.post("/api/v1/compatibility/evaluate")
    def api_evaluate(req: CompatibilityRequest):
        from app.engine.matchmaker import evaluate_dual_compatibility

        dt1 = datetime(
            req.candidate_1_birth.year,
            req.candidate_1_birth.month,
            req.candidate_1_birth.day,
            req.candidate_1_birth.hour,
            req.candidate_1_birth.minute,
            tzinfo=timezone.utc
        )
        dt2 = datetime(
            req.candidate_2_birth.year,
            req.candidate_2_birth.month,
            req.candidate_2_birth.day,
            req.candidate_2_birth.hour,
            req.candidate_2_birth.minute,
            tzinfo=timezone.utc
        )

        return evaluate_dual_compatibility(
            user1_birth_utc=dt1,
            user1_values=req.candidate_1_values.dict(),
            user2_birth_utc=dt2,
            user2_values=req.candidate_2_values.dict()
        )

except ImportError:
    app = None


def run_demo():
    """Runs a complete demonstration of the Dual-Layer K.N.O.T. engine."""
    from app.engine.matchmaker import evaluate_dual_compatibility

    print("=" * 65)
    print("💍 K.N.O.T. DUAL-LAYER COMPATIBILITY ENGINE (DEMO)")
    print("=" * 65)

    # Candidate 1: Tech Lead (Born May 15, 1995 at 14:30 UTC)
    dt1 = datetime(1995, 5, 15, 14, 30, tzinfo=timezone.utc)
    v1 = {
        "financial_philosophy": "investor",
        "career_pace": "high_drive",
        "family_dynamics": "close_proximity",
        "communication_style": "direct",
        "children_plan": "definite_yes"
    }

    # Candidate 2: Product Manager (Born Oct 22, 1996 at 09:15 UTC)
    dt2 = datetime(1996, 10, 22, 9, 15, tzinfo=timezone.utc)
    v2 = {
        "financial_philosophy": "balanced",
        "career_pace": "balanced",
        "family_dynamics": "close_proximity",
        "communication_style": "collaborative",
        "children_plan": "definite_yes"
    }

    result = evaluate_dual_compatibility(dt1, v1, dt2, v2)
    print(json.dumps(result, indent=2))
    print("=" * 65)
    print(f"🎯 Final K.N.O.T. Index: {result['knot_index']}/100")
    print(f"💡 Verdict: {result['verdict']}")
    print("=" * 65)


if __name__ == "__main__":
    run_demo()
