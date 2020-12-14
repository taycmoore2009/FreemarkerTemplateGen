const generateFreemarker = require('./generateFreemarker.js');
const fs = require('fs');
/**
 * Add this to additionalFileFunctions to get completed template in completedFile.ftl
 * @param {String} templateToParse 
 */
const getCompletedTemplate = function(templateToParse){
    var javaFunction = templateToParse.match(/<#function getMessageProperty([\s\S]*?)#function>/gi);
    templateToParse = templateToParse.replace(javaFunction, '');
    fs.writeFileSync('outputs/completedFile.ftl', templateToParse);
}
/**
 * Add this to additionalFileFunctions to generate file for debuggin
 * @param {String} template
 */
const generateDebugTemplate = function(file){
    fs.writeFileSync('outputs/debugTemplate.ftl', file);
}

const params = process.argv.slice(2);
/**
 * @param {JSON} model // JSON opbject that's supplied to freemarker template
 * @param {String} file // File with freemarker template. Can use include to attach multiple templates together
 * @param {Array} additionalFileFunctions // List of functions to alter freemarker template before being processed. 
 *                                           If the function returns a string, the string returned will become the template
 */
var options = {
    file: params[0] || 'templates/defaultEmailTemplate.ftl',
    model: JSON.parse(fs.readFileSync(params[1] || 'models/defaultModel.json', 'utf8')),
    messages: params[2] || 'en',
    outputs: params[3] || 'outputs/emailOutput.html',
    additionalFileFunctions: [generateDebugTemplate]
}

generateFreemarker(options);
