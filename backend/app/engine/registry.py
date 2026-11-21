"""
K.N.O.T. Ethical Milestone & Joint Savings Registry Engine
-----------------------------------------------------------
Replaces transactional biodata/dowry pressures with transparent,
equal-partner financial milestone planning (e.g., first home down payment,
ethical wedding fund, travel sabbatical fund) and smart-contract commitments.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional

@dataclass
class FinancialGoal:
    id: str
    title: str
    target_amount_inr: float
    current_amount_inr: float = 0.0
    category: str = "first_home"  # "first_home", "wedding_fund", "travel_sabbatical", "emergency_cushion"
    monthly_split_ratio: float = 0.5  # 50/50 default equal split

@dataclass
class RegistryPlan:
    couple_id: str
    partner1_name: str
    partner2_name: str
    goals: List[FinancialGoal] = field(default_factory=list)
    anti_dowry_charter_signed: bool = True
    escrow_verified: bool = True

def calculate_milestone_velocity(
    target_amount: float,
    current_amount: float,
    monthly_combined_savings: float
) -> Dict[str, float]:
    """
    Computes time-to-target in months, remaining balance, and equal split amounts.
    """
    remaining = max(0.0, target_amount - current_amount)
    if monthly_combined_savings <= 0:
        months_required = 999.0
    else:
        months_required = round(remaining / monthly_combined_savings, 1)
        
    return {
        "remaining_amount_inr": remaining,
        "months_to_milestone": months_required,
        "monthly_contribution_per_partner": round(monthly_combined_savings / 2.0, 2)
    }

def generate_default_registry(partner1: str, partner2: str) -> RegistryPlan:
    """
    Generates a progressive, dignified joint milestone registry.
    """
    goals = [
        FinancialGoal(
            id="goal_home_2026",
            title="First Home Down Payment (Bangalore / Mumbai)",
            target_amount_inr=2500000.0,
            current_amount_inr=650000.0,
            category="first_home",
            monthly_split_ratio=0.5
        ),
        FinancialGoal(
            id="goal_intimate_wedding",
            title="Sustainable Intimate Wedding (Zero Waste, 100 Guests)",
            target_amount_inr=1200000.0,
            current_amount_inr=400000.0,
            category="wedding_fund",
            monthly_split_ratio=0.5
        ),
        FinancialGoal(
            id="goal_japan_trip",
            title="Kyoto & Hokkaido Honeymoon / Sabbatical",
            target_amount_inr=600000.0,
            current_amount_inr=150000.0,
            category="travel_sabbatical",
            monthly_split_ratio=0.5
        )
    ]
    return RegistryPlan(
        couple_id=f"knot_{partner1.lower()}_{partner2.lower()}_registry",
        partner1_name=partner1,
        partner2_name=partner2,
        goals=goals,
        anti_dowry_charter_signed=True,
        escrow_verified=True
    )
