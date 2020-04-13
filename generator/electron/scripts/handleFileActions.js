
const fs = require("fs");
const path = require("path");

const { promisify } = require("util");

const copyFile = promisify(fs.copyFile);


exports.copyfile = async (src, type) => {

    await copyFile(src,  path.join(__dirname, `/../../../colorizer/svg/${type}.svg`));
}