/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: [
          '-apple-system', 'BlinkMacSystemFont', '"Segoe UI"', 'Roboto',
          '"Helvetica Neue"', 'Arial', '"Noto Sans JP"', '"ヒラギノ角ゴ Pro W3"',
          'メイリオ', 'Meiryo', '"ＭＳ Ｐゴシック"', 'sans-serif',
        ],
      },
    },
  },
  plugins: [],
}
