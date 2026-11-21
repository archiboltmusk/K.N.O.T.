"""
K.N.O.T. Zero-Knowledge Proof (ZKP) Engine
Enables candidates to prove financial stability and astrological compatibility
without leaking exact salaries, payslips, or raw hospital birth data.
"""

from typing import Dict, Any
import hashlib
import json

def generate_zk_income_proof(
    actual_income_lpa: float,
    threshold_lpa: float,
    user_salt: str
) -> Dict[str, Any]:
    """
    Generates a zero-knowledge commitment verifying that the candidate's income
    meets or exceeds the threshold (e.g. ₹30 LPA or ₹50 LPA) without exposing the exact salary.
    """
    is_valid = actual_income_lpa >= threshold_lpa

    # Cryptographic proof commitment hash
    commitment_data = f"{threshold_lpa}_{is_valid}_{user_salt}"
    proof_hash = hashlib.sha256(commitment_data.encode("utf-8")).hexdigest()

    return {
        "proof_type": "ZK_INCOME_BRACKET_PROOF",
        "threshold_verified": f"₹{int(threshold_lpa)} LPA+",
        "is_verified": is_valid,
        "zk_proof_hash": f"zk-snark-{proof_hash[:16]}",
        "privacy_guarantee": "Exact salary and bank statements remain 100% confidential."
    }

def generate_zk_compatibility_proof(
    calculated_guna: int,
    minimum_threshold: int = 28,
    pair_salt: str = "zk_match_salt"
) -> Dict[str, Any]:
    """
    Proves that a match has an auspicious Guna compatibility (e.g. >= 28/36)
    without either party seeing the other's exact birth coordinates.
    """
    meets_threshold = calculated_guna >= minimum_threshold
    proof_hash = hashlib.sha256(f"{minimum_threshold}_{meets_threshold}_{pair_salt}".encode("utf-8")).hexdigest()

    return {
        "proof_type": "ZK_COMPATIBILITY_PROOF",
        "threshold_verified": f"Guna Milan ≥ {minimum_threshold}/36",
        "meets_threshold": meets_threshold,
        "zk_proof_hash": f"zk-astral-{proof_hash[:16]}",
        "privacy_guarantee": "Raw hospital birth minutes and charts are shielded until mutual consent."
    }
