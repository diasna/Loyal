//
//  Util.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/26/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "Util.h"

@implementation Util
+ (NSString*)formatXmlDate :(NSString*)date
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyy-MM-dd'T'HH:mm:ss"];
    NSDate *inputDate = [inputFormatter dateFromString:date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    //[outputFormatter setDateFormat:@"E, d LLL yyyy"];
    [outputFormatter setDateFormat:@"d LLL yyyy"];
    NSString *outputDate = [outputFormatter stringFromDate:inputDate];
    return outputDate;
}
+ (NSString*)formatDecimal:(NSNumber *)source
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:source];
    return numberAsString;
}
@end
