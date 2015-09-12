//
//  FiberSKD.h
//  Fyber
//
//  Created by Evgeniy Disyak on 9/12/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBRAPI.h"
#import "OffersTableViewController.h"

@interface FiberSKD : NSObject

//+ (FiberSKD *)sharedInstance;

+ (void)displayOffersInViewController:(UIViewController *)parentVC;

+ (void)setupFiberWithUserId:(NSString *)userID
                   andApiKey:(NSString *)apiKey
                    andAppID:(NSString *)appID;

@end
