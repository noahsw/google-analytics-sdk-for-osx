//
//  NSString+URLEncoding.h
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/24/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>

@interface NSString (URLEncoding)

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

@end
