//
//  GoogleMeasurementProtocolEvent.m
//  Google Analytics SDK for OSX
//
//  Created by Jerry Tian on 3/25/13.
//  Copyright (c) 2013 Noah Spitzer-Williams. All rights reserved.
//

#import "GoogleUniversalTracking.h"
#import "PublicIP.h"
#import "JFUrlUtil.h"

#import "DDLog.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE | LOG_LEVEL_INFO | LOG_LEVEL_ERROR | LOG_LEVEL_WARN;

@implementation GoogleUniversalTracking


- (void) main {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(main) withObject:nil waitUntilDone:NO];
        return;
    }
    
    [NSThread setThreadPriority:0.1];
    [NSThread sleepForTimeInterval:1];
    
    NSString* analyticsAccountCode = nil;
    NSBundle* mainBundle = [NSBundle mainBundle];
#if DEBUG
    analyticsAccountCode = [mainBundle objectForInfoDictionaryKey:@"Google Analytics ID (Debug)"];
#else
    analyticsAccountCode = [mainBundle objectForInfoDictionaryKey:@"Google Analytics ID (Release)"];
#endif
    
    NSAssert(analyticsAccountCode!=nil, @"analyticsAccountCode can not be nil, set it in your info.plist.");
    
    //the origin author using the fields this way:
    //label => client UUID
    //category => client version
    //action => event name
    //value => event value(number)
    GoogleEvent * event = self.request.trackingEvent;
    
    
    GoogleEvent* trackingEvent = [self.request trackingEvent];
    //see "Event tracking para":
    //https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide
    NSString * payload = [NSString stringWithFormat:@"v=1&tid=%@&cid=%@&t=event&ec=%@&ea=%@&el=%@&ev=%@",
                          analyticsAccountCode,
                          [JFUrlUtil encodeUrl:event.label],
                          [JFUrlUtil encodeUrl:event.category],
                          [JFUrlUtil encodeUrl:event.action],
                          @"",
                          event.val
                          ];
    
    
    
    
    @try {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: @"http://www.google-analytics.com/collect"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:[payload dataUsingEncoding: NSUTF8StringEncoding]];
        NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
        
        if (returnData && [returnData length] > 0)
            DDLogInfo(@"Analytics event (%@, %@, %@, %@): triggered successfully!", [trackingEvent category], [trackingEvent action], [trackingEvent label], [trackingEvent val]);
        else
            DDLogInfo(@"Analytics event (%@, %@, %@, %@): trigger error", [trackingEvent category], [trackingEvent action], [trackingEvent label], [trackingEvent val]);
    }
    @catch (NSException *exception) {
        DDLogInfo(@"Analytics event (%@, %@, %@, %@): exception thrown %@", [trackingEvent category], [trackingEvent action], [trackingEvent label], [trackingEvent val], exception);
    }
}
@end
