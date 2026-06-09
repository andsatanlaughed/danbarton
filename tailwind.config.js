/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./*.html'],
  theme: {
    extend: {
      fontFamily: {
        // Display serif — shared DNA with andsatanlaughed.com
        serif: ['"Cormorant Garamond"', 'Georgia', 'serif'],
        // Body sans
        sans: ['Inter', 'system-ui', 'sans-serif'],
        // Personal, handwritten voice — the "GUS" accent (unique to danbarton.me)
        script: ['Caveat', 'cursive'],
      },
      colors: {
        // Warmer, more personal palette than the flagship — same family, its own face.
        ink: {
          DEFAULT: '#211c18', // warm near-black
          soft: '#3a322b',
          muted: '#6b5f53',
        },
        paper: {
          DEFAULT: '#faf6ef', // warm cream
          deep: '#f1e8da',
          shade: '#e8ddc9',
        },
        brand: {
          red: '#c0282d',
          'red-deep': '#8f1c20',
          gold: '#c39a3e',
          'gold-light': '#e0c068',
        },
      },
      maxWidth: {
        prose: '46rem',
      },
      boxShadow: {
        photo: '0 18px 40px -20px rgba(33, 28, 24, 0.55)',
        card: '0 12px 30px -18px rgba(33, 28, 24, 0.35)',
      },
      keyframes: {
        'fade-up': {
          '0%': { opacity: '0', transform: 'translateY(14px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
      },
      animation: {
        'fade-up': 'fade-up 0.7s ease-out both',
      },
    },
  },
  plugins: [],
};
