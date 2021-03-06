const { ipcMain, dialog } = require("electron");
const path = require("path");

const { readFile } = require('./handleFileActions');

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
            } else {
                event.sender.send('filechooser-canceld');
            }
        })
    }

    _onGenerate() {
        ipcMain.on('generate', async (event, productPath, colorPath) => {

            try {
                this.window.focusOnWebView();

                let productSvg = await readFile(productPath);
                const colorSvg = await readFile(colorPath);
                const template = await readFile(path.join(__dirname, '../templates/wawi_colorizer.html'));

                let replacedTemplate = template.replace('<%= require("./../../svg/product.svg") %>', productSvg)
                    .replace('<%= require("./../../svg/color.svg") %>', colorSvg)
                    .replace('uuid="UUID-Development"', `uuid="${this._uuidv4()}"`);


                event.sender.send('generate-finished', replacedTemplate);

            } catch (e) {
                event.sender.send('generate-error', e);
            }
        })
    }

    _uuidv4() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }
}

module.exports = ips;




