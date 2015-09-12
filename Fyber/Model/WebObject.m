//
//  WebObject.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/11/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "WebObject.h"

static EKObjectMapping *_mapping = nil;

@implementation WebObject

+ (EKObjectMapping *)objectMapping
{
    [NSException raise:@"abstract method call" format:@"%s", __PRETTY_FUNCTION__];
    return nil;
}

- (instancetype)init:(void(^)(id _self))initBlock
{
    self = [super init];
    if (self) {
        
        // common instantiation
        if (initBlock) initBlock(self);
        
    }
    return self;
}

- (instancetype)initWithJson:(NSDictionary *)json
{
    return [self initWithJson:json constructingBlock:nil];
}

- (instancetype)initWithJson:(NSDictionary *)json constructingBlock:(void(^)(id _self))constructingBlock
{
    return [self init:^(id _self) {
        
        [EKMapper fillObject:_self
  fromExternalRepresentation:json
                 withMapping:[[_self class] objectMapping]];
        if (constructingBlock)
            constructingBlock(_self);
    }];
}




@end
