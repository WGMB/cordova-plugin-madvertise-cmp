/*!
 *  @header    CDVMngAdsSDK.h
 *  @abstract  Cordova Plugin for the MAdvertise CMP iOS SDK.
 *  @version   1.0.10
 */

//  Created by Hussein Dimessi on 03/01/2019.
//  Copyright © 2018 MAdvertise. All rights reserved.
// Cordova
#import <Cordova/CDVPlugin.h>

#import <MAdvertiseCMP/MAdvertiseCMP-Swift.h>


@interface CDVMAdvertiseCMP : CDVPlugin<CMPConsentManagerDelegate>

- (void)madvertisecmp_configure:(CDVInvokedUrlCommand *)command;
- (void)madvertisecmp_configure_full_screen:(CDVInvokedUrlCommand *)command;
- (void)madvertisecmp_consent_manager_callback:(CDVInvokedUrlCommand *)command;
- (void)madvertisecmp_content_provided_callback:(CDVInvokedUrlCommand *)command;
- (void)madvertisecmp_show_consent_tool_popup:(CDVInvokedUrlCommand *)command;
- (void)madvertisecmp_show_consent_tool_full_screen:(CDVInvokedUrlCommand *)command;
- (void)madvertisecmp_get_consent_string:(CDVInvokedUrlCommand *)command;
- (void)madvertisecmp_get_subject_to_gdpr:(CDVInvokedUrlCommand *)command;
- (void)madvertisecmp_get_purposes:(CDVInvokedUrlCommand *)command;
- (void)madvertisecmp_get_external_purposes:(CDVInvokedUrlCommand *)command;

@end
