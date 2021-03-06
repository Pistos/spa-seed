module.exports = {
  root: true,
  parserOptions: {
    sourceType: 'module'
  },
  // https://github.com/feross/standard/blob/master/RULES.md#javascript-standard-style
  extends: 'standard',
  // required to lint *.vue files
  plugins: [
    'html'
  ],
  // add your custom rules here
  'rules': {
    // allow paren-less arrow functions
    'arrow-parens': 0,
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 2 : 0,
    'comma-dangle': [1, 'always-multiline'],
    'eol-last': 0,
    'space-infix-ops': 0,
    'keyword-spacing': 0,
    'space-in-parens': 0,
    'space-unary-ops': 0,
  }
}
