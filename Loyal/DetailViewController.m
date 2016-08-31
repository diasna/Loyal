//
//  DetailViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/20/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "DetailViewController.h"
#import "Util.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize data;
@synthesize imageView;
@synthesize navTitle;
@synthesize labelDesc;
@synthesize labelLocation;
@synthesize labelPayment;
@synthesize labelPromoEnd;
@synthesize labelPromoStart;

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
    [imageView setImage:[UIImage imageWithData:data.image]];
    [navTitle setTitle:data.name];
    [labelDesc setText:data.desc];
    [labelLocation setText:data.location];
    [labelPayment setText:data.payment];
    [labelPromoStart setText:[Util formatXmlDate:data.promoStart]];
    [labelPromoEnd setText:[Util formatXmlDate:data.promoEnd]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
