import Colorizer from './colorizer/colorizer.js';
import i18n from './i18n/i18n';

const maxRetries = 10;
let retry = 0;

const interval = setInterval(() => {
    const isLoaded = !!document.getElementById('spiderkites-colorizer');
    if (isLoaded) {
        window.initColorizer();
    } else if (retry >= maxRetries) {
        clearInterval(interval);
    } else {
        retry++;
    }

}, 50);

window.initColorizer = function (){
    clearInterval(interval);
    const _i18n = new i18n();
    new Colorizer(PRODUCTION, _i18n)
}


$('#myModal').on('shown.bs.modal', function () {
    console.log("fsdsdg");
    $('#myInput').focus()
  })
