//
//  GoogleEvent.m
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/26/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

#import "GoogleEvent.h"

@implementation GoogleEvent

@synthesize domainName = _domainName;
@synthesize category = _category;
@synthesize action = _action;
@synthesize label = _label;
@synthesize val = _val;

- (id)initWithParams:(NSString *)domainName category:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)val;
{
    if ([domainName length] == 0)
        return nil;

    if ([category length] == 0)
        return nil;

    if ([action length] == 0)
        return nil;

    if ([label length] == 0)
        return nil;

    self = [super init];
    if (self) {
        self.domainName = domainName;
        self.category = category;
        self.action = action;
        self.label = label;
        self.val = val;
    }

    return self;
}

@end
