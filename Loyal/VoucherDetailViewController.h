//
//  VoucherDetailViewController.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/26/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoucherModel.h"
@interface VoucherDetailViewController : UITableViewController
@property (nonatomic, strong) VoucherModel *data;
@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *qtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
