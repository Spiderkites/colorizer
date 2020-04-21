const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const SpiderkitesWebpackPlugin = require('./spiderkites-webpack-plugin.js');
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
      {
        test: /\.svg$/,
        loaders: [
          {
            loader: 'svg-inline-loader'
          }
        ]
      }
    ]
  },
  plugins: [
    new webpack.DefinePlugin({
      PRODUCTION: argv.production,
    }),
    new HtmlWebpackPlugin({
      template: './src/templates/wawi_colorizer.html',
      filename: 'wawi_colorizer.html'
    }),
    new HtmlWebpackPlugin({
      template: 'index.html'
    }),
    new SpiderkitesWebpackPlugin({
      pattern: /{{{{wawi_colorizer}}}}/,
      templateOutputName: 'wawi_colorizer.html'
    })
  ]

});