//
//  SampleSpec.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/11/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//


#import "Kiwi.h"
#import "NSString+Networking.h"


SPEC_BEGIN(TestSpec)

describe(@"String", ^{
    it(@"SHA1 not nil", ^{
        NSString *testString = @"Test string";
        [[testString.sha1 shouldNot] beNil];
    });
});

SPEC_END