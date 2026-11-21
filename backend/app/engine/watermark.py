"""
K.N.O.T. Forensic Session Watermarking & Anti-Leak Engine
-----------------------------------------------------------
Protects member privacy against unauthorized screenshots, Reddit gossip,
or WhatsApp distribution by embedding a verifiable cryptographic viewing token:
  Token = SHA256(ViewerID + ProfileOwnerID + SessionSalt + UnixTimestamp)

If an image or transcript is photographed or leaked, the unique forensic pattern
proves exactly which authenticated user account captured the screen,
enabling instant account revocation and legal enforcement under IT Acts.
"""

import hashlib
import time
from typing import Dict, Any

def generate_forensic_view_token(viewer_id: str, owner_id: str, salt: str = "knot_forensic_guard") -> Dict[str, Any]:
    """
    Generates a micro-watermark payload to be rendered dynamically across
    client card decks and chat viewports.
    """
    now = int(time.time())
    raw = f"{viewer_id}:{owner_id}:{salt}:{now}"
    token_hash = hashlib.sha256(raw.encode("utf-8")).hexdigest()
    
    # 8-character human-readable micro-tag + full 64-char audit string
    micro_tag = f"KNOT-{token_hash[:8].upper()}"
    
    return {
        "viewer_id": viewer_id,
        "owner_id": owner_id,
        "timestamp": now,
        "micro_tag": micro_tag,
        "audit_hash": token_hash,
        "overlay_text": f"K.N.O.T. Verified Viewing • {micro_tag} • Legal NDA Active"
    }

def verify_forensic_leak_source(reported_micro_tag: str, known_sessions: list) -> Dict[str, Any]:
    """
    Audits a reported screenshot leak against server-side session logs.
    """
    tag_upper = reported_micro_tag.upper().strip()
    for s in known_sessions:
        if s.get("micro_tag") == tag_upper or tag_upper in s.get("audit_hash", "").upper():
            return {
                "match_found": True,
                "leaking_user_id": s.get("viewer_id"),
                "timestamp": s.get("timestamp"),
                "recommended_action": "PERMANENT_ACCOUNT_TERMINATION_AND_LEGAL_NOTICE"
            }
            
    return {
        "match_found": False,
        "leaking_user_id": None,
        "recommended_action": "REQUIRE_FULL_RESOLUTION_IMAGE_FOR_EXIF_ANALYSIS"
    }
