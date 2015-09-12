//
//  FiberSKD.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/12/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "FiberSKD.h"

@interface FiberSKD()

@property (strong, nonatomic) NSArray *array;

@end

@implementation FiberSKD

//+ (FiberSKD *)sharedInstance {
//    static FiberSKD* manager = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        manager = [self new];
//    });
//    return manager;
//}

+ (void)setupFiberWithUserId:(NSString *)userID
                   andApiKey:(NSString *)apiKey
                    andAppID:(NSString *)appID {
    
    [FBRAPI setupFiberWithUserId:userID
                       andApiKey:apiKey
                        andAppID:appID];
    
}

+ (void)displayOffersInViewController:(UIViewController *)parentVC {
    
    [FBRAPI getOffersWithSuccess: ^(NSArray *array) {
                            if (array == nil || [array count] == 0) {
                                
                            } else {
                                self.array = array;
                                [self performSegueWithIdentifier:@"displayOffers" sender:self];
                            }
                        }
                        failure: ^(NSError *error, AFHTTPRequestOperation *operation) {
                            
    }];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"displayOffers"]) {
        OffersTableViewController *offersTVC = segue.destinationViewController;
        offersTVC.offers = self.array;
    }
}

@end
