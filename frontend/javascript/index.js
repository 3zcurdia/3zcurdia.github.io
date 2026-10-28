import "../styles/index.css"
import "../styles/syntax-highlighting.css"

document.addEventListener('DOMContentLoaded', function() {
  const btn = document.getElementById('mobile-menu-btn');
  const menu = document.getElementById('mobile-menu');

  if (!btn || !menu) return;

  const header = btn.closest('header');
  const menuIcon = btn.querySelector('[data-menu-icon]');

  const setMenuState = function(isOpen) {
    btn.setAttribute('aria-expanded', String(isOpen));
    btn.setAttribute('aria-label', isOpen ? 'Close navigation' : 'Open navigation');
    menu.classList.toggle('hidden', !isOpen);

    if (menuIcon) {
      menuIcon.classList.toggle('fa-bars', !isOpen);
      menuIcon.classList.toggle('fa-xmark', isOpen);
    }
  };

  btn.addEventListener('click', function() {
    const isExpanded = btn.getAttribute('aria-expanded') === 'true';
    setMenuState(!isExpanded);
  });

  menu.querySelectorAll('a').forEach(function(link) {
    link.addEventListener('click', function() {
      setMenuState(false);
    });
  });

  document.addEventListener('click', function(event) {
    if (!header || header.contains(event.target)) return;
    if (btn.getAttribute('aria-expanded') !== 'true') return;

    setMenuState(false);
  });

  document.addEventListener('keydown', function(event) {
    if (event.key !== 'Escape' || menu.classList.contains('hidden')) return;

    setMenuState(false);
    btn.focus();
  });

  window.matchMedia('(min-width: 768px)').addEventListener('change', function(event) {
    if (event.matches) setMenuState(false);
  });
});
