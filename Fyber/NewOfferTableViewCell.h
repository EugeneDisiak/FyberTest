//
//  NewOfferTableViewCell.h
//  Fyber
//
//  Created by Evgeniy Disyak on 9/14/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBROffer.h"

@interface NewOfferTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *teaser;
@property (weak, nonatomic) IBOutlet UILabel *payout;

- (void)setupWithOffer:(FBROffer *)offer;

@end
