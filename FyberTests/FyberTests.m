//
//  FyberTests.m
//  FyberTests
//
//  Created by Evgeniy Disyak on 9/11/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Networking.h"
#import <AFNetworking/AFNetworking.h>

@interface FyberTests : XCTestCase

@end

@implementation FyberTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testStringHash {
    NSString *testString = @"Test string";
    XCTAssertNotNil(testString.sha1);
}

@end
