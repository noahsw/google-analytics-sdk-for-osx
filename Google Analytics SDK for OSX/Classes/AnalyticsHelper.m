//
//  AnalyticsHelper.m
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/27/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

#import "AnalyticsHelper.h"
#import "GoogleEvent.h"
#import "TrackingRequest.h"
#import "GoogleTracking.h"
#import "TrackingRequest.h"
#import "RequestFactory.h"

#import "DDLog.h"
#import "DDTTYLogger.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE | LOG_LEVEL_INFO | LOG_LEVEL_ERROR | LOG_LEVEL_WARN;

static NSOperationQueue* operationQueue;


@implementation AnalyticsHelper

@synthesize domainName;
@synthesize analyticsAccountCode;

-(id)init
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    return self;
}


-(BOOL) fireEvent: (NSString*)eventAction eventValue:(NSNumber*)eventValue
{
    
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* eventCategory = [NSString stringWithFormat:@"Mac %@", infoDict[@"CFBundleShortVersionString"]];
    
    NSString* eventLabel = @"empty";
    NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        NSString* userUUID = [standardUserDefaults stringForKey:@"UserUUID"];
        if ([userUUID length] == 0)
        { // generate one for the first time
            userUUID = [AnalyticsHelper UUIDString];
            [standardUserDefaults setObject:userUUID forKey:@"UserUUID"];
            [standardUserDefaults synchronize];
        }
        
        eventLabel = userUUID;
    }
    
    DDLogInfo(@"%@, %@, %@, %@", eventCategory, eventAction, eventLabel, eventValue);
    
    GoogleEvent* googleEvent = [[GoogleEvent alloc] initWithParams:self.domainName category:eventCategory action:eventAction label:eventLabel value:eventValue];
    
    if (googleEvent != nil)
    {
        RequestFactory* requestFactory = [RequestFactory new];
        TrackingRequest* request = [requestFactory buildRequest:googleEvent analyticsAccountCode:self.analyticsAccountCode];
        
        if (operationQueue == nil)
        {
            operationQueue = [NSOperationQueue new];
            operationQueue.maxConcurrentOperationCount = 1;
        }
        
        GoogleTracking* trackingOperation = [GoogleTracking new];
        trackingOperation.request = request;
        
        [operationQueue addOperation:trackingOperation];
        
    }
    
    return YES;
    
}



+(NSString*)UUIDString
{
    CFUUIDRef  uuidObj = CFUUIDCreate(nil);
    NSString  *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}



@end
