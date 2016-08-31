//
//  ProfileViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/21/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "JASidePanelController.h"
#import "Util.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize nameLabel;
@synthesize genderLabel;
@synthesize birthDateLabel;
@synthesize addressLabel;
@synthesize cardNoLabel;
@synthesize emailLabel;
@synthesize mobileLabel;
@synthesize luckDrawLabel;
@synthesize redeemLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    JASidePanelController *rootViewController = (JASidePanelController *)delegate.window.rootViewController;
    
    UIViewController *buttonController = self;
    if ([buttonController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)buttonController;
        if ([nav.viewControllers count] > 0) {
            buttonController = [nav.viewControllers objectAtIndex:0];
        }
    }
    buttonController.navigationItem.leftBarButtonItem = [rootViewController leftButtonForCenterPanel];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    nameLabel.text = [defaults stringForKey:@"name"];
    NSString *gender = [defaults stringForKey:@"gender"];
    if ([gender isEqualToString:@"M"]) {
        genderLabel.text = @"Male";
    } else {
        genderLabel.text = @"Female";
    }

    birthDateLabel.text = [Util formatXmlDate:[defaults stringForKey:@"birthDate"]];
    addressLabel.text = [defaults stringForKey:@"address"];
    cardNoLabel.text = [defaults stringForKey:@"cardNo"];
    emailLabel.text = [defaults stringForKey:@"email"];
    mobileLabel.text = [defaults stringForKey:@"mobile"];
    luckDrawLabel.text = [defaults stringForKey:@"luckDraw"];
    redeemLabel.text = [defaults stringForKey:@"redeemPoint"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
