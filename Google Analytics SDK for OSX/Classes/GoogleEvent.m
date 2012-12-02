//
//  GoogleEvent.m
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/26/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

#import "GoogleEvent.h"

@implementation GoogleEvent

@synthesize domainName;
@synthesize category;
@synthesize action;
@synthesize label;
@synthesize val;

- (id)initWithParams: (NSString*)_domainName category:(NSString*)_category action:(NSString*)_action label:(NSString*)_label value:(NSNumber*)_val;
{
    
    if ([_domainName length] == 0)
        return nil;
    
    if ([_category length] == 0)
        return nil;
    
    if ([_action length] == 0)
        return nil;
    
    if ([_label length] == 0)
        return nil;
        
    self = [super init];
    if (self) {
        domainName = [_domainName copy];
        category = [_category copy];
        action = [_action copy];
        label = [_label copy];
        val = [_val copy];
    }
    
    return self;
    
}



@end
