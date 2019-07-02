const fs = require('fs');
const { spawn } = require('child_process')

// const child = spawn('./test-scripts/test.sh');
// child.stdout.on('data', data => {
//     console.log(data.toString());
//     fs.appendFileSync('./logs/test', data);
// });
// child.stderr.on('data', data => {
//     console.log(data.toString());
//     fs.appendFileSync('./logs/test', data);
// });
//
// child.on('close',(code)=>{
//     console.log(code);
// })
const stop = '1c';
const decimalValue = parseInt(stop, 16); // Base 16 or hexadecimal
const character = String.fromCharCode(decimalValue);
fs.appendFileSync('./logs/test', character);

