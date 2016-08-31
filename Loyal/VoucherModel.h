//
//  VoucherModel.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/20/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoucherModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSData *image;
@property (nonatomic, copy) NSNumber *qty;
@property (nonatomic, copy) NSNumber *point;
@property (nonatomic, copy) NSNumber *price;
@end
