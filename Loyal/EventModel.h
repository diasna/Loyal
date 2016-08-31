//
//  EventModel.h
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/20/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSData *image;
@property (nonatomic, copy) NSString *synopsis;
@property (nonatomic, copy) NSString *eventToDate;
@property (nonatomic, copy) NSString *eventFromDate;
@property (nonatomic, copy) NSString *eventToTime;
@property (nonatomic, copy) NSString *eventFromTime;
@end
