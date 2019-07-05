//
//  LMTimeDateManager.h
//  NewConnect
//
//  Created by BinTong on 2018/4/8.
//  Copyright © 2018年 connect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMTimeDateManager : NSObject

+(NSInteger)getNowTimestamp;
//斜线格式
+(NSString *)timestampSwitchSlashTime:(NSInteger)timestamp;
//将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime;
//将某个时间戳转化成 时间
+(NSString *)timestampSwitchTime:(NSInteger)timestamp;

//将 timestamp to date
+(NSDate *)timestampSwitchTimeToDate:(NSInteger)timestamp;

//优化后的格式
+ (NSString *)stringFromTimestamp:(NSInteger)timestamp;
@end
