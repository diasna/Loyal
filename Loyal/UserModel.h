//
//  UserModel.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/21/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *birthdate;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *cardNo;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *custSeqNo;
@property (nonatomic, copy) NSString *pNum;
@property (nonatomic, copy) NSString *pType;

@property (nonatomic, copy) NSNumber *luckyDraw;
@property (nonatomic, copy) NSNumber *redeemPoint;
@end
