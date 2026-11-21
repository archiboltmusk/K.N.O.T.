# The K.N.O.T. Multi-Vector Match Algorithm (KMVA)
> **Mathematical, Shastric, and Behavioral Specifications**

---

## 1. Algorithmic Overview & Loophole Elimination

Traditional matrimony and dating algorithms suffer from five structural vulnerabilities that lead to high churn, false rejections, and toxic user behavior. KMVA systematically resolves each loophole:

```
┌─────────────────────────────────┬─────────────────────────────────┬─────────────────────────────────┐
│       LEGACY LOOPHOLE           │        ROOT CAUSE               │          KMVA RESOLUTION        │
├─────────────────────────────────┼─────────────────────────────────┼─────────────────────────────────┤
│ 1. Binary Dosha Rejection       │ Blind 0/8 penalty on Nadi or    │ Classical Shastric Cancellation │
│                                 │ Bhakoot ignoring exceptions.    │ & Mitigation Rules.             │
├─────────────────────────────────┼─────────────────────────────────┼─────────────────────────────────┤
│ 2. Birth Time Drop-off (80%)    │ Demanding hospital minutes on   │ Probabilistic Ephemeris Window  │
│                                 │ Screen 1 before matching.       │ with Confidence Scaling (0.85). │
├─────────────────────────────────┼─────────────────────────────────┼─────────────────────────────────┤
│ 3. Unspoken Marriage Killers    │ Swiping on hobbies while        │ Multi-Vector Cosine Similarity  │
│                                 │ ignoring finances and in-laws.  │ + Hard Dealbreaker Gating.      │
├─────────────────────────────────┼─────────────────────────────────┼─────────────────────────────────┤
│ 4. Match Hoarding & Ghosting    │ Infinite chats leading to zero  │ Strict Concurrency Limit        │
│                                 │ emotional commitment.           │ (Max 3 Active Conversations).   │
├─────────────────────────────────┼─────────────────────────────────┼─────────────────────────────────┤
│ 5. Safety & Screenshot Leaks    │ Publicly exposing birth data    │ Zero-Knowledge Profile Masking  │
│                                 │ and unblurred photos.           │ ("Blur Until Mutual Match").    │
└─────────────────────────────────┴─────────────────────────────────┴─────────────────────────────────┘
```

---

## 2. Mathematical Formulation

The final **K.N.O.T. Index ($S_{\text{total}}$)** is formulated as a composite multi-vector function bounded in $[0, 100]$:

$$S_{\text{total}} = \Big( w_v \cdot S_{\text{values}} + w_c \cdot (C_{\text{confidence}} \cdot S_{\text{celestial}}) \Big) \cdot \delta_{\text{dealbreaker}}$$

Where:
* $w_v = 0.55$ (Values weight: Real-world psychology, finances, living expectations).
* $w_c = 0.45$ (Celestial weight: Vedic synastry, planetary harmony, emotional pacing).
* $C_{\text{confidence}} \in \{0.85, 1.00\}$:
  * $C = 1.00$ when both candidates supply verified birth times and locations.
  * $C = 0.85$ baseline when using Date of Birth (Sun, Moon, and Nakshatra without sub-pada).
* $\delta_{\text{dealbreaker}} \in \{0.40, 1.00\}$: Hard multiplier penalizing irreconcilable dealbreakers (e.g., mutually exclusive children timelines).

---

## 3. Shastric Cancellation Engine (Brihat Parashara Hora Shastra)

Traditional astrology apps give a hard **0 points** if a couple triggers Nadi or Bhakoot Dosha, terrorizing families. In authentic Vedic texts, specific planetary configurations **completely cancel** the Dosha:

### A. Bhakoot Dosha Cancellation
Bhakoot occurs when Moon signs are in a 6/8 (*Shadashtaka*) or 9/5 (*Navapanchama*) relationship.
$$\text{Cancelled if: } \mathcal{R}(L_1, L_2) = \text{Friendship} \quad \text{or} \quad L_1 = L_2$$
Where $L_1, L_2$ are the planetary rulers of the Moon signs. When rulers are friends (e.g., Mars & Jupiter, or Sun & Moon), the friction dissolves into constructive dynamic balance.

### B. Nadi Dosha Cancellation
Nadi occurs when both partners share the same Nakshatra triad (*Adi, Madhya, Antya*).
$$\text{Cancelled if: } (\text{Rashi}_1 = \text{Rashi}_2 \land \text{Nak}_1 \neq \text{Nak}_2) \lor (\text{Nak}_1 = \text{Nak}_2 \land \text{Rashi}_1 \neq \text{Rashi}_2) \lor (L_1 = L_2)$$
KMVA checks all 14 classical cancellation conditions automatically, recovering up to **30 points** that legacy apps discard.

---

## 4. Multi-Vector Values Engine (Layer 2)

Four orthogonal axes represent the primary causes of marital divorce:

$$S_{\text{values}} = \sum_{i \in \{\text{fin}, \text{car}, \text{fam}, \text{com}\}} w_i \cdot \text{Sim}(V_{1,i}, V_{2,i})$$

1. **Financial Axis ($w = 0.30$):** Disciplined Investor, Balanced Prudent, Disciplined Saver, Experiential.
2. **Career Axis ($w = 0.25$):** High-Drive Executive, Steady Balanced, Entrepreneurial Fluid.
3. **Family Axis ($w = 0.25$):** Close Proximity to Parents, Independent Nuclear, Joint Family.
4. **Communication Axis ($w = 0.20$):** Collaborative Discussion, Direct Immediate, Reflective Measured.

---

## 5. Anti-Ghosting Concurrency Management

To prevent users from collecting matches and ghosting:
* **Active Chat Ceiling ($N_{\text{max}} = 3$):** A candidate cannot send or accept a new introduction while holding 3 active chats.
* **Structured Closure:** To open a slot, the user must either progress to a date/contact exchange or send a polite, 1-tap respectful closure message (*"Thank you for the conversation; I don't feel we are a romantic fit, but I wish you the best"*).
