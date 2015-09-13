//
//  ViewControllerSpec.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/13/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "Kiwi.h"
#import "ViewController.h"
#import "OffersTableViewController.h"


SPEC_BEGIN(ViewControllerTests)

describe(@"OffersTableViewController", ^{
    
    __block OffersTableViewController *offersTVC;
    
    beforeEach(^{
        offersTVC = [[OffersTableViewController alloc] init];
    });
    
    describe(@"view", ^{
        __block UIView *view;
        
        beforeEach(^{
            view = [offersTVC view];
        });
        
        it(@"has a view outlet", ^{
            [[view shouldNot] beNil];
        });
        
        it(@"has table view outlet", ^{
            [[offersTVC.tableView shouldNot] beNil];
        });
        
    });
});

describe(@"MainViewController", ^{
    __block ViewController *vc;
    
    beforeEach(^{
        vc = [[ViewController alloc] init];
    });
    
    describe(@"view", ^{
        __block UIView *view;
        
        beforeEach(^{
            view = [vc view];
        });
        
        it(@"has a view outlet", ^{
            [[view shouldNot] beNil];
        });
    });
    
});

SPEC_END