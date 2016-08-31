//
//  VoucherCell.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/20/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoucherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *qtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
