const { app, BrowserWindow, Menu } = require("electron");
const path = require("path");
const url = require("url");

const ips = require('./scripts/ips');

let win;

Menu.setApplicationMenu(false);

function createWindow() {
  win = new BrowserWindow({
    width: 700,
    height: 800,
    webPreferences: {
      nodeIntegration: true,
      backgroundThrottling: false
    }
  });

  new ips(win);

  win.loadURL(
    url.format({
      pathname: path.join(__dirname, `/dist/index.html`),
      protocol: "file:",
      slashes: true
    })
  );

  // win.webContents.openDevTools();

  win.on("closed", () => {
    win = null;
  });
}

app.on("ready", createWindow);

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});

app.on("activate", () => {
  if (win === null) {
    createWindow();
  }
});



