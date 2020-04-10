import download from './download/donwload.js';
import colorizer from './colorizer/colorizer.js';

document.addEventListener('DOMContentLoaded', init, false);


function init(){
    
    colorizer();

    window.fileDownload = function () {
        const kiteSvg = document.getElementById("kite-template");
        download("kite.svg", kiteSvg.innerHTML);
    }
}
