//
//  FyberSDK.h
//  Fyber
//
//  Created by Evgeniy Disyak on 10/26/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NewOffersTableViewControllerProtocol.h"


@interface FyberSDK : NSObject

+ (void)setupFiberWithUserId:(NSString *)userID
                   andApiKey:(NSString *)apiKey
                    andAppID:(NSString *)appID;

+ (void)showOfferWall:(UIViewController <NewOffersTableViewControllerDelegate> *) parentViewController;
@end
