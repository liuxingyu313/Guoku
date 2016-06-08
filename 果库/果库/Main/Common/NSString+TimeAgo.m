//
//  NSString+TimeAg0.m
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "NSString+TimeAgo.h"
#import "NSDate+TimeAgo.h"

@implementation NSString (TimeAgo)

+ (NSString *)TimeAgo:(NSString *)time {
    //@“格式”
    NSInteger i = [time integerValue];
    NSInteger j = (NSInteger)[[NSDate date] timeIntervalSince1970];
    
    NSInteger y = j - i;
   
    
    if (y < 5) {
        return @"刚刚";
    }else if (y < 60){
        return [NSString stringWithFormat:@"%li秒前",y];
    }else if (y < 60 * 60) {
        return [NSString stringWithFormat:@"%li分钟前",y / 60];
    }else if (y < 60 * 60 *24) {
        return [NSString stringWithFormat:@"%li小时前",y / 60 / 60 ];
    }else if (y < 60 * 60 *24 * 31) {
        return [NSString stringWithFormat:@"%li天前",y / 60 / 60 / 24 ];
    }else if (y < 60 * 60 *24 * 31 * 12) {
        return [NSString stringWithFormat:@"%li月前",y / 60 / 60 / 24 / 31 ];
    }
    
    
    return [NSString stringWithFormat:@"%li年前",y / 60 / 24 / 365];

    
}

+ (NSString *)timeAgo:(NSString *)time {
   //2016-05-13 14：32：33
    NSString *formatter = @"E-M-d HH:mm:ss";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    NSDate *publicDate = [dateFormatter dateFromString:time];
    
    return [publicDate timeAgo];
    
}

@end
