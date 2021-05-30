let environment = {
  plugins: [
    require('tailwindcss')("./app/javascript/stylesheets/tailwind.config.js"),
    require('postcss-import'),
    require('autoprefixer'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}


if (process.env.RAILS_ENV === "production") {
  environment.plugins.push(
    require('@fullhuman/postcss-purgecss')({
      content: [
        './app/**/*.html.erb',
        './app/**/*.js.erb',
        './app/helpers/**/*.rb',
      ],
      keyframes: true,
      fontFace: true,
      safelist: ['a', 'open', 'facebook_btn','twitter_btn','button','textarea','pagination','gap','current'],
      defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
    })
  )
}

module.exports = environment 