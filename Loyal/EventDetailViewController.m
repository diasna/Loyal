//
//  EventDetailViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/26/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Util.h"
@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

@synthesize data;
@synthesize navTitle;
@synthesize imgView;
@synthesize descLabel;
@synthesize placeLabel;
@synthesize dateLabel;
@synthesize timeLabel;

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
    navTitle.title = data.name;
    [imgView setImage:[UIImage imageWithData:data.image]];
    descLabel.text = data.synopsis;
    placeLabel.text = data.desc;
    dateLabel.text = [NSString stringWithFormat:@"%@ to %@", [Util formatXmlDate:data.eventFromDate],[Util formatXmlDate:data.eventToDate]];
    timeLabel.text = [NSString stringWithFormat:@"%@ to %@", data.eventFromTime, data.eventToTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
