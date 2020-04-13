const { ipcMain, dialog } = require("electron");
const path = require("path");


const { readFile } = require('./handleFileActions');
const executeScript = require('./executeScript');


class ips {
    constructor(_window) {
        this.window = _window;
        this._onFileUpload();
        this._onGenerate();

    }

    _onFileUpload() {
        ipcMain.on('file-upload', async (event, type) => {
            const dialogResponse = await dialog.showOpenDialog(
                {
                    properties: ['openFile'],
                    filters: [
                        { name: 'svg', extensions: ['svg'] }
                    ]
                }
            );

            if (!dialogResponse.canceled) {

                this.window.focusOnWebView();

                event.sender.send('file-uploaded', type, dialogResponse.filePaths[0]);
            }
        })
    }

    _onGenerate() {
        ipcMain.on('generate', async (event, productPath, colorPath) => {

            try {
                this.window.focusOnWebView();

                const productSvg = await readFile(productPath);
                console.log(productSvg);
                const colorSvg = await readFile(colorPath);
                console.log(colorSvg);
                const template = await readFile(path.join(__dirname, '../templates/wawi_colorizer.html'));
                console.log(template);

                let replacedTemplate = template.replace('<%= require("./../../svg/product.svg") %>', productSvg)
                    .replace('<%= require("./../../svg/color.svg") %>', colorSvg)

                    console.log(replacedTemplate);

                event.sender.send('generated', replacedTemplate);

            } catch (e) {
                event.sender.send('generate-error');
            }
        })
    }
}

module.exports = ips;




