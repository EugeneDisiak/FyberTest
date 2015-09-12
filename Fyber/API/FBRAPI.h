//
//  FBRAPI.h
//  Fyber
//
//  Created by Evgeniy Disyak on 9/10/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "FBROffer.h"

typedef void(^ArrayCompleiton)(NSArray *array);
typedef void(^RequestFailure)(NSError *error, AFHTTPRequestOperation *operation);

@interface FBRAPI : NSObject

+ (AFHTTPRequestOperation *)getOffersWithSuccess:(ArrayCompleiton)success
                                         failure:(RequestFailure)failure;

+ (void)setupFiberWithUserId:(NSString *)userID
                     andApiKey:(NSString *)apiKey
                      andAppID:(NSString *)appID;

@end
