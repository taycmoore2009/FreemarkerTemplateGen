# FTL File generator
To start run `npm i`
* Update existing default ftl files to match your needs or create new files
* Update existing default models to match your needs or create new files
* Run `npm start`
* Generated html files are found in  outputs folder

## Accepted arguments in npm start
npm start `ftl template location` `model location` `language select` `output location`

example: `npm start templates/customTemplate.ftl models/customModel.json en outputs/customResponse.html`

### Issues
If freemarker is not running, you either need to set your envorment variables to include the java library, or need to install Java 8 over existing version
