//
//  FBRAPI.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/10/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "FBRAPI.h"
#import "NSString+Networking.h"
#import "NSDictionary+JSONString.h"
#import "NSArray+JSONString.h"
#import <AdSupport/ASIdentifierManager.h>

static const NSString *_requestURL = @"http://api.sponsorpay.com/feed/v1/offers.json?";
static NSString *_userID = nil;
static NSString *_apiKey = nil;
static NSString *_appID = nil;
static NSString *_deviceOSVersion = nil;
static NSString *_appleIDFA = nil;
static NSString *_appleIDFATrackingEnabled = nil;
static NSString *_format = nil;
static NSString *_locale = nil;
static NSString *_ip = nil;
static NSString *_offerTypes = nil;

@implementation FBRAPI


+ (void)setupFiberWithUserId:(NSString *)userID
                     andApiKey:(NSString *)apiKey
                      andAppID:(NSString *)appID
{
    _userID = userID;
    _apiKey = apiKey;
    _appID = appID;
    
    _deviceOSVersion = [[UIDevice currentDevice] systemVersion];
    _appleIDFA = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    _appleIDFATrackingEnabled = [ASIdentifierManager sharedManager].advertisingTrackingEnabled ? @"true" : @"false";
    
    _format = @"json";
    _locale = @"DE";
    _ip = @"109.235.143.113";
    _offerTypes = @"112";
}

+ (AFHTTPRequestOperation *)getOffersWithSuccess:(ArrayCompleiton)success
                                         failure:(RequestFailure)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    
    NSDictionary *mParams = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    _userID, @"uid",
                                    _appID, @"appid",
                                    _format, @"format",
                                    _locale, @"locale",
                                    _deviceOSVersion, @"os_version",
                                    _appleIDFA, @"apple_idfa",
                                    _appleIDFATrackingEnabled, @"apple_idfa_tracking_enabled",
                                    _ip, @"ip",
                                    _offerTypes, @"offer_types",
                                    timestamp, @"timestamp",
                                    nil];
    
    NSString *stringParams = [self queryStringWithParams: mParams];
    NSString *requestURL = [_requestURL stringByAppendingString: stringParams];
    
    return [manager GET:requestURL
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    // Validate responce
                    if ([self validateResponce:operation]) {
                        // Valid Response, parsing data
                        if (success) {
                            success([self arrayForKeyPath:@"offers"
                                                   inJson:responseObject
                                               itemsClass:[FBROffer class]]);
                        }
                    } else {
                        // Not valide Response, return empty array
                        success([[NSArray alloc] init]);
                    }
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    failure(error, operation);
         }];
}

#pragma mark - Response Methods

+ (BOOL)validateResponce:(AFHTTPRequestOperation *)operation {
    
    // Getting Hashed string from Response
    NSString *hashedResponseStringWithAPIKey = [operation.responseString stringByAppendingString:_apiKey].sha1;
    
    // Getting X-Sponsorpay-Response-Signature
    NSHTTPURLResponse *httpResponse = operation.response;
    
    // Compare Hashed string with X-Sponsorpay-Response-Signature
    if ([httpResponse respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary *dictionary = [httpResponse allHeaderFields];
        if ([dictionary count] != 0 &&
            dictionary[@"X-Sponsorpay-Response-Signature"] &&
            [dictionary[@"X-Sponsorpay-Response-Signature"] isEqualToString:hashedResponseStringWithAPIKey]) {
            
            return true;
        }
    }
    return false;
}

#pragma mark - Mapping JSON Methods

+ (NSArray *)arrayForKeyPath:(NSString *)keyPath
                      inJson:(NSDictionary *)json
                  itemsClass:(Class)class
{
    if (!keyPath) return nil;
    
    NSMutableArray *result = [NSMutableArray new];
    NSArray *data = [json valueForKeyPath:keyPath];
    
    for (NSDictionary *item in data) {
        [result addObject:[[class alloc] initWithJson:item]];
    }
    
    return result;
}

#pragma mark - URL Transforming Methods

+ (NSString *)queryStringWithParams:(NSDictionary *)params
{
    NSMutableString *resultEncodedValues = [NSMutableString string];
    NSMutableString *resultSimple = [NSMutableString string];
    
    // Order these pairs alphabetically by parameter name
    NSArray *keys = [params allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator: ^NSComparisonResult(id a, id b) {
        return [a compare:b];
    }];
    
    // transforming Request Array to a string
    BOOL amp = NO;
    for (NSString *key in sortedKeys) {
        if (amp) {
            [resultEncodedValues appendString:@"&"],
            [resultSimple appendString:@"&"];
        } else {
            amp = YES;
        }
        id value = [params objectForKey:key];
        
        value = [NSString stringWithFormat:@"%@", value];
        [resultSimple appendFormat:@"%@=%@", key, value];
        
        value = [value URLEncodedString];
        [resultEncodedValues appendFormat:@"%@=%@", key, value];
    }
    
    [resultSimple appendFormat:@"&%@", _apiKey];
    
    NSString *hash__ = [self hashWithParamsString:resultSimple];
    [resultEncodedValues appendFormat:@"%@hashkey=%@", (amp ? @"&" : @""), hash__];
    
    return resultEncodedValues;
}

+ (NSString *)hashWithParamsString:(NSString *)paramsString
{
    return paramsString.sha1;
}

@end
