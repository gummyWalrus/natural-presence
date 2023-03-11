/** @type {import('tailwindcss').Config} */


module.exports = {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    colors: {
      metal: 'rgb(0, 0, 0, 0.5)', ...require('tailwindcss/colors')
    },
  },
  plugins: [],
};
