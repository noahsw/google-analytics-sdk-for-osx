//
//  NSString+URLEncoding.m
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/24/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    CFStringRef blah = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                             (__bridge CFStringRef)self,
                                                             NULL,
                                                             (CFStringRef)@"!'\";:@&=+$,/?%#[]% ",
                                                             CFStringConvertNSStringEncodingToEncoding(encoding));
	NSString* ret = (NSString*)CFBridgingRelease(blah);
    // I removed ()* from function because it doesn't seem to be replaced in PC version which works just fine

    return ret;
}

@end
