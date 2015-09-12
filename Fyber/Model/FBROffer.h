//
//  FBROffer.h
//  Fyber
//
//  Created by Evgeniy Disyak on 9/11/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "WebObject.h"
#import "OfferImage.h"

@interface FBROffer : WebObject

@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *offerId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *teaser;
@property (strong, nonatomic) OfferImage *thumbnail;
@property (strong, nonatomic) NSNumber *payout;

@end
