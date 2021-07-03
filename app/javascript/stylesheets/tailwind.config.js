module.exports = {
  purge: {
    content: [
      './app/**/*.html.erb',
      './app/**/*.js.erb',
      './app/helpers/**/*.rb'
    ],
    options: {
      safelist: ['a', 'open', 'facebook_btn','twitter_btn','button','textarea','pagination','gap','current','fade'],
      keyframes: true,
      fontFace: true,
    },
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
    opacity: ({
      after
    }) => after(['disabled']),
  },
  plugins: [require('tailwind-hamburgers')],
}