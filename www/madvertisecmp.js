var argscheck = require('cordova/argscheck'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec');

var MAdvertiseCmp = function () {
    this.serviceName = "MAdvertiseCmp";
};

MAdvertiseCmp.prototype.configure = function (id, language,publisher,resource) {
    exec(null, null, this.serviceName, 'madvertisecmp_configure', [id,language,publisher,resource]);
}


MAdvertiseCmp.prototype.configureCmpFullScreen = function (id, language,publisher,resource) {
    exec(null, null, this.serviceName, 'madvertisecmp_configure_full_screen', [id,language,publisher,resource]);
}

MAdvertiseCmp.prototype.setContentProvidedListener = function(contentProvidedCallback){
    exec(contentProvidedCallback, null, this.serviceName, 'madvertisecmp_content_provided_callback', []);
}

MAdvertiseCmp.prototype.getConsentString = function(valueCallback){
    exec(valueCallback, null, this.serviceName, 'madvertisecmp_get_consent_string', []);
}

MAdvertiseCmp.prototype.getPurposesIDs = function(valueCallback){
    exec(valueCallback, null, this.serviceName, 'madvertisecmp_get_purposes', []);
}


MAdvertiseCmp.prototype.getExternalPurposesIDs = function(valueCallback){
    exec(valueCallback, null, this.serviceName, 'madvertisecmp_get_external_purposes', []);
}

MAdvertiseCmp.prototype.showConsentToolPopup = function(id, language,publisher,resource){
    exec(null, null, this.serviceName, "madvertisecmp_show_consent_tool_popup", [id,language,publisher,resource]);
}

MAdvertiseCmp.prototype.showConsentToolFullScreen = function(id, language,publisher,resource){
    exec(null, null, this.serviceName, "madvertisecmp_show_consent_tool_full_screen",[id,language,publisher,resource]);
}

module.exports = MAdvertiseCmp;
