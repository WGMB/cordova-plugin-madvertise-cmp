/*!
 *  @header    CDVMngAdsSDK.m
 *  @abstract  Cordova Plugin for the Mng Ads iOS SDK.
 *  @version   1.0.10
 */

//  Created by Hussein Dimessi on 03/01/2019.
//  Copyright © 2018 MAdvertise. All rights reserved.
//  Cordova

#import "CDVMAdvertiseCMP.h"
#import <Cordova/CDVViewController.h>

@implementation CDVMAdvertiseCMP{
    NSString* showCTCallbackId;
    NSString* consentStringChangedCallbackId;
    BOOL isFullScreen;
}

- (void)pluginInitialize {
    [super pluginInitialize];
}
- (void)configure:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    NSString *appId = [arguments objectAtIndex:0];
    NSString *language = [arguments objectAtIndex:1];
    NSString *publisherCC = [arguments objectAtIndex:2];
    NSString *configFileName = [arguments objectAtIndex:3];

    CMPLanguage *cmpLanguage = [[CMPLanguage alloc]initWithString:language];
    [CMPConsentManager.sharedInstance configure:configFileName language:cmpLanguage appId:appId publisherCC:publisherCC];
}

- (void)madvertisecmp_configure:(CDVInvokedUrlCommand *)command{
    isFullScreen  = NO ;
    [self configure:command];


}
- (void)madvertisecmp_configure_full_screen:(CDVInvokedUrlCommand *)command{
    isFullScreen = YES;
    [self configure:command];


}
- (void)madvertisecmp_consent_manager_callback:(CDVInvokedUrlCommand *)command{
    CMPConsentManager.sharedInstance.delegate = self;
    showCTCallbackId = command.callbackId;
}
- (void)madvertisecmp_content_provided_callback:(CDVInvokedUrlCommand *)command{
    CMPConsentManager.sharedInstance.delegate = self;
    consentStringChangedCallbackId = command.callbackId;
}
- (void)madvertisecmp_show_consent_tool_popup:(CDVInvokedUrlCommand *)command{
    if ([command.arguments count] > 0 ) {
        BOOL isPopup = [command.arguments objectAtIndex:0];

        if (isPopup == true ) {
            if ([CMPConsentManager.sharedInstance  showConsentToolFromController:[self viewController] withPopup:YES]) {}
        } else {
            if ([CMPConsentManager.sharedInstance  showConsentToolFromController:[self viewController] withPopup:NO]){}
        }
    }else{
        if(  [CMPConsentManager.sharedInstance showConsentToolFromController:[self viewController] withPopup:NO]){}
    }
}
- (void)madvertisecmp_show_consent_tool_full_screen:(CDVInvokedUrlCommand *)command{
    if ([CMPConsentManager.sharedInstance  showConsentToolFromController:[self viewController] withPopup:NO]){}
}
- (void)madvertisecmp_get_consent_string:(CDVInvokedUrlCommand *)command{
    NSString *IABTCF_TCString = [NSUserDefaults.standardUserDefaults objectForKey:@"IABTCF_TCString"];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:IABTCF_TCString];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)madvertisecmp_get_subject_to_gdpr:(CDVInvokedUrlCommand *)command{
    NSArray *arguments = command.arguments;
    BOOL subjectToGDPR = [arguments objectAtIndex:0];
    CMPConsentManager.sharedInstance.subjectToGDPR = subjectToGDPR;
}
- (void)madvertisecmp_get_purposes:(CDVInvokedUrlCommand *)command{
    NSArray * purposeIDs =    [CMPConsentManager.sharedInstance getPurposesIDs];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:purposeIDs];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)madvertisecmp_get_external_purposes:(CDVInvokedUrlCommand *)command{
    NSArray * purposeIDs =    [CMPConsentManager.sharedInstance getExternalPurposesIDs];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:purposeIDs];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

// MARK: - CMPConsentManagerDelegate

- (void)consentManagerRequestsToShowConsentTool:(CMPConsentManager * _Nonnull)consentManager forVendorList:(CMPVendorList * _Nonnull)vendorList {
    if (isFullScreen) {
        if ([CMPConsentManager.sharedInstance showConsentToolFromController:[self viewController] withPopup:NO]) {
            NSLog(@"------> Consent showConsentToolWithLocationFromController ");
        }
    } else {
        if ([CMPConsentManager.sharedInstance showConsentToolFromController:[self viewController] withPopup:YES]) {
            NSLog(@"------> Consent showConsentToolWithLocationFromController ");
        }
    }

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Requests To Show Consent Tool"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:showCTCallbackId];

}

-(void)tcfOnConsentStringDidChange:(TCFString *)newTcfConsentString consentProvided:(NSString *)consentProvided{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"TCFString Did Change"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:consentStringChangedCallbackId];
}



- (void)madvertisecmp_set_subject_to_gdpr:(CDVInvokedUrlCommand *)command {
    NSArray *arguments = command.arguments;
    BOOL subjectToGDPR = [arguments objectAtIndex:0];
    CMPConsentManager.sharedInstance.subjectToGDPR = subjectToGDPR;
}
- (void)madvertisecmp_get_cmp_present:(CDVInvokedUrlCommand *)command {
    BOOL cmpPresent = [NSUserDefaults.standardUserDefaults boolForKey:@"IABConsent_CMPPresent"];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:cmpPresent];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



@end
