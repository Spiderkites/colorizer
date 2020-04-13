const { app, BrowserWindow, ipcMain, Menu, dialog } = require("electron");
const path = require("path");
const url = require("url");

let win;
Menu.setApplicationMenu(false);


function createWindow() {
  win = new BrowserWindow({
    width: 1200,
    height: 600,
    webPreferences: {
      nodeIntegration: true, // makes it possible to use `require` within our index.html
      backgroundThrottling: false
    }
  });

  win.webContents.openDevTools();

  // load the dist folder from Angular
  win.loadURL(
    url.format({
      pathname: path.join(__dirname, `/dist/generator/index.html`),
      protocol: "file:",
      slashes: true
    })
  );

  // The following is optional and will open the DevTools:
  // win.webContents.openDevTools()

  win.on("closed", () => {
    win = null;
  });
}

app.on("ready", createWindow);

// on macOS, closing the window doesn't quit the app
app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});

// initialize the app's main window
app.on("activate", () => {
  if (win === null) {
    createWindow();
  }
});



const fs = require("fs");
const { promisify } = require("util");

const readFile = promisify(fs.readFile);

//https://stackoverflow.com/questions/42932129/how-to-use-filesystem-fs-in-angular-cli-with-electron-js
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
    win.focusOnWebView();

    executeScript();

    event.sender.send('file-uploaded', type, dialogResponse.filePaths[0]);
  }

})

function executeScript(){
  const process = require('child_process');

  var child = process.spawn('test.bat'); 

  child.on('error', function(err) {
    console.log('stderr: <'+err+'>' );
  });

  child.stdout.on('data', function (data) {
    console.log(data.toString('utf8'));
  });

  child.stderr.on('data', function (data) {
    console.log('stderr: <'+data.toString('utf8')+'>' );
  });

  child.on('close', function (code) {
      if (code == 0)
        console.log('child process complete.');
      else
      console.log('child process exited with code ' + code);
  });
}