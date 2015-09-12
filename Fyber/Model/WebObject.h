//
//  WebObject.h
//  Fyber
//
//  Created by Evgeniy Disyak on 9/11/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKMapper.h"

@interface WebObject : NSObject <EKMappingProtocol>

- (instancetype)init:(void(^)(id _self))constructingBlock;
- (instancetype)initWithJson:(NSDictionary *)json;
- (instancetype)initWithJson:(NSDictionary *)json constructingBlock:(void(^)(id _self))constructingBlock;

// Abstract
+ (EKObjectMapping *)objectMapping;

@end
