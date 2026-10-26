# AGENTS.md

This file contains instructions for agentic coding agents working on this Bridgetown portfolio site.

## Project Overview

This is a Bridgetown 2.x (Ruby) static site generator for a personal artist portfolio. The site uses:
- Bridgetown for static site generation (content lives in `src/`, templates in Liquid)
- Tailwind CSS v3 bundled locally with esbuild + PostCSS (no CDN)
- Vanilla JavaScript (no frameworks), bundled with esbuild
- English language content

## Build and Development Commands

```bash
# Install dependencies
bundle install

# Build frontend assets (Tailwind CSS + JS) into output/_bridgetown/static/
yarn build

# Development server (frontend bundler + site watcher, http://localhost:4000)
bundle exec bridgetown start

# Build for production into output/
bundle exec bridgetown build

# Clean generated files
bundle exec bridgetown clean
```

## Testing

No automated testing framework is configured. Testing should be done manually by:
1. Running `bundle exec bridgetown start` and testing in browser
2. Checking responsive design at different viewport sizes
3. Verifying form functionality and navigation
4. Testing lightbox gallery functionality

## Code Style Guidelines

### File Organization
- Bridgetown directories use underscore prefix: `src/_layouts/`, `src/_partials/`, `src/_data/`
- Regular files use kebab-case: `about.markdown`, `main.js`
- Assets in `assets/` directory: `assets/js/`, `assets/images/`, `assets/css/`

### HTML/Liquid Conventions
- Use semantic HTML5 elements
- Include proper front matter with YAML (`---`)
- Use Liquid templating: `{{ variable }}` for output, `{% tag %}` for logic
- English language content: `lang="en"` on HTML element
- Mobile-first responsive design with Tailwind utilities

### CSS/Styling
- Use Tailwind CSS utility classes (compiled locally, config in `tailwind.config.js`)
- Custom color palette: `blush`, `rose-light`, `cream`, `rose-gold`, `dusty-rose`, `soft-pink`
- Custom fonts: Playfair Display (serif), Quicksand (sans-serif)
- Add custom CSS only in `<head>` section of layouts
- Use CSS custom properties for animations and transitions

### JavaScript Conventions
- Use modern ES6+ JavaScript
- camelCase for variables and functions: `mobileMenuBtn`, `openLightbox()`
- kebab-case for CSS classes and IDs: `mobile-menu`, `lightbox-img`
- Use defensive programming with element existence checks
- Add JSDoc-style comments for functions
- Event-driven architecture with `DOMContentLoaded` listener

### Import Patterns
- No ES6 imports/exports - use global scope
- Include Bridgetown partials with `{% render "file.html" %}`
- Load the bundled CSS/JS via `{% asset_path css %}` / `{% asset_path js %}` in `src/_layouts/base.html`
- Place JavaScript in `assets/js/main.js`

### Error Handling
- Use simple validation with user-friendly alerts (in English)
- Check element existence before DOM manipulation
- Use optional chaining for safe property access
- Provide fallback behavior for missing elements

### Naming Conventions

#### Files and Directories
- **Files**: kebab-case (`main.js`, `about.md`)
- **Directories**: lowercase with underscores (`_layouts`, `_includes`)
- **Bridgetown special files**: underscore prefix (`src/_data/`), config in `bridgetown.config.yml`

#### JavaScript
- **Variables/Functions**: camelCase (`highlightNav`, `updateNavbar`)
- **Constants**: UPPER_SNAKE_CASE (if needed)
- **CSS Classes/IDs**: kebab-case (`mobile-menu-btn`, `nav-link`)

#### HTML/Liquid
- **IDs/Classes**: kebab-case (`lightbox-img`, `mobile-menu`)
- **Site variables**: `site.metadata.title`, `site.data.site.*`, `page.description`

## Content Guidelines

### Language
- All content should be in English
- Use appropriate English terminology for UI elements
- Error messages and alerts should be in English

### Accessibility
- Use semantic HTML5 elements
- Include proper alt attributes for images
- Ensure keyboard navigation support
- Maintain proper heading hierarchy

### SEO
- Include meta descriptions for pages
- Use proper heading structure (h1, h2, h3, etc.)
- Add descriptive alt text for images
- Maintain clean URL structure

## Performance Guidelines

- Tailwind CSS is compiled by the esbuild/PostCSS pipeline (`yarn build`)
- Optimize images for web (appropriate sizes, formats)
- Minimize JavaScript - use vanilla JS only
- Leverage Bridgetown's built-in optimization
- Use responsive images with appropriate sizing

## Deployment

- Site is configured for GitHub Pages (CNAME file present)
- Use `bundle exec bridgetown build` for production builds (after `yarn build`)
- Ensure `output/` directory is gitignored
- Test thoroughly before deployment

## Common Tasks

### Adding New Pages
1. Create new file in root directory (e.g., `contact.markdown`)
2. Add front matter with layout and title
3. Include in navigation if needed

### Modifying Styles
1. Use Tailwind utility classes in HTML
2. Add custom CSS only in layout `<head>` section
3. Follow existing custom color palette

### Adding JavaScript Features
1. Edit `assets/js/main.js`
2. Use event listeners and defensive programming
3. Test functionality across devices

### Updating Content
1. Edit appropriate markdown or html files
2. Maintain English language consistency
3. Update meta descriptions if needed

## Important Notes

- Ruby + Node project: `Gemfile` for Bridgetown, `package.json` for esbuild/PostCSS/Tailwind
- CSS/JS are bundled locally with esbuild (no CDNs except FontAwesome and Google Fonts)
- All user-facing content should be in English
- Keep dependencies minimal - Bridgetown + Tailwind only
- Test responsive design thoroughly
- Maintain clean, semantic HTML structure
