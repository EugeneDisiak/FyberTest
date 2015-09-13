//
//  FyberTests.m
//  FyberTests
//
//  Created by Evgeniy Disyak on 9/11/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Networking.h"
#import "OffersTableViewController.h"

@interface FyberTests : XCTestCase

@property OffersTableViewController *tvc;

@end

@implementation FyberTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tvc = [[OffersTableViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStringHash {
    NSString *testString = @"Test string";
    XCTAssertNotNil(testString.sha1);
}

- (void)testTableViewControllerView {
    UIView *view;
    view = [self.tvc view];
    XCTAssertNotNil(view);
}

- (void)testTableViewControllerTableView {
    XCTAssertNotNil(self.tvc.tableView);
}

- (void)testTableViewSections {
    XCTAssertEqual(self.tvc.tableView.numberOfSections, 1);
}

@end
