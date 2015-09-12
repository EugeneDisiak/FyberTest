//
//  NSDictionary+JSONString.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/10/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.

#import "NSDictionary+JSONString.h"
#import "NSArray+JSONString.h"
#import "NSString+Networking.h"

@implementation NSDictionary (JSONString)

- (NSString*)jsonString
{
    return jsonStringWithDictionary(self, NO);
}

- (NSString*)jsonStringWithQuotes
{
    return jsonStringWithDictionary(self, YES);
}

- (NSString*)jsonStringWithURLEncodedItems
{
    return jsonStringWithDictionary([self objectWithURLEncodedItems], NO);
}

- (NSDictionary *)objectWithURLEncodedItems
{
    id item = nil;
    
    NSDictionary *dict3 = [NSDictionary dictionaryWithDictionary:self];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dict3];
    
    for (NSString *key in dict.allKeys) {
        item = dict[key];
        if ([item isKindOfClass:[NSString class]]) {
            dict[key] = [item URLEncodedString];
        } else if ([item isKindOfClass:NSDictionary.class] ||
                   [item isKindOfClass:NSArray.class]) {
            dict[key] = [item objectWithURLEncodedItems];
        }
    }
    return dict;
}

NSString* jsonStringWithDictionary(NSDictionary *dict, BOOL addQuotes)
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return addQuotes ? [NSString stringWithFormat:@"\"%@\"", jsonStr] : jsonStr;
    }
}

@end
