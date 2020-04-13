const { app, BrowserWindow, Menu } = require("electron");
const path = require("path");
const url = require("url");

const ips = require('./scripts/ips');

let win;

function createWindow() {
  win = new BrowserWindow({
    width: 1200,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
      backgroundThrottling: false
    }
  });

  new ips(win);

  win.loadURL(
    url.format({
      pathname: path.join(__dirname, `/../dist/generator/index.html`),
      protocol: "file:",
      slashes: true
    })
  );

  win.webContents.openDevTools();

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
  Menu.setApplicationMenu(false);
  if (win === null) {
    createWindow();
  }
});



