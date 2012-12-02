//
//  GoogleEvent.h
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/26/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//



@interface GoogleEvent : NSObject
{
    NSString *domainName;
    NSString *category;
    NSString *action;
    NSString *label;
    NSNumber *val;
    
}

@property (nonatomic, copy) NSString *domainName;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSNumber *val;

- (id)initWithParams: (NSString*)_domainName category:(NSString*)_category action:(NSString*)_action label:(NSString*)_label value:(NSNumber*)_val;


@end
