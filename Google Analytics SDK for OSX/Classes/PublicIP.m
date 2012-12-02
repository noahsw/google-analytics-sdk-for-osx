//
//  PublicIP.m
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/27/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

#import "PublicIP.h"

#import "DDLog.h"

#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE | LOG_LEVEL_INFO | LOG_LEVEL_ERROR | LOG_LEVEL_WARN;
#else
static const int ddLogLevel = LOG_LEVEL_INFO | LOG_LEVEL_ERROR | LOG_LEVEL_WARN;
#endif

@implementation PublicIP

static NSString *ipAddress = nil;

+ (NSString*) getIPAddress
{
    
    if (ipAddress != nil)
        return ipAddress; // return cached result
    
    NSUInteger  an_Integer;
    NSArray * ipItemsArray;
    
    NSURL *iPURL = [NSURL URLWithString:@"http://checkip.dyndns.org"];
    
    if (iPURL) {
        @try
        {
            NSError *error = nil;
            NSString *theIpHtml = [NSString stringWithContentsOfURL:iPURL 
                                                           encoding:NSUTF8StringEncoding 
                                                              error:&error];
            if (!error) {
                NSScanner *theScanner;
                NSString *text = nil;
                
                theScanner = [NSScanner scannerWithString:theIpHtml];
                
                while ([theScanner isAtEnd] == NO) {
                    
                    // find start of tag
                    [theScanner scanUpToString:@"<" intoString:NULL] ; 
                    
                    // find end of tag
                    [theScanner scanUpToString:@">" intoString:&text] ;
                    
                    // replace the found tag with a space
                    //(you can filter multi-spaces out later if you wish)
                    theIpHtml = [theIpHtml stringByReplacingOccurrencesOfString:
                                 [ NSString stringWithFormat:@"%@>", text]
                                                                     withString:@" "] ;
                    ipItemsArray =[theIpHtml  componentsSeparatedByString:@" "];
                    an_Integer=[ipItemsArray indexOfObject:@"Address:"];
                    
                    ipAddress =ipItemsArray[++an_Integer];
                    
                } 
                
                
                //DDLogVerbose(@"Public IP: %@",ipAddress);
            } else {
                // NSLog(@"Oops... g %@, %@", [error code], [error localizedDescription]);
            }
        }
        @catch (NSException	*exception) {
            DDLogVerbose(@"Error getting public IP: %@ %@", [exception name], [exception reason]);
            ipAddress = [NSString stringWithFormat:@""];
        }
    }
    
    
    return ipAddress;
}

@end
