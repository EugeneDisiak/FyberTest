//
//  OfferImage.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/11/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "OfferImage.h"

@implementation OfferImage

+ (EKObjectMapping *)objectMapping
{
    static EKObjectMapping *_mapping = nil;
    
    if (!_mapping) {
        _mapping = [[EKObjectMapping alloc] initWithObjectClass:[OfferImage class]];
        
        [_mapping mapPropertiesFromArray:@[@"hires", @"lowres"]];
    }
    return _mapping;
}

@end
