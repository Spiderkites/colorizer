import download from './download/donwload.js';
import colorizer from './colorizer/colorizer.js';

//document.addEventListener('DOMContentLoaded', init, false);

const inter = setInterval(()=> {
    const isLoaded = !!document.getElementById('spiderkites-colorizer');

    if(isLoaded){
        clearInterval(inter);
        init();
    }
}, 250);


function init(){
    
    colorizer();

    window.fileDownload = function () {
        const kiteSvg = document.getElementById("kite-template");
        download("kite.svg", kiteSvg.innerHTML);
    }
}
