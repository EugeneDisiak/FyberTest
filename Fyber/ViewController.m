//
//  ViewController.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/10/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "ViewController.h"
#import "FyberSDK.h"
#import "OffersTableViewController.h"
#import "NewOffersTableViewController.h"

@interface ViewController () <NewOffersTableViewControllerDelegate>

@property (strong, nonatomic) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.userID.delegate = self;
    self.apiKey.delegate = self;
    self.appID.delegate = self;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Prepopulate text fields with folowwing data
    self.userID.text    = @"spiderman";
    self.apiKey.text    = @"1c915e3b5d42d05136185030892fbb846c278927";
    self.appID.text     = @"2070";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

# pragma mark - Form Actions
- (IBAction)getOffersAction:(UIButton *)sender {
    // If text fields will be empty, there is no reason to send request
    if ([self.userID.text isEqualToString:@""] ||
        [self.apiKey.text isEqualToString:@""] ||
        [self.appID.text isEqualToString:@""]) {
        
        [self displayNotificationMessageWithTitle:@"Error!" andText:@"Please check your input data. Fields above can not be empty."];
        return;
    }
    
    [FyberSDK setupFiberWithUserId:self.userID.text
                       andApiKey:self.apiKey.text
                        andAppID:self.appID.text];
    
    [FyberSDK showOfferWall:self];
    
        //[self presentViewController:noTVC animated:YES completion:nil];
    return;
    /*
    // In case of TASK 7, this method can be run at once on AppDelegate file. It will initialize Fiber SDK
    [FBRAPI setupFiberWithUserId:self.userID.text
                       andApiKey:self.apiKey.text
                        andAppID:self.appID.text];

    // In case of TASK 7, this method can be run at once in any place (Button Action or any other)
    // As parameter: send SELF as Current View Controller
    // As response: receive Table View Controller
    [FBRAPI getOffersWithSuccess: ^(NSArray *array) {
                            // IF Array empty -> FAIL message
                            if (array == nil || [array count] == 0) {
                                [self displayNotificationMessageWithTitle:@"Fail!" andText:@"No offers."];
                            } else {
                                // IF Offers exists -> open Table View Controller with Offers
                                self.array = array;
                                [self performSegueWithIdentifier:@"displayOffers" sender:self];
                            }
                        }
                        failure: ^(NSError *error, AFHTTPRequestOperation *operation) {
                            // IF wrong responce -> FAIL message
                            [self displayNotificationMessageWithTitle:@"Fail!" andText:@"Check your data and try again later."];
                        }];
     */
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"displayOffers"]) {
        OffersTableViewController *offersTVC = segue.destinationViewController;
        offersTVC.offers = self.array;
    }
}

#pragma mark - UITextFieldDelegate

// Dismiss keyboard on DONE button tap
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// Dismiss keyboard on any View tap
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

# pragma mark - NewOffersTableViewControllerDelegate

- (void)viewControllerClosedByButtonTap {
    NSLog(@"Ads ViewController closed by Close button");
}
- (void)viewControllerClosedByCellTap {
    NSLog(@"Ads ViewController closed by Tap on cell");
}

@end
