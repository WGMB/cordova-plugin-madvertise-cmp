# BlueStack CMP - Cordova Plugin

[TOC]

The BlueStack CMP cordova plugin is an extension to the original BlueStack CMP Framework that exposes a Javascript API for the native functionalities such as configuration methods and extraction of the user's saved preferences.


## Prerequisites

**For Android : Init cordova-plugin-androidx**

Make sure you have this plugin included in your project.

```xml
cordova plugin add cordova-plugin-androidx

```

## Integration Guide

### Step 1: Prepare the configuration file 

- Download or clone the [BlueStack CMP Cordova Plugin](https://bitbucket.org/mngcorp/madvertise-gdpr-cmp-cordova-plugin/src/master/) repository.

- Before you add the plugin to your cordova project you might want to create your own configuration file. 

- For a better understanding of the the configuration file's role, take a look at the [BlueStack CMP Configuration File](https://bitbucket.org/mngcorp/madvertise-gdpr-cmp-android/wiki/cmp_configuration.md).
 
- You can also choose one of the pre-configured files that you can already find in the plugin's resources folder *src/android/resources*
Either way, make sure that the file is added to the plugin.xml before adding the plugin.

For example :

```xml
<resource-file src="src/android/resources/madvertise_config_en.json" target="/res/raw/madvertise_config_en.json" />

```

### Step 2: Adding BlueStack CMP Plugin

1. Open your command line tool and navigate to your existing cordova project's directory.

2. Add the MAdvertise CMP cordova plugin with the following command :

```bash
cordova plugin add PATH_TO_MADVERTISE_CMP_CORDOVA/madvertise-gdpr-cmp-cordova-plugin
```

### Step 3: Initialize the BlueStack CMP Plugin

- First you have to create an instance of the BlueStack CMP : 

```javaScript
this.madvertisecmp = new MAdvertiseCmp();
```

- You have to init configure :

```javaScript
this.madvertisecmp.configure(YOUR_APP_ID, YOUR_PREFERRED_LANG,YOUR_CONFIG_FILE_NAME,YOUR_PUBLISHER_CC);
```

- The configure method takes the following parameters:
	- the App Id of your application.
	- the language you want to show CMP with it((Two-letter) like "fr","en","it"....)
	- the publisherCC value (corresponds to the country code (Two-letter) of the country in which the publisher's business entity is established like "FR", "DE", "IT"...).
	- the configuration file name.

*Here's an example:*

```javaScript
this.madvertisecmp = new MAdvertiseCmp(); 
this.madvertisecmp.configure(5180317,'de','DE','madvertise_config_de');
```

	
## Advanced Topics

### Show CMP in Fullscreen Mode

You can use a fullscreen page instead of a Popup, you need to init configure with following method :


```javaScript
this.madvertisecmp.configureCmpFullScreen(YOUR_APP_ID, YOUR_PREFERRED_LANG,YOUR_CONFIG_FILE_NAME,YOUR_PUBLISHER_CC);
```


*Here's an example:*

```javaScript
this.madvertisecmp = new MAdvertiseCmp(); 
this.madvertisecmp.configureCmpFullScreen(5180317,'de','DE','madvertise_config_de');
```
___

### Check the availability of user consent


This listener is called when the user provides his consent by clicking the accept,refuse or the save button.

```javaScript
this.madvertisecmp.setContentProvidedListener(contentProvidedCallback);
```

___

### Get user's consent 

To collect user's consent , you can use the method :

```javaScript
this.madvertisecmp.getConsentString(valueCallback);
```

*Here's an example:*

```javaScript
onConsentProvided: function(){
	app.madvertisecmp.getConsentString(app.displayConsentString);
},

displayConsentString: function (consent){
	document.getElementById("consentStatus").innerHTML = consent;
}
```
___

### Get Purposes IDs

To collect purposes IDs (IABTCF_PurposeConsents) , you can use the method :

```javaScript
this.madvertisecmp.getPurposesIDs(valueCallback);
```

*Here's an example:*

```javaScript
onConsentProvided: function(){
	app.madvertisecmp.getPurposesIDs(app.displayPurposesIDs);
},

displayPurposesIDs: function (consent){
	document.getElementById("purposes").innerHTML = consent;
}
```
___

### Get External Purposes IDs

To collect external purposes IDs, you can use the method :

```javaScript
this.madvertisecmp.getExternalPurposesIDs(valueCallback);
```

*Here's an example:*

```javaScript
onConsentProvided: function(){
	app.madvertisecmp.getExternalPurposesIDs(app.displayExternalPurposesIDs);
},

displayExternalPurposesIDs: function (consent){
	document.getElementById("externalPurposes").innerHTML = consent;
}
```
___


### Show BlueStack CMP Manually

**Fullscreen Mode**

To show BlueStack CMP in fullscreen Mode , you can use the method :

```javaScript
this.madvertisecmp.showConsentToolFullScreen(YOUR_APP_ID, YOUR_PREFERRED_LANG,YOUR_CONFIG_FILE_NAME,YOUR_PUBLISHER_CC);

```

**Popup Mode**

To show BlueStack CMP in popup Mode , you can use the method :

```javaScript
this.madvertisecmp.showConsentToolPopup(YOUR_APP_ID, YOUR_PREFERRED_LANG,YOUR_CONFIG_FILE_NAME,YOUR_PUBLISHER_CC);

```