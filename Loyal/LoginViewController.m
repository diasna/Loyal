//
//  LoginViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/21/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "LoginViewController.h"
#import "ASIFormDataRequest.h"
#import "JASidePanelController.h"
#import "MySidePanelController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UIAlertView *alert;
}

@synthesize usernameField;
@synthesize passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)signInBtnClick:(id)sender {
    alert = [[UIAlertView alloc]
             initWithTitle:@"Loading..."
             message:@"Please wait we're sign you in"
             delegate:nil
             cancelButtonTitle:nil
             otherButtonTitles: nil];
    [alert show];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://apimobile.pendhapa.com/api/Account"] ];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", [usernameField text], [passwordField text]];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [authData base64EncodedStringWithOptions:0];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@", base64String]];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    NSLog(@"Yolo Getting Data...");
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSMutableDictionary *dataJson = [NSJSONSerialization
                                      JSONObjectWithData:[request responseData]
                                      options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                      error:nil];
    NSArray *customer = [dataJson valueForKey:@"Customer"];
    if (customer.count < 1) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        UIAlertView *alertWarning = [[UIAlertView alloc]
                                     initWithTitle:@"Login Failed"
                                     message:@"Please check your username or password"
                                     delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
        [alertWarning show];
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[customer valueForKey:@"cust_name"] forKey:@"name"];
        [defaults setObject:[customer valueForKey:@"cust_gender"] forKey:@"gender"];
        [defaults setObject:[customer valueForKey:@"cust_dob"] forKey:@"birthDate"];
        [defaults setObject:[customer valueForKey:@"cust_address1"] forKey:@"address"];
        [defaults setObject:[customer valueForKey:@"cust_idcards"] forKey:@"cardNo"];
        [defaults setObject:[customer valueForKey:@"cust_email"] forKey:@"email"];
        [defaults setObject:[customer valueForKey:@"cust_mobile"] forKey:@"mobile"];
        [defaults setObject:[customer valueForKey:@"cust_pointot"] forKey:@"luckDraw"];
        [defaults setObject:[customer valueForKey:@"cust_pointtot_re"] forKey:@"redeemPoint"];
        
        [defaults setObject:[customer valueForKey:@"cust_seqno"] forKey:@"custSeqNo"];
        [defaults setObject:[customer valueForKey:@"cust_pnum"] forKey:@"pNum"];
        [defaults setObject:[customer valueForKey:@"cust_ptype"] forKey:@"pType"];
        
        [defaults setObject:[dataJson valueForKey:@"Token"] forKey:@"token"];
        [defaults synchronize];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        [self _changeCenterPanelTapped:[self.storyboard instantiateViewControllerWithIdentifier:@"accountViewController"]];
    }
    
}

- (void)_changeCenterPanelTapped:(UIViewController*)uiViewController {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    JASidePanelController *rootViewController = (JASidePanelController *)delegate.window.rootViewController;
    rootViewController.centerPanel = uiViewController;
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Yolo Error: %@", error);
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
