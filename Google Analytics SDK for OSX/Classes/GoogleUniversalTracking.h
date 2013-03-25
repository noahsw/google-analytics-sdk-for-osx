//
//  GoogleMeasurementProtocolEvent.h
//  Google Analytics SDK for OSX
//
//  Created by Jerry Tian on 3/25/13.
//  Copyright (c) 2013 Noah Spitzer-Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackingRequest.h"

@interface GoogleUniversalTracking : NSOperation

@property (strong) TrackingRequest* request;

@end
