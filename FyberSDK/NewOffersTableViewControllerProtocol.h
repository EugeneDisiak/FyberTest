//
//  NewOffersTableViewControllerProtocol.h
//  Fyber
//
//  Created by Evgeniy Disyak on 10/26/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol NewOffersTableViewControllerDelegate <NSObject>
@required
//
// Required methods
// Notify if user closed Offer Wall by clicking on Close Button
//
- (void)viewControllerClosedByButtonTap;
//
// Notify if user closed Offer Wall by clicking on Cell
//
- (void)viewControllerClosedByCellTap;

@optional

@end
