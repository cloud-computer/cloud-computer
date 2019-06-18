export default (log) => {
    return {
        info: (desc, body) => {
            console.log(log, desc);
            console.table(body);
        },
        debug: (desc, body) => {
            console.log(log, desc);
            console.table(body);
        },
        error: (desc, body) => {
            console.log(log, desc);
            console.table(body);
        }
    }
}