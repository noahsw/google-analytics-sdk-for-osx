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
    
    if ([AnalyticsHelper fireEvent:@"appLoads" eventValue:@1])
        NSLog(@"Google Analytics event fired successfully");
    else
        NSLog(@"Error firing Google Analytics event!");
    
}

@end
