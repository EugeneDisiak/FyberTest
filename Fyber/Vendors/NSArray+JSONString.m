//
//  NSArray+JsonDescription.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/10/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "NSArray+JSONString.h"
#import "NSDictionary+JSONString.h"
#import "NSString+Networking.h"

@implementation NSArray (JSONString)

- (NSString*)jsonString
{
    return jsonStringWithArray(self);
}

- (NSString*)jsonStringWithURLEncodedItems
{
    return jsonStringWithArray([self objectWithURLEncodedItems]);
}

- (NSArray *)objectWithURLEncodedItems
{
    id item = nil;
    NSMutableArray *array = [self mutableCopy];
    for (NSUInteger i = 0; i < array.count; i++) {
        item = array[i];
        if ([item isKindOfClass:[NSString class]]) {
            array[i] = [(NSString *)item URLEncodedString];
        } else if ([item isKindOfClass:NSDictionary.class] ||
                   [item isKindOfClass:NSArray.class]) {
            array[i] = [item objectWithURLEncodedItems];
        }
    }
    return array;
}

NSString* jsonStringWithArray(NSArray *array)
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"[]";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
