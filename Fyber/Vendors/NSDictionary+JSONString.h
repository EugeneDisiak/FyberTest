//
//  NSDictionary+JSONString.h
//  Fyber
//
//  Created by Evgeniy Disyak on 9/10/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONString)

- (NSString*)jsonString;
- (NSString*)jsonStringWithURLEncodedItems;

@end
