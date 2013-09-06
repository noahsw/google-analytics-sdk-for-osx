//
//  RequestFactory.h
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/26/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

#import "TrackingRequest.h"
#import "GoogleEvent.h"


@interface RequestFactory : NSObject
{
    
    
}


- (TrackingRequest*) buildRequest: (GoogleEvent*) googleEvent analyticsAccountCode:(NSString*)analyticsAccountCode;

@end
