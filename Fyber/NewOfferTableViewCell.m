//
//  NewOfferTableViewCell.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/14/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "NewOfferTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@implementation NewOfferTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupWithOffer:(FBROffer *)offer {
    
    self.title.text = offer.title;
    self.teaser.text = offer.teaser;
    self.payout.text = [NSString stringWithFormat:@"%@", offer.payout];
    [self.thumbnail setImageWithURL:[NSURL URLWithString:offer.thumbnail.hires]];
    self.thumbnail.layer.cornerRadius = 10.0f;
    self.thumbnail.layer.masksToBounds = YES;
    self.payout.layer.cornerRadius = 10.0f;
    self.payout.layer.masksToBounds = YES;
    self.layer.masksToBounds = YES;
}

@end
