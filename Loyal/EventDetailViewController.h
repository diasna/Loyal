//
//  EventDetailViewController.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/26/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"
@interface EventDetailViewController : UITableViewController

@property (nonatomic, strong) EventModel *data;

@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
