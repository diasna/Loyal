//
//  DetailViewController.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/20/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultModel.h"
@interface DetailViewController : UITableViewController

@property (nonatomic, strong) DefaultModel *data;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelPayment;
@property (weak, nonatomic) IBOutlet UILabel *labelPromoStart;
@property (weak, nonatomic) IBOutlet UILabel *labelPromoEnd;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;

@end
