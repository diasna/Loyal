//
//  LoginViewController.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/21/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)signInBtnClick:(id)sender;

- (void)_changeCenterPanelTapped:(UIViewController*)uiViewController;

@end
