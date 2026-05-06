/**
 * CosmosIQ — animation engine + AI fact helper
 */

// ── AI Fact Generator ─────────────────────────────────────────────────────────
function generateAiFact(topicKey, topicDescription, targetElementId) {
  var target = document.getElementById(targetElementId);
  if (!target) return;
  target.innerHTML = '<span class="text-primary animate-pulse">Analyzing deep space data...</span>';
  target.style.display = 'block';
  fetch(contextPath + '/aifact?key=' + encodeURIComponent(topicKey) + '&topic=' + encodeURIComponent(topicDescription))
    .then(function(r) { return r.json(); })
    .then(function(data) {
      target.innerHTML = '<span class="material-symbols-outlined text-primary text-sm mr-2">auto_awesome</span>' + data.fact;
    })
    .catch(function(err) {
      target.innerHTML = '<span class="text-error">Signal lost. Try again.</span>';
    });
}

// ── Animation Engine ──────────────────────────────────────────────────────────
(function () {
  'use strict';

  // 1. IntersectionObserver reveal (.a-reveal, .a-reveal-up, etc.)
  function initReveal() {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (e.isIntersecting) { e.target.classList.add('a-in'); io.unobserve(e.target); }
      });
    }, { threshold: 0.08, rootMargin: '0px 0px -40px 0px' });
    document.querySelectorAll(
      '.a-reveal,.a-reveal-up,.a-reveal-scale,.a-reveal-left,.a-reveal-right,.a-reveal-blur'
    ).forEach(function (el) { io.observe(el); });
  }

  // 2. Split-text word-by-word reveal (.a-split)
  function initSplitText() {
    document.querySelectorAll('.a-split').forEach(function (el) {
      var lines = el.innerHTML.split(/<br\s*\/?>/i);
      el.innerHTML = lines.map(function (line) {
        return line.trim().split(/\s+/).map(function (w, i) {
          return '<span style="display:inline-block;overflow:hidden;vertical-align:bottom">' +
            '<span class="split-word" style="display:inline-block;transform:translateY(100%);opacity:0;' +
            'transition:transform .9s cubic-bezier(.16,1,.3,1) ' + (i * 0.09) + 's,' +
            'opacity .9s ease ' + (i * 0.09) + 's">' + w + '</span></span>';
        }).join(' ');
      }).join('<br/>');

      var io = new IntersectionObserver(function (entries) {
        entries.forEach(function (e) {
          if (e.isIntersecting) {
            e.target.querySelectorAll('.split-word').forEach(function (w) {
              w.style.transform = 'translateY(0)'; w.style.opacity = '1';
            });
            io.unobserve(e.target);
          }
        });
      }, { threshold: 0.1 });
      io.observe(el);
    });
  }

  // 3. Count-up numbers (.a-counter)
  function initCounters() {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (!e.isIntersecting) return;
        var el  = e.target;
        var end = parseFloat(el.textContent.replace(/[^0-9.]/g, ''));
        var dec = el.textContent.indexOf('.') !== -1 ? 1 : 0;
        var start = performance.now();
        (function step(now) {
          var t = Math.min((now - start) / 1400, 1);
          t = 1 - Math.pow(1 - t, 3);
          el.textContent = (end * t).toFixed(dec);
          if (t < 1) requestAnimationFrame(step);
        })(start);
        io.unobserve(el);
      });
    }, { threshold: 0.3 });
    document.querySelectorAll('.a-counter').forEach(function (el) { io.observe(el); });
  }

  // 4. Parallax ([data-parallax])
  function initParallax() {
    var els = Array.prototype.slice.call(document.querySelectorAll('[data-parallax]'));
    if (!els.length) return;
    var raf = false;
    window.addEventListener('scroll', function () {
      if (raf) return;
      raf = true;
      requestAnimationFrame(function () {
        var sy = window.scrollY;
        els.forEach(function (el) {
          el.style.transform = 'translateY(' + (sy * (parseFloat(el.dataset.parallax) || 0.1)) + 'px)';
        });
        raf = false;
      });
    }, { passive: true });
  }

  // 5. Pin-scroll feature panels
  function initPinScroll() {
    var section  = document.getElementById('features-pin-section');
    if (!section) return;
    var panels   = Array.prototype.slice.call(section.querySelectorAll('.pin-panel'));
    var dots     = Array.prototype.slice.call(document.querySelectorAll('.pin-dot'));
    var progBar  = document.getElementById('pin-progress-bar');
    var panelLbl = document.getElementById('pin-panel-label');
    var accentBar= document.getElementById('pin-accent-bar');
    if (!panels.length) return;

    var COLORS  = ['#6dddff', '#fdb64b', '#6dddff', '#6dddff'];
    var LABELS  = ['01  /  Astronomy', '02  /  Exploration', '03  /  Planetary Defense', '04  /  Space Station'];

    // Set initial transition style on all panels via JS
    panels.forEach(function (p, i) {
      p.style.transition = 'opacity 0.65s cubic-bezier(0.25,0.46,0.45,0.94), transform 0.65s cubic-bezier(0.25,0.46,0.45,0.94)';
    });
    if (dots[0]) dots[0].classList.add('active');

    var last = -1, raf = false;
    function update() {
      var rect = section.getBoundingClientRect();
      var prog = Math.max(0, Math.min(1, -rect.top / (section.offsetHeight - window.innerHeight)));
      var step = Math.min(Math.floor(prog * panels.length), panels.length - 1);

      // Always update progress bar (continuous)
      if (progBar) progBar.style.width = (prog * 100) + '%';

      if (step === last) { raf = false; return; }
      last = step;

      panels.forEach(function (p, i) {
        p.style.opacity       = i === step ? '1' : '0';
        p.style.transform     = i === step ? 'translateY(0) scale(1)' : i < step ? 'translateY(-52px) scale(0.97)' : 'translateY(52px) scale(0.97)';
        p.style.pointerEvents = i === step ? 'auto' : 'none';
      });
      dots.forEach(function (d, i) { d.classList.toggle('active', i === step); });
      if (accentBar) accentBar.style.background = COLORS[step] || COLORS[0];
      if (panelLbl)  panelLbl.textContent        = LABELS[step] || '';
      raf = false;
    }

    update(); // init state
    window.addEventListener('scroll', function () {
      if (!raf) { raf = true; requestAnimationFrame(update); }
    }, { passive: true });
  }

  // 6. Hero content fade + parallax on scroll
  function initHeroParallax() {
    var hero  = document.querySelector('[data-hero-section]');
    var inner = document.querySelector('[data-hero-inner]');
    if (!hero || !inner) return;
    var raf = false;
    window.addEventListener('scroll', function () {
      if (raf) return;
      raf = true;
      requestAnimationFrame(function () {
        var y    = window.scrollY;
        var prog = Math.min(y / (window.innerHeight * 0.6), 1);
        inner.style.transform = 'translateY(' + (y * 0.28) + 'px)';
        inner.style.opacity   = Math.max(0, 1 - prog * 1.2).toFixed(3);
        raf = false;
      });
    }, { passive: true });
  }

  // 7. Canvas starfield (#starfield)
  function initStarfield() {
    var canvas = document.getElementById('starfield');
    if (!canvas) return;
    var ctx = canvas.getContext('2d'), stars = [];
    function resize() {
      canvas.width  = canvas.offsetWidth;
      canvas.height = canvas.offsetHeight;
      stars = Array.from({ length: 240 }, function () {
        return { x: Math.random() * canvas.width, y: Math.random() * canvas.height,
          r: Math.random() * 1.4 + 0.1, a: Math.random() * 0.7 + 0.1, da: (Math.random() - 0.5) * 0.007 };
      });
    }
    (function draw() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      stars.forEach(function (s) {
        s.a += s.da; if (s.a < 0.05 || s.a > 0.85) s.da *= -1;
        ctx.beginPath(); ctx.arc(s.x, s.y, s.r, 0, Math.PI * 2);
        ctx.fillStyle = 'rgba(241,239,251,' + s.a + ')'; ctx.fill();
      });
      requestAnimationFrame(draw);
    })();
    window.addEventListener('resize', resize); resize();
  }

  // 8. Stagger lists ([data-stagger])
  function initStaggerLists() {
    document.querySelectorAll('[data-stagger]').forEach(function (list) {
      var delay = parseFloat(list.dataset.stagger) || 0.06;
      var io = new IntersectionObserver(function (entries) {
        entries.forEach(function (e) {
          if (!e.isIntersecting) return;
          Array.prototype.slice.call(e.target.children).forEach(function (child, i) {
            child.style.transitionDelay = (i * delay) + 's';
            child.classList.add('a-in');
          });
          io.unobserve(e.target);
        });
      }, { threshold: 0.05 });
      Array.prototype.slice.call(list.children).forEach(function (child) {
        child.classList.add('a-reveal');
      });
      io.observe(list);
    });
  }

  // ── Boot ──────────────────────────────────────────────────────────────────
  document.addEventListener('DOMContentLoaded', function () {
    initReveal();
    initSplitText();
    initCounters();
    initParallax();
    initPinScroll();
    initHeroParallax();
    initStarfield();
    initStaggerLists();
  });

})();
