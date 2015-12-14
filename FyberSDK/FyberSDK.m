//
//  FyberSDK.m
//  Fyber
//
//  Created by Evgeniy Disyak on 10/26/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "FyberSDK.h"
#import "FBRAPI.h"
#import "NewOffersTableViewController.h"

@implementation FyberSDK

+ (void)setupFiberWithUserId:(NSString *)userID
                   andApiKey:(NSString *)apiKey
                    andAppID:(NSString *)appID {

    [FBRAPI setupFiberWithUserId:userID
                       andApiKey:apiKey
                        andAppID:appID];
}

+ (void)showOfferWall:(UIViewController <NewOffersTableViewControllerDelegate> *)parentViewController {
    NewOffersTableViewController *noTVC = [[NewOffersTableViewController alloc] init];
    noTVC.delegate = parentViewController;
    [noTVC showOffersOn:parentViewController];
}

@end
