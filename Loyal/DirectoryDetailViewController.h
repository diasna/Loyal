//
//  DirectoryDetailViewController.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/25/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TenantModel.h"
@interface DirectoryDetailViewController : UITableViewController

@property (nonatomic, strong) TenantModel *data;

@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
