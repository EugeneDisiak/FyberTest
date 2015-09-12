//
//  FBROffer.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/11/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "FBROffer.h"


@implementation FBROffer

+ (EKObjectMapping *)objectMapping
{
    static EKObjectMapping *_mapping = nil;
    
    if (!_mapping) {
        _mapping = [[EKObjectMapping alloc] initWithObjectClass:[FBROffer class]];
        
        [_mapping mapPropertiesFromArray:@[@"link", @"title", @"teaser", @"payout"]];
        [_mapping mapPropertiesFromDictionary:@{@"offer_id":@"offerId"}];
        [_mapping hasOne:[OfferImage class] forKeyPath:@"thumbnail"];
    }
    return _mapping;
}

@end
