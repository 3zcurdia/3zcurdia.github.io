import "$styles/index.css"
import "$styles/syntax-highlighting.scss"

document.addEventListener('DOMContentLoaded', function() {
  const btn = document.getElementById('mobile-menu-btn');
  const menu = document.getElementById('mobile-menu');

  if (!btn || !menu) return;

  btn.addEventListener('click', function() {
    menu.classList.toggle('hidden');
  });
});
