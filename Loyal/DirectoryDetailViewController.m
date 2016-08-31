//
//  DirectoryDetailViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/25/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "DirectoryDetailViewController.h"

@interface DirectoryDetailViewController ()

@end

@implementation DirectoryDetailViewController

@synthesize data;
@synthesize navTitle;
@synthesize imgView;
@synthesize descLabel;
@synthesize locationLabel;
@synthesize phoneLabel;

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
    descLabel.text = data.desc;
    locationLabel.text = data.location;
    phoneLabel.text = data.phone;
    [imgView setImage:[UIImage imageWithData:data.image]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
