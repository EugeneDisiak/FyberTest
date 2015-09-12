//
//  ViewController.m
//  Fyber
//
//  Created by Evgeniy Disyak on 9/10/15.
//  Copyright © 2015 Evgeniy Disyak. All rights reserved.
//

#import "ViewController.h"
#import "FBRAPI.h"
#import "OffersTableViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userID;
@property (weak, nonatomic) IBOutlet UITextField *apiKey;
@property (weak, nonatomic) IBOutlet UITextField *appID;
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
    
    [FBRAPI setupFiberWithUserId:self.userID.text
                       andApiKey:self.apiKey.text
                        andAppID:self.appID.text];
    
    [FBRAPI getOffersWithSuccess: ^(NSArray *array) {
                            if (array == nil || [array count] == 0) {
                                [self displayNotificationMessageWithTitle:@"Fail!" andText:@"No offers."];
                            } else {
                                self.array = array;
                                [self performSegueWithIdentifier:@"displayOffers" sender:self];
                            }
                        }
                        failure: ^(NSError *error, AFHTTPRequestOperation *operation) {
                            [self displayNotificationMessageWithTitle:@"Fail!" andText:@"Check your data and try again later."];
                        }];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // done button was tapped - dismiss keyboard
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
