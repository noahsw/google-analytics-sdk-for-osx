//
//  GoogleTracking.h
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/24/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

#import "TrackingRequest.h"

@interface GoogleTracking : NSOperation
{

}

@property (strong) TrackingRequest* request;



@end