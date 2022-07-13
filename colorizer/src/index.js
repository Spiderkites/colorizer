import Colorizer from './colorizer/colorizer.js';
import i18n from './i18n/i18n';


window.initColorizer = function (urlProductSVG, urlColorSVG) {

    const _i18n = new i18n();
    new Colorizer(urlProductSVG, urlColorSVG, _i18n)

}

String.prototype.hashCode = function () {
    var hash = 0, i, chr;
    if (this.length === 0) return hash;
    for (i = 0; i < this.length; i++) {
        chr = this.charCodeAt(i);
        hash = ((hash << 5) - hash) + chr;
        hash |= 0; // Convert to 32bit integer
    }
    return hash;
};
