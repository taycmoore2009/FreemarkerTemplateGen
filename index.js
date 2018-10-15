const generateFreemarker = require('./generateFreemarker.js');
const fs = require('fs');
/**
 * Add this to additionalFileFunctions to get completed template in completedFile.ftl
 * @param {String} templateToParse 
 */
const getCompletedTemplate = function(templateToParse){
    var javaFunction = templateToParse.match(/<#function getMessageProperty([\s\S]*?)#function>/gi);
    templateToParse = templateToParse.replace(javaFunction, '');
    fs.writeFileSync('completedFile.ftl', templateToParse);
}
/**
 * Add this to additionalFileFunctions to generate file for debuggin
 * @param {String} template
 */
const generateDebugTemplate = function(file){
    fs.writeFileSync('debugTemplate.ftl', file);
}

/**
 * @param {JSON} model // JSON opbject that's supplied to freemarker template
 * @param {String} file // File with freemarker template. Can use include to attach multiple templates together
 * @param {Array} additionalFileFunctions // List of functions to alter freemarker template before being processed. 
 *                                           If the function returns a string, the string returned will become the template
 */
var options = {
    model: JSON.parse(fs.readFileSync('model.json', 'utf8')),
    file: 'templates/EmailFormat_ExpApprovalDefault_html.ftl',
    messages: 'en',
    additionalFileFunctions: [generateDebugTemplate]
}

generateFreemarker(options);
