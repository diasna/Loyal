//
//  NavigationViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/20/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "NavigationViewController.h"
#import "JASidePanelController.h"
@interface NavigationViewController ()

@end

@implementation NavigationViewController
{
    NSUserDefaults *defaults;
    NSString *token;
    UIAlertView *alertWarning;
}

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
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
            [self _changeCenterPanelTapped:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
            break;
        case 2:
            [self _changeCenterPanelTapped:[self.storyboard instantiateViewControllerWithIdentifier:@"directoryViewController"]];
            break;
        case 3:
            [self _changeCenterPanelTapped:[self.storyboard instantiateViewControllerWithIdentifier:@"promoViewController"]];
            break;
        case 4:
            [self _changeCenterPanelTapped:[self.storyboard instantiateViewControllerWithIdentifier:@"eventViewController"]];
            break;
        case 5:
            [self _changeCenterPanelTapped:[self.storyboard instantiateViewControllerWithIdentifier:@"voucherViewController"]];
            break;
        case 6:
            defaults = [NSUserDefaults standardUserDefaults];
            token = [defaults stringForKey:@"token"];
            if ([token length] != 0)
            {
                [self _changeCenterPanelTapped:[self.storyboard instantiateViewControllerWithIdentifier:@"accountViewController"]];
            } else {
                [self _changeCenterPanelTapped:[self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"]];
            }
            break;
        case 7:
            defaults = [NSUserDefaults standardUserDefaults];
            token = [defaults stringForKey:@"token"];
            if ([token length] != 0) {
                [defaults removeObjectForKey:@"token"];
                [defaults synchronize];
                [self _changeCenterPanelTapped:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
                alertWarning = [[UIAlertView alloc]
                                initWithTitle:nil
                                message:@"Logout Success"
                                delegate:nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil];
            } else {
                alertWarning = [[UIAlertView alloc]
                                initWithTitle:nil
                                message:@"You must login first"
                                delegate:nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil];
            }
            [alertWarning show];
            break;
        default:
            break;
    }
}

- (void)_changeCenterPanelTapped:(UIViewController*)uiViewController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ((JASidePanelController *)window.rootViewController).centerPanel = uiViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
