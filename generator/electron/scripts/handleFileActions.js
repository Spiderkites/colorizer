
const fs = require("fs");
const path = require("path");

const { promisify } = require("util");

const readFile = promisify(fs.readFile);


exports.readFile = async (src) => {
    const file = await readFile(src)
    return file.toString('utf8');
}