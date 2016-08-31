//
//  DefaultCell.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/19/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end
