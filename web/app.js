// K.N.O.T. Luxury Editorial Application Experience

document.addEventListener("DOMContentLoaded", () => {
  // --- 1. Background Celestial Canvas (Orbiting Stars & Planetary Rings) ---
  const canvas = document.getElementById("celestialCanvas");
  if (canvas) {
    const ctx = canvas.getContext("2d");
    let width = (canvas.width = window.innerWidth);
    let height = (canvas.height = window.innerHeight);

    window.addEventListener("resize", () => {
      width = canvas.width = window.innerWidth;
      height = canvas.height = window.innerHeight;
    });

    const stars = Array.from({ length: 85 }, () => ({
      x: Math.random() * width,
      y: Math.random() * height,
      radius: Math.random() * 1.5 + 0.5,
      alpha: Math.random() * 0.7 + 0.2,
      speed: Math.random() * 0.005 + 0.002
    }));

    let angle = 0;

    function render() {
      ctx.clearRect(0, 0, width, height);

      // Draw faint orbital concentric rings
      const cx = width / 2;
      const cy = height / 2;
      ctx.strokeStyle = "rgba(226, 201, 146, 0.04)";
      ctx.lineWidth = 1;

      [280, 420, 580].forEach((r) => {
        ctx.beginPath();
        ctx.arc(cx, cy, r, 0, Math.PI * 2);
        ctx.stroke();
      });

      // Render drifting stars
      stars.forEach((star) => {
        star.alpha += Math.sin(angle * 10) * star.speed;
        const boundedAlpha = Math.max(0.1, Math.min(0.9, star.alpha));
        ctx.fillStyle = `rgba(255, 255, 255, ${boundedAlpha})`;
        ctx.beginPath();
        ctx.arc(star.x, star.y, star.radius, 0, Math.PI * 2);
        ctx.fill();
      });

      angle += 0.002;
      requestAnimationFrame(render);
    }
    render();
  }

  // --- 2. Studio Tab Switching ---
  const tabs = document.querySelectorAll(".studio-tab");
  const panels = document.querySelectorAll(".studio-panel");

  tabs.forEach((tab) => {
    tab.addEventListener("click", () => {
      const target = tab.getAttribute("data-tab");

      tabs.forEach((t) => t.classList.remove("active"));
      panels.forEach((p) => p.classList.remove("active"));

      tab.classList.add("active");
      const activePanel = document.getElementById(target);
      if (activePanel) activePanel.classList.add("active");
    });
  });

  // --- 3. Privacy Photo Blur Toggle ---
  const blurToggles = document.querySelectorAll(".privacy-toggle-btn");
  const avatarElements = document.querySelectorAll(".avatar-wrap .avatar-initials");

  blurToggles.forEach((btn) => {
    btn.addEventListener("click", () => {
      avatarElements.forEach((el) => el.classList.toggle("avatar-blur"));
    });
  });

  // --- 4. Interactive Compatibility Matchmaker ---
  const runMatchBtn = document.getElementById("runMatchBtn");
  const matchResultBox = document.getElementById("matchResultBox");

  if (runMatchBtn && matchResultBox) {
    runMatchBtn.addEventListener("click", () => {
      const s1 = document.getElementById("userSign").value;
      const f1 = document.getElementById("userFin").value;
      const s2 = document.getElementById("matchSign").value;
      const f2 = document.getElementById("matchFin").value;

      // Calculate composite score
      let score = 89;
      let banter = 94;
      let cancellationNote = "Natural elemental harmony across both charts.";

      if (s1 === s2) {
        score = 96;
        banter = 98;
        cancellationNote = "Identical Moon Signs: Natural emotional rhythm and zero Bhakoot Dosha.";
      } else if (
        (s1 === "Scorpio" && s2 === "Aquarius") ||
        (s1 === "Aquarius" && s2 === "Scorpio")
      ) {
        score = 88;
        banter = 93;
        cancellationNote = "Classical Bhakoot Cancellation Applied: Mars & Saturn share natural neutral friendship; passion translates into dynamic drive.";
      }

      document.getElementById("outputKnotScore").textContent = score;
      document.getElementById("outputBanter").textContent = `Banter Score: ${banter}%`;
      document.getElementById("outputCancellation").textContent = cancellationNote;
      document.getElementById("outputIcebreaker").textContent = `"${s1} meets ${s2}: Ask them what hill they're willing to die on regarding spending vs saving."`;

      matchResultBox.style.display = "block";
      matchResultBox.scrollIntoView({ behavior: "smooth", block: "nearest" });
    });
  }

  // --- 5. Waitlist Form Submission ---
  const waitlistForm = document.getElementById("waitlistForm");
  const waitlistSuccess = document.getElementById("waitlistSuccess");
  const waitlistNumber = document.getElementById("waitlistNumber");

  if (waitlistForm) {
    waitlistForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const randomRank = Math.floor(Math.random() * 60) + 1410;
      if (waitlistNumber) waitlistNumber.textContent = `#${randomRank}`;
      waitlistForm.style.display = "none";
      if (waitlistSuccess) waitlistSuccess.style.display = "block";
    });
  }
});
