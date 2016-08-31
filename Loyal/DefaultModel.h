//
//  DefaultModel.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/19/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *payment;
@property (nonatomic, copy) NSString *promoStart;
@property (nonatomic, copy) NSString *promoEnd;
@property (nonatomic, copy) NSData *image;
@end
