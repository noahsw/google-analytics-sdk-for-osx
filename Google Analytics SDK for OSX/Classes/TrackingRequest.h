//
//  TrackingRequest.h
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/24/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

#include "GoogleEvent.h"
#import "JFUrlUtil.h"

@interface TrackingRequest : NSObject
{
    NSString *pageTitle;
    NSString *pageDomain;
    NSString *pageUrl;
    
    NSString *requestedByIpAddress;
    
    NSString *referralSource;
    NSString *medium;
    NSString *campaign;
    
    GoogleEvent *trackingEvent;
    
    NSString *analyticsAccountCode;
    
    NSString *visitCount;
        
}

@property (nonatomic, strong) NSString *pageTitle;
@property (nonatomic, strong) NSString *pageDomain;
@property (nonatomic, strong) NSString *pageUrl;

@property (nonatomic, strong) NSString *requestedByIpAddress;

@property (nonatomic, strong) NSString *referralSource;
@property (nonatomic, strong) NSString *medium;
@property (nonatomic, strong) NSString *campaign;

@property (nonatomic, strong) GoogleEvent *trackingEvent;

@property (nonatomic, strong) NSString *analyticsAccountCode;

@property (nonatomic, strong) NSString *visitCount;


- (NSString*) trackingGifURL;

- (NSString*) utmcCookieString;

- (int) domainHash;

- (NSString*) timeStampCurrent;

@end