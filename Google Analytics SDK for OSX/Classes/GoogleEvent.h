//
//  GoogleEvent.h
//  Google Analytics SDK for OSX
//
//  Created by Noah Spitzer-Williams on 11/26/11.
//  http://github.com/noahsw/google-analytics-sdk-for-osx
//

@interface GoogleEvent : NSObject

@property (nonatomic, copy) NSString *domainName;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSNumber *val;

- (id)initWithParams:(NSString *)domainName category:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)val;

@end
