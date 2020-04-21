import Colorizer from './colorizer/colorizer.js';

const inter = setInterval(() => {
    const isLoaded = !!document.getElementById('spiderkites-colorizer');

    //implement max retries

    if (isLoaded) {
        clearInterval(inter);
        init();
    }
}, 250);


function init() {
    new Colorizer(PRODUCTION);
}
