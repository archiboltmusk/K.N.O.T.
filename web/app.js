// K.N.O.T. Web Application Logic

document.addEventListener("DOMContentLoaded", () => {
  // 1. Waitlist Form Submission
  const waitlistForm = document.getElementById("waitlistForm");
  const waitlistSuccess = document.getElementById("waitlistSuccess");
  const spotNumberSpan = document.getElementById("spotNumber");

  if (waitlistForm) {
    waitlistForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const email = document.getElementById("emailInput").value;
      const city = document.getElementById("citySelect").value;

      if (!email) return;

      // Generate a realistic early beta spot number
      const randomSpot = Math.floor(Math.random() * 80) + 1420;
      spotNumberSpan.textContent = `#${randomSpot}`;

      waitlistForm.style.display = "none";
      waitlistSuccess.style.display = "block";
    });
  }

  // 2. Interactive Compatibility Teaser Calculation
  const calcBtn = document.getElementById("calcBtn");
  const resultCard = document.getElementById("resultCard");

  const signRhythms = {
    Aries: { elem: "Fire", pace: "Spontaneous & Bold" },
    Taurus: { elem: "Earth", pace: "Grounded & Deliberate" },
    Gemini: { elem: "Air", pace: "Fast & Fluid" },
    Cancer: { elem: "Water", pace: "Deep & Nurturing" },
    Leo: { elem: "Fire", pace: "Dynamic & Expressive" },
    Virgo: { elem: "Earth", pace: "Analytical & Structured" },
    Libra: { elem: "Air", pace: "Balanced & Harmonious" },
    Scorpio: { elem: "Water", pace: "Intense & Devoted" },
    Sagittarius: { elem: "Fire", pace: "Adventurous & Candid" },
    Capricorn: { elem: "Earth", pace: "Strategic & Long-Term" },
    Aquarius: { elem: "Air", pace: "Visionary & Independent" },
    Pisces: { elem: "Water", pace: "Empathetic & Creative" }
  };

  if (calcBtn) {
    calcBtn.addEventListener("click", () => {
      const s1 = document.getElementById("sign1").value;
      const f1 = document.getElementById("fin1").value;
      const s2 = document.getElementById("sign2").value;
      const f2 = document.getElementById("fin2").value;

      const data1 = signRhythms[s1];
      const data2 = signRhythms[s2];

      // Calculate sample scores
      let banter = 92;
      let pacing = 88;
      let index = 87;

      if (data1.elem === data2.elem) {
        banter = 96;
        pacing = 94;
        index = 95;
      } else if (
        (data1.elem === "Fire" && data2.elem === "Water") ||
        (data1.elem === "Water" && data2.elem === "Fire")
      ) {
        banter = 84;
        pacing = 78;
        index = 81;
      }

      document.getElementById("resIndex").textContent = `${index}/100`;
      document.getElementById("resBanter").textContent = `Banter Score: ${banter}%`;
      document.getElementById("resBanterDesc").textContent = `${s1} + ${s2}: Effortless conversational chemistry with natural mutual wit.`;
      
      document.getElementById("resPacing").textContent = `Passion & Pacing: ${pacing}%`;
      document.getElementById("resPacingDesc").textContent = `${f1} approach paired with ${f2} philosophy creates stable financial momentum.`;

      document.getElementById("resIcebreaker").textContent = `"${s1} meets ${s2}: Ask them what's one wildly ambitious career goal they've never told anyone else."`;

      resultCard.style.display = "block";
      resultCard.scrollIntoView({ behavior: "smooth", block: "nearest" });
    });
  }
});
