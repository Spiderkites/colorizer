import Colorizer from './colorizer/colorizer.js';
import i18n from './i18n/i18n';

const maxRetries = 10;
let retry = 0;

const interval = setInterval(() => {
    const isLoaded = !!document.getElementById('spiderkites-colorizer');

    if (isLoaded) {
        clearInterval(interval);
        init();
    } else if (retry >= maxRetries) {
        clearInterval(interval);
    } else {
        retry++;
    }

}, 50);


function init() {
    new i18n();
    new Colorizer(PRODUCTION);
}
