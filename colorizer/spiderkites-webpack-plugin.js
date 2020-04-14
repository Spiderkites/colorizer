function SpiderkitesWebpackPlugin(option) {

    const errorMassage = 'Please ensure that `html-webpack-plugin` was placed before `spiderkites-webpack-plugin` in your Webpack config if you were working with Webpack 4.x!';


    if (typeof option.pattern == 'undefined' || typeof option.templateOutputName == 'undefined') {
        throw new Error('Both `pattern` and `templateOutputName` options must be defined!')
    }


    this.replace = function (htmlPluginData, callback) {

        if (option.templateOutputName === htmlPluginData.outputName) {
            option.replacement = htmlPluginData.html = htmlPluginData.html.replace('<script src="main.js"></script>', '');
        } else if (option.replacement) {
            if (option.pattern instanceof RegExp) {
                htmlPluginData.html = htmlPluginData.html.replace(option.pattern, option.replacement);
            } else {
                htmlPluginData.html = htmlPluginData.html.split(option.pattern).join(option.replacement);
            }
        } else {
            throw new Error(errorMassage);
        }

        callback(null, htmlPluginData)
    }
}

SpiderkitesWebpackPlugin.prototype.apply = function (compiler) {
    if (compiler.hooks) {
        compiler.hooks.compilation.tap('HtmlReplaceWebpackPlugin', compilation => {
            if (compilation.hooks.htmlWebpackPluginAfterHtmlProcessing) {
                compilation.hooks.htmlWebpackPluginAfterHtmlProcessing.tapAsync('HtmlReplaceWebpackPlugin', this.replace)
            } else {
                var HtmlWebpackPlugin = require('html-webpack-plugin')

                if (!HtmlWebpackPlugin) {
                    throw new Error(errorMassage)
                }

                HtmlWebpackPlugin.getHooks(compilation).beforeEmit.tapAsync('HtmlReplaceWebpackPlugin', this.replace)
            }
        })
    } else {
        compiler.plugin('compilation', compilation => {
            compilation.plugin('spiderkites-plugin-beforeEmit', this.replace)
        })
    }
}

module.exports = SpiderkitesWebpackPlugin
