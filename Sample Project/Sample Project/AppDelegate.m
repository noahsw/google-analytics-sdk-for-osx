//
//  AppDelegate.m
//  Sample Project
//
//  Created by Noah Spitzer-Williams on 9/5/13.
//  Copyright (c) 2013 Google Analytics SDK for OSX. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    AnalyticsHelper* analyticsHelper = [AnalyticsHelper new];
    
    [analyticsHelper setDomainName:@"example.com"];
    [analyticsHelper setAnalyticsAccountCode:@"UA-XXXXX-Y"];
    
    if ([analyticsHelper fireEvent:@"appLoads" eventValue:@1])
        NSLog(@"Google Analytics event fired asyncronously from Sample Project");
    else
        NSLog(@"Error firing Google Analytics event from Sample Project!");
    
}

@end
