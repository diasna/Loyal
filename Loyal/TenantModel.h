//
//  TenantModel.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/20/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TenantModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSData *image;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *phone;
@end
