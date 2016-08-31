//
//  ProfileViewController.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/21/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *luckDrawLabel;
@property (weak, nonatomic) IBOutlet UILabel *redeemLabel;


@end
