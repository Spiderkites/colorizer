

const { ipcMain, dialog } = require("electron");
const path = require("path");


const { copyfile } = require('./handleFileActions');
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

                await copyfile(dialogResponse.filePaths[0], type);
                this.window.focusOnWebView();

                event.sender.send('file-uploaded', type, dialogResponse.filePaths[0]);
            }
        })
    }

    _onGenerate() {
        ipcMain.on('generate', async (event, productPath, colorPath) => {

            try {
                await copyfile(productPath, 'product');
                await copyfile(colorPath, 'color');

                await executeScript( path.join(__dirname, 'test.bat'));
                
                this.window.focusOnWebView();
                event.sender.send('generated');

            } catch (e) {
                event.sender.send('generate-error');
            }
        })
    }
}

module.exports = ips;




