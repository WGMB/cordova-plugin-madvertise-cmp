package com.mngads.cordova;

import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import java.util.Locale;

import com.madvertise.cmp.manager.ConsentManager;
import com.madvertise.cmp.listener.ConsentManagerListener;
import com.madvertise.cmp.global.ConsentToolConfiguration;
import com.madvertise.cmp.listener.OnConsentProvidedListener;
import com.madvertise.cmp.listener.OnPrivacyPolicyRequestedListener;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;

import android.util.Log;

public class CDVMAdvertiseCmp extends CordovaPlugin {


    private CallbackContext mContentProvidedCallback;


    /**
     * This is the main method for the MNGAds plugin. All API calls go through
     * here. This method determines the action, and executes the appropriate
     * call.
     *
     * @param action          The action that the plugin should execute.
     * @param options         The input parameters for the action.
     * @param callbackContext The callback context.
     * @return returned if the action is recognized.
     */
    @Override
    public boolean execute(String action, JSONArray options,
                           CallbackContext callbackContext) {
        switch (action) {
            case "madvertisecmp_configure":
                configureCmpPopup(options);
                return true;
            case "madvertisecmp_configure_full_screen":
                configureCmpFullScreen(options);
                return true;
           case "madvertisecmp_content_provided_callback":
        mContentProvidedCallback = callbackContext;
                return true;
            case "madvertisecmp_show_consent_tool_popup":
                configureCmpPopup(options);
                ConsentManager.sharedInstance.setConsentToolClosed(false);
                ConsentManager.sharedInstance.openCMP(cordova.getActivity(), new OnConsentProvidedListener() {
            @Override
            public void consentProvided(String actionType) {
                mContentProvidedCallback.success();

            }

            @Override
            public void consentFailed( String error) { 

            }
        });
                return true;
            case "madvertisecmp_show_consent_tool_full_screen":
                configureCmpFullScreen(options);
                ConsentManager.sharedInstance.setConsentToolClosed(false);
                ConsentManager.sharedInstance.openCMP(cordova.getActivity(), new OnConsentProvidedListener() {
            @Override
            public void consentProvided(String actionType) {
                mContentProvidedCallback.success();

            }

            @Override
            public void consentFailed( String error) { 

            }
        });
                return true;
            case "madvertisecmp_get_consent_string":
                provideConsentString(callbackContext);
                return true;
            case "madvertisecmp_get_purposes":
                providePurposes(callbackContext);
                return true;
            case "madvertisecmp_get_external_purposes":
                provideExternalPurposes(callbackContext);
                return true;
            default:
                return false;
        }
    }

    private void provideConsentString(CallbackContext callbackContext){
        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(cordova.getActivity());
        JSONArray jsonArray = new JSONArray();
        jsonArray.put(preferences.getString("IABTCF_TCString", null));
        callbackContext.success(jsonArray);
    }

    private void providePurposes(CallbackContext callbackContext){
        JSONArray jsonArray = new JSONArray();
        jsonArray.put(ConsentManager.sharedInstance.getPurposesIDs(cordova.getActivity()));
        callbackContext.success(jsonArray);
    }

    
    private void provideExternalPurposes(CallbackContext callbackContext){
        JSONArray jsonArray = new JSONArray();
        jsonArray.put(ConsentManager.sharedInstance.getExternalPurposesIDs(cordova.getActivity()));
        callbackContext.success(jsonArray);
    }


/*
    private OnConsentProvidedListener getContentProvidedListener(CallbackContext callbackContext) {
        mContentProvidedCallback = callbackContext;
        return new OnConsentProvidedListener() {
            @Override
            public void consentProvided(String actionType) {
            }
        };
    }*/

    private void configureCmpPopup(JSONArray options) {

    int appId = options.optInt(0);
    String language = options.optString(1);
    String publisherCC = options.optString(2);  
    String resourceName = options.optString(3);

    int resID = cordova.getActivity()
                .getResources()
                .getIdentifier(resourceName, "raw", cordova.getActivity().getPackageName());
    ConsentManager.sharedInstance.configure(cordova.getActivity().getApplication(), appId,language, new ConsentToolConfiguration(resID),publisherCC);
   
  ConsentManager.sharedInstance.showCMP(cordova.getActivity(), new OnConsentProvidedListener() {
            @Override
            public void consentProvided(String actionType) {
                mContentProvidedCallback.success();

            }

            @Override
            public void consentFailed( String error) { 

            }
        });
    }


    private void configureCmpFullScreen(JSONArray options) {

     int appId = options.optInt(0);
    String language = options.optString(1);
    String publisherCC = options.optString(2);  
    String resourceName = options.optString(3);


    int resID = cordova.getActivity()
                .getResources()
                .getIdentifier(resourceName, "raw", cordova.getActivity().getPackageName());

     ConsentManager.sharedInstance.configure(cordova.getActivity().getApplication(), appId,language, new ConsentToolConfiguration(resID).setConsentToolSize(ConsentToolConfiguration.MATCH_PARENT, 
        ConsentToolConfiguration.MATCH_PARENT), publisherCC);
        ConsentManager.sharedInstance.showCMP(cordova.getActivity(), new OnConsentProvidedListener() {
            @Override
            public void consentProvided(String actionType) {
                mContentProvidedCallback.success();

            }

            @Override
            public void consentFailed( String error) { 

            }
        });

    }

}
