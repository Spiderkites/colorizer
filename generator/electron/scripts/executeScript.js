module.exports = (scriptPath) => {

    return new Promise((resolve, reject) => {
        const process = require('child_process');

        var child = process.spawn('test.bat');

        child.on('error', function (err) {
            console.log('stderr: <' + err + '>');
        });

        child.stdout.on('data', function (data) {
            console.log(data.toString('utf8'));
        });

        child.stderr.on('data', function (data) {
            console.log('stderr: <' + data.toString('utf8') + '>');
        });

        child.on('close', function (code) {
            if (code == 0) {
                console.log('child process complete.');
                resolve();
            } else {
                console.log('child process exited with code ' + code);
                reject(code);
            }
        });
    })

}