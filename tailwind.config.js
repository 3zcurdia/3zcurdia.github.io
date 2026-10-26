/** @type {import('tailwindcss').Config} */
export default {
  content: ["./src/**/*.{html,md,liquid}"],
  theme: {
    extend: {
      colors: {
        "columbia-blue": "#D4EBFA",
        "oxford-blue": "#0F2945",
        "indigo-dye": "#1C476C",
      },
      fontFamily: {
        sans: ["Inter", "system-ui", "sans-serif"],
      },
    },
  },
  plugins: [require("@tailwindcss/typography")],
};
