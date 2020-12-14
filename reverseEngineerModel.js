const getTRs = (node) => {
    if(node[0].nodeName == 'TR') {
        return node;
    }
    if(node.children().length) {
        return getTRs(node.children());
    }
    return 0;
}
const getTDs = (node) => {
    if(node[0].nodeName == 'TD') {
        return node;
    }
    if(node.children().length) {
        return getTDs(node.children());
    }
    return 0;
}
const generateArray = (node) => {
    const trs = getTRs(node);
    const arr = [];
    trs.each((i1, tr) => {
        const tds = getTDs($(tr));
        arr.push([]);
        if(tds) {
            tds.each((i2, td) => {
                arr[i1].push($(td).text().trim());
            });
        }
    });
    return arr;
}