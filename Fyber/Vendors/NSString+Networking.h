//
//  UITableView+MD5.h
//  astratex
//
//  Created by Andrew Malyarchuk on 27.01.15.
//  Copyright (c) 2015 New Vision LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Networking)

@property (nonatomic, readonly) NSString *md5;
@property (nonatomic, readonly) NSString *sha1;

- (NSString *)URLEncodedString;

@end
