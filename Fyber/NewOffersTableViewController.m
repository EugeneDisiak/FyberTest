//
//  NewOffersTableViewController.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/14/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "NewOffersTableViewController.h"
#import "NewOfferTableViewCell.h"
#import "FBRAPI.h"
#import "NewOffersTableViewControllerProtocol.h"


@interface NewOffersTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *offers;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *closeButton;

@end

@implementation NewOffersTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize windowSize = self.view.bounds.size;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.frame = self.view.bounds;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton addTarget:self
               action:@selector(closeButtonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.closeButton.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    [self.closeButton setFrame:CGRectMake(windowSize.width - 40.f, -0.f, 40.f, 20.f)];
    self.closeButton.layer.cornerRadius = 5.f;
    [self.closeButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [self.closeButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.closeButton];
    
    [FBRAPI getOffersWithSuccess: ^(NSArray *array) {
        // IF Array empty -> FAIL message
        if (array == nil || [array count] == 0) {
            [self displayNotificationMessageWithTitle:@"Fail!" andText:@"No offers received."];
        } else {
            // IF Offers exists -> open Table View Controller with Offers
            self.offers = array;
            self.tableView.separatorColor = [UIColor lightGrayColor];
            [self.tableView reloadData];
        }
    }
                         failure: ^(NSError *error, AFHTTPRequestOperation *operation) {
                             // IF wrong responce -> FAIL message
                             [self displayNotificationMessageWithTitle:@"Fail!" andText:[error localizedDescription]];
                             
                         }];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.offers count];
}


- (NewOfferTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"NewOfferTableViewCell";
    
    NewOfferTableViewCell *cell = (NewOfferTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewOfferTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    FBROffer *offer = [self.offers objectAtIndex:indexPath.row];
    
    [cell setupWithOffer:offer];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)showOffersOn: (UIViewController *)viewController {
    [viewController presentViewController:self animated:YES completion:nil];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak NewOffersTableViewController *weakSelf = self;
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Close ON Cell Tap action");
        [weakSelf.delegate viewControllerClosedByCellTap];
    }];
}

#pragma mark - Local Methods

- (void)displayNotificationMessageWithTitle: (NSString *)title
                                    andText: (NSString *)text {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:text
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

- (void)closeButtonAction: (UIButton *)sender {
    
    __weak NewOffersTableViewController *weakSelf = self;
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Close ON CloseButton action");
        [weakSelf.delegate viewControllerClosedByButtonTap];
    }];
    
}

@end
