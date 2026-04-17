/**
 * CosmosIQ client-side helpers
 */

// ===== AI Fact Generator =====
function generateAiFact(topicKey, topicDescription, targetElementId) {
    const target = document.getElementById(targetElementId);
    if (!target) return;

    target.innerHTML = '<span class="text-primary animate-pulse">Analyzing deep space data...</span>';
    target.style.display = 'block';

    fetch(contextPath + '/aifact?key=' + encodeURIComponent(topicKey) + '&topic=' + encodeURIComponent(topicDescription))
        .then(r => r.json())
        .then(data => {
            target.innerHTML = '<span class="material-symbols-outlined text-primary text-sm mr-2" style="font-variation-settings:\'FILL\' 1">auto_awesome</span>' + data.fact;
        })
        .catch(() => {
            target.innerHTML = '<span class="text-error">Signal lost. Try again.</span>';
        });
}

// ===== Scroll Fade-in Observer =====
document.addEventListener('DOMContentLoaded', function() {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('opacity-100', 'translate-y-0');
                entry.target.classList.remove('opacity-0', 'translate-y-8');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.fade-in').forEach(el => {
        el.classList.add('opacity-0', 'translate-y-8', 'transition-all', 'duration-700');
        observer.observe(el);
    });
});
