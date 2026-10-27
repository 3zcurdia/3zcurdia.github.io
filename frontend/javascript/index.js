import "$styles/index.css"
import "$styles/syntax-highlighting.scss"

document.addEventListener('DOMContentLoaded', function() {
  const btn = document.getElementById('mobile-menu-btn');
  const menu = document.getElementById('mobile-menu');

  if (!btn || !menu) return;

  btn.addEventListener('click', function() {
    const isExpanded = btn.getAttribute('aria-expanded') === 'true';
    btn.setAttribute('aria-expanded', String(!isExpanded));
    menu.classList.toggle('hidden');
  });

  document.addEventListener('keydown', function(event) {
    if (event.key !== 'Escape' || menu.classList.contains('hidden')) return;

    menu.classList.add('hidden');
    btn.setAttribute('aria-expanded', 'false');
    btn.focus();
  });
});
