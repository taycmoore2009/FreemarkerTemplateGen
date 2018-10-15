const Freemarker = require('freemarker');
const fs = require('fs');
const freemarker = new Freemarker();

/**
 * Go through string and add additional files
 * @param {String} fileStr 
 * @returns {String}
 */
function getIncludedFiles(fileStr){
  var includes = fileStr.match(/(<#include)(.*)(>)/gi);

  if(includes && includes.length){
    filesNames = includes.forEach(function(match){
      var fileName = match.replace(' ', '').replace(/(<#include)|"|'|>/gi, '');
      var file = fs.readFileSync(fileName, 'utf8');
      file = getIncludedFiles(file);

      fileStr = fileStr.replace(match, file);
    });

  }

  return fileStr;
}

/**
 * Adds functions that are found in the Java version stored on backend
 * @param {String} fileStr 
 */
function addJavaFunctions(fileStr){
  return `
    <#function getMessageProperty var>
      <#if messages?has_content>
          <#list messages as message>
              <#if message[0] == var>
                  <#return message[1]>
              </#if>
          </#list>
          <#return var?replace("_", " ")>
      <#else>
          <#return label?replace("_", " ")>
      </#if>
    </#function>
  `+ fileStr;
}

/**
 * Convert messages from file into array and add to model
 * @param {String} messagesLanguage // Current language
 * @param {Object} model // Current model for freemarker
 */
function parseMessages(messagesLanguage, model){
  var messages = "",
      messagesArray = [],
      messagesObj = {},
      processedArray = [],
      messagesLang = "",
      messagesLangArray = [],
      messagesLangObj = {};

  // Get global language object
  messages = fs.readFileSync('messages/messages.properties', 'utf8');
  messagesArray = messages.split('\n');
  
  // Check for language
  if(messagesLanguage){
    // Generate local language object
    messagesLang = fs.readFileSync('messages/messages_'+ messagesLanguage +'.properties', 'utf8');
    messagesLangArray = messagesLang.split("\n");
    messagesLangArray.forEach(function(message){
      messagesLangObj[message.split("=")[0]] = message.split("=")[1];
    });

    // Generate global language object
    messagesArray.forEach(function(message){
      messagesObj[message.split("=")[0]] = message.split("=")[1];
    });


    // Assign local langauge object before global langauge object
    messagesObj = Object.assign(messagesObj, messagesLangObj);

    // Generate processedArray
    for(var key in messagesObj){
      processedArray.push([key, messagesObj[key]]);
    }
  } else {
    // Generate processedArray
    processedArray = messagesArray.map(function(message){
      return [message.split('=')[0], message.split('=')[1]];
    });
  }
  
  // Add messages to model
  model.messages = processedArray;
  return model;
}

/**
 * Reads .ftl file and generates an email from model supplied
 * @param {String} file 
 * @param {JSON} model 
 */
module.exports = function(options){

  // Set Variables
  var {file, model, messages, additionalFileFunctions} = options;
  var freemarkerFile = fs.readFileSync(file, 'utf8');

  // Get message labels
  model = parseMessages(messages, model);
  // Merge any necessary files
  freemarkerFile = getIncludedFiles(freemarkerFile);
  // Add special java functions
  freemarkerFile = addJavaFunctions(freemarkerFile);

  // Run any additional functions from array
  if(additionalFileFunctions){
    additionalFileFunctions.forEach(function(func){
      var resp = func(freemarkerFile);
      if(resp){
        freemarkerFile = resp;
      }
    });
  }

  // Render Template
  freemarker.render(freemarkerFile, model, (err, result) => {
    if (err) {
      throw new Error(err);
    }
    fs.writeFileSync("emailOutput.html", result);
  });
}