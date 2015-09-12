//
//  OfferTableViewCell.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/11/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "OfferTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation OfferTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithOffer:(FBROffer *)offer {

    self.title.text = offer.title;
    self.teaser.text = offer.teaser;
    self.payout.text = [NSString stringWithFormat:@"%@", offer.payout];
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:offer.thumbnail.hires]];
    self.thumbnail.layer.cornerRadius = 10.0f;
    self.thumbnail.layer.masksToBounds = YES;
    self.payout.layer.cornerRadius = 10.0f;
    self.payout.layer.masksToBounds = YES;
    self.layer.masksToBounds = YES;
}

@end
