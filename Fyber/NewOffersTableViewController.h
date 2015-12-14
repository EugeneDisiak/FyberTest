//
//  NewOffersTableViewController.h
//  Fyber
//
//  Created by Evgeniy Disyak on 9/14/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewOffersTableViewControllerDelegate;

@interface NewOffersTableViewController : UIViewController

@property (weak, nonatomic) id <NewOffersTableViewControllerDelegate> delegate;

- (void)showOffersOn: (UIViewController *)viewController;

@end


