//
//  VoucherDetailViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/26/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "VoucherDetailViewController.h"
#import "Util.h"
@interface VoucherDetailViewController ()

@end

@implementation VoucherDetailViewController

@synthesize data;
@synthesize navTitle;
@synthesize imgView;
@synthesize qtyLabel;
@synthesize pointLabel;
@synthesize priceLabel;

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
    [imgView setImage:[UIImage imageWithData:data.image]];
    navTitle.title = data.name;
    qtyLabel.text = [NSString stringWithFormat:@"%@", data.qty];
    pointLabel.text = [NSString stringWithFormat:@"%@", data.point];
    priceLabel.text = [NSString stringWithFormat:@"Rp. %@", [Util formatDecimal:data.price]];
}

@end
