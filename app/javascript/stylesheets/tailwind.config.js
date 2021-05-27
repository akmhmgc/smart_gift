module.exports = {
  purge: false,
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {}
    ,opacity: ({ after }) => after(['disabled']),
  },
  plugins: [require('tailwind-hamburgers')],
}
