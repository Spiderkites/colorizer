import Colorizer from './colorizer/colorizer.js';
import i18n from './i18n/i18n';

const maxRetries = 10;
let retry = 0;



window.initColorizer = function (urlProductSVG, urlColorSVG){

    const _i18n = new i18n();
    new Colorizer(urlProductSVG, urlColorSVG, _i18n)
}
