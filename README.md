google-analytics-sdk-for-osx
============================

This unofficial SDK allows you to track usage of your OS X applications. Google built an Analytics SDK for iOS and Android but hasn't yet built one for desktop apps. As far as I can tell, we are not violating **(Google's Terms of Service)[http://www.google.com/analytics/terms/us.html]**.


Instructions
------------
1. Build the framework so you have a Google Analytics SDK for OSX.framework file in the Products folder of the SDK project
2. Switch to your app project and go to the Build Phases tab
3. Click the + button on the Link Binary with Libraries section
4. Select the Google Analytics SDK for OSX.framework
5. See the Sample Project for how to initialize and setup the framework in your app (/Sample Project/Sample Project/AppDelegate.m)


Credits
-------
Implementation ported from **(Doug Rathbone's Ga.net)[https://github.com/dougrathbone/Ga.net]**


Dependencies
------------
* **(CocoaLumberjack)[https://github.com/robbiehanson/CocoaLumberjack]**
