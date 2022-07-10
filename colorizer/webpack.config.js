const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const webpack = require('webpack');
const fs = require('fs');


module.exports = (env, argv)=> ( {
  mode: "production",
  entry: './src/index.js',
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist'),
  },
  module: {
    rules: [
    ]
  },
  plugins: [
    new webpack.DefinePlugin({
      PRODUCTION: argv.production,
    }),
    new HtmlWebpackPlugin({
      template: 'index.html'
    }),
  ]

});