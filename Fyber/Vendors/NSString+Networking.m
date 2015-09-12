//
//  UITableView+MD5.m
//  astratex
//
//  Created by Andrew Malyarchuk on 27.01.15.
//  Copyright (c) 2015 New Vision LLC. All rights reserved.
//

#import "NSString+Networking.h"
#import <CommonCrypto/CommonDigest.h>

static inline NSString *NSStringCCHashFunction(unsigned char *(function)(const void *data, CC_LONG len, unsigned char *md), CC_LONG digestLength, NSString *string)
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[digestLength];
    
    function(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:digestLength * 2];
    
    for (int i = 0; i < digestLength; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@implementation NSString (Networking)

- (NSString *)md5
{
    return NSStringCCHashFunction(CC_MD5, CC_MD5_DIGEST_LENGTH, self);
}

- (NSString *)sha1
{
    return NSStringCCHashFunction(CC_SHA1, CC_SHA1_DIGEST_LENGTH, self);
}

- (NSString *)URLEncodedString
{
    NSString *escaped =
    (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                          (CFStringRef)self,
                                                                          NULL,
                                                                          (CFStringRef)@";/?:@&=$+{}<>,",
                                                                          kCFStringEncodingUTF8));
    return escaped;
}

@end
