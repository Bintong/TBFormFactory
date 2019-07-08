//
//  CLTimeSelectView.m
//  salesPerson
//
//  Created by BinTong on 2019/6/10.
//  Copyright © 2019 北京舟济科技有限公司. All rights reserved.
//

#import "CLTimeSelectView.h"
#import "UILabel+wpadd.h"

#import "LMPickerManager.h"
#import "NSDate+TZDateString.h"

#define kButtonCount 4

@interface CLTimeSelectView()

@property (nonatomic, strong) UIButton *buttonBgView;
@property (nonatomic, strong) UIView *bgV;
@property (nonatomic,copy) void(^backBlock)(id object);
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, copy) NSString *localServiceString;
@property (nonatomic, strong) UIButton *beginTimeButton;
@property (nonatomic, strong) UIButton *endTimeButton;

@property (nonatomic, copy) NSString *startSelectedTimeString;
@property (nonatomic, copy) NSString *endSelectedTimeString;
@end

@implementation CLTimeSelectView

+ (CLTimeSelectView *)sharedView {
    static dispatch_once_t predicate;
    static CLTimeSelectView *alert = nil;
    dispatch_once(&predicate, ^{
        alert = [[CLTimeSelectView alloc] init];
        [alert buildUI];
    });
    return alert;
}

- (NSString *)localServiceString {
    if (_localServiceString == nil || _localServiceString.length == 0) {
        NSString *dataString  = [NSDate stringWithYearMonthDayHourMinusSecondsWithDate:[NSDate date]];
        
        return dataString;
    }else {
        return _localServiceString;
    }
    
}


- (void)buildUI {
    self.buttons = [NSMutableArray array];
    _buttonBgView = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonBgView.frame = [[UIScreen mainScreen] bounds];
    _buttonBgView.backgroundColor = [UIColor blackColor];
    _buttonBgView.alpha = 0.6f;
    [_buttonBgView addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonBgView];
    
    _bgV = [[UIView alloc]initWithFrame:CGRectMake(0, -196, ScreenWidth, 196)];
    _bgV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgV];
    [self showAnimation];
    
    //
    UILabel *quickLabel = [UILabel bold_labelWithFontSize:15 FontColor:[UIColor sd_colorWithHex:0x22222] frame:CGRectMake(15, 20, ScreenWidth - 40, 16) Text:@"快捷操作"];
    [_bgV addSubview:quickLabel];
    
    [self.buttons addObject:[self createButton:@"今天" index:1]];
    [self.buttons addObject:[self createButton:@"昨天" index:2]];
    [self.buttons addObject:[self createButton:@"本周" index:3]];
    [self.buttons addObject:[self createButton:@"上周" index:4]];
    
    for (UIButton *bt in self.buttons) {
        [_bgV addSubview:bt];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 97, ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [_bgV addSubview:lineView];
    
    UILabel *customLabel  = [UILabel bold_labelWithFontSize:15 FontColor:[UIColor sd_colorWithHex:0x22222] frame:CGRectMake(15, 118, ScreenWidth - 40, 16) Text:@"自定义"];
    [_bgV addSubview:customLabel];
    
    //time
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(15, 148, 100, 27);
    startButton.layer.cornerRadius = 3;
    [startButton setBackgroundImage:[UIImage imageFromColor:[UIColor sd_colorWithHex:0xF2F1F2]] forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor sd_colorWithHex:0x333333] forState:UIControlStateNormal];
    startButton.layer.borderColor = [UIColor sd_colorWithHex:0xF2F1F2].CGColor;
    startButton.layer.borderWidth = 1;
    startButton.layer.masksToBounds = YES;
    [startButton setTitle:@"开始时间" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:13];

    _beginTimeButton = startButton;
    [startButton addTarget:self action:@selector(selectBeginTime:) forControlEvents:UIControlEventTouchUpInside];
    [_bgV addSubview:startButton];
    
    
    UIView *lineView_time = [[UIView alloc] initWithFrame:CGRectMake(_beginTimeButton.right + 6, startButton.top + startButton.height/2, 8, 1)];
    lineView_time.backgroundColor = [UIColor sd_colorWithHex:0x333333];

    [_bgV addSubview:lineView_time];
    
    
    UIButton *endButton = [UIButton buttonWithType:UIButtonTypeCustom];
    endButton.frame = CGRectMake(startButton.right + 20, 148, 100, 27);
    endButton.layer.cornerRadius = 3;
    [endButton setBackgroundImage:[UIImage imageFromColor:[UIColor sd_colorWithHex:0xF2F1F2]] forState:UIControlStateNormal];
    [endButton setTitleColor:[UIColor sd_colorWithHex:0x333333] forState:UIControlStateNormal];
    endButton.layer.borderColor = [UIColor sd_colorWithHex:0xF2F1F2].CGColor;
    endButton.layer.borderWidth = 1;
    endButton.layer.masksToBounds = YES;
    [endButton setTitle:@"结束时间" forState:UIControlStateNormal];
    endButton.titleLabel.font = [UIFont systemFontOfSize:13];

    _endTimeButton = endButton;
    [endButton addTarget:self action:@selector(selectEndTime:) forControlEvents:UIControlEventTouchUpInside];
    [_bgV addSubview:endButton];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(ScreenWidth - 15 - 100, 148, 100, 27);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(makeSure:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [sureButton setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor sd_colorWithHex:0x02964B] forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 3;
    sureButton.layer.borderColor = [UIColor sd_colorWithHex:0x02964B].CGColor;
    sureButton.layer.borderWidth = 1;
    sureButton.layer.masksToBounds = YES;
    [_bgV addSubview:sureButton];
    
}

- (UIButton *)createButton:(NSString *)title index:(NSInteger)index{
    NSInteger width = ((ScreenWidth - 30) - 8*(kButtonCount-1))/kButtonCount;
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(15 + (index-1) * (width + 8), 50, width, 27)];
    [bt setBackgroundColor:[UIColor whiteColor]];
    [bt setTitle:title forState:UIControlStateNormal];
    bt.tag = index * 1000;
    [bt addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    [bt setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [bt setBackgroundImage:[UIImage imageFromColor:[UIColor sd_colorWithHex:0x02964B]] forState:UIControlStateSelected];
    [bt setTitleColor:[UIColor sd_colorWithHex:0x333333] forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    bt.titleLabel.font = [UIFont systemFontOfSize:13];
    bt.layer.cornerRadius = 3;
    bt.layer.borderColor = [UIColor sd_colorWithHex:0x656565].CGColor;
    bt.layer.borderWidth = 1;
    bt.layer.masksToBounds = YES;

    return bt;
}


- (void)actionButton:(UIButton *)sender{

    if (!sender.selected) {
        [sender setSelected:!sender.selected];
    }
    
    for (UIButton *bt in self.buttons) {
        if (bt.tag == sender.tag) {
            bt.layer.borderColor = [UIColor sd_colorWithHex:0x02964B].CGColor;
            continue;
        }else {
            bt.layer.borderColor = [UIColor sd_colorWithHex:0x656565].CGColor;
            [bt setSelected:NO];
        }
    }
    
    [self.beginTimeButton setTitle:@"开始时间" forState:UIControlStateNormal];
    [self.endTimeButton setTitle:@"结束时间" forState:UIControlStateNormal];
    self.endSelectedTimeString = nil;
    self.startSelectedTimeString = nil;
    if (_block) {
        //今天
        if (sender.tag == 1000) {
            
            NSTimeInterval end  = [NSDate timeFromString:self.localServiceString format:@"YYYY-MM-dd HH:mm:ss"];
            NSString *endString = [NSDate stringWithYearMonthDayHourMinusSecondsWithDate:[NSDate dateWithTimeIntervalSince1970:end]];//2019-01-11 14:55
            NSString *beginString = [self cutTimeHourAndSeconds:self.localServiceString];
            self.block(beginString, endString);
        }else if (sender.tag == 2000) {
            //昨天
            NSString *end_0_0 = [self cutTimeHourAndSeconds:self.localServiceString];//2019-01-11 00:00
            NSTimeInterval end_0_0_timeInterval = [NSDate timeFromString:end_0_0 format:@"YYYY-MM-dd HH:mm:ss"];
            NSTimeInterval end_interval = end_0_0_timeInterval;//2019-01-10 00:00
            NSString *endString = [NSDate stringWithYearMonthDayHourMinusSecondsWithDate:[NSDate dateWithTimeIntervalSince1970:end_interval]];
            
            NSString *beginString = [NSDate stringWithYearMonthDayHourMinusSecondsWithDate:[NSDate dateWithTimeIntervalSince1970:end_interval - 24 * 60 * 60]];
            self.block(beginString, end_0_0);
        } else if (sender.tag == 3000){
            //本周

            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss "];
            NSDate *date = [dateFormatter dateFromString:self.localServiceString];
            
            NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @(7), @(1), @(2), @(3), @(4), @(5), @(6), nil];
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
            [calendar setTimeZone: timeZone];
            NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
            NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
            NSInteger days = [[weekdays objectAtIndex:theComponents.weekday] integerValue];
            
            NSTimeInterval end  = [NSDate timeFromString:self.localServiceString format:@"YYYY-MM-dd HH:mm:ss"];
            NSString *beginString = [NSDate stringWithYearMonthDayHourMinusSecondsWithDate:[NSDate dateWithTimeIntervalSince1970:end - 24 * 60 * 60 * (days-1)]];
            NSString *endString = [NSDate stringWithYearMonthDayHourMinusSecondsWithDate:[NSDate dateWithTimeIntervalSince1970:end + 24 * 60 * 60 * (7 - days + 1)]];
            
            self.block([self cutTimeHourAndSeconds:beginString], [self cutTimeHourAndSeconds:endString]);
            
        } else if (sender.tag == 4000){
            // 上周
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date = [dateFormatter dateFromString:self.localServiceString];
            
            NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @(7), @(1), @(2), @(3), @(4), @(5), @(6), nil];
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
            [calendar setTimeZone: timeZone];
            NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
            NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
            NSInteger days = [[weekdays objectAtIndex:theComponents.weekday] integerValue] - 1;
            
            NSTimeInterval end  = [NSDate timeFromString:self.localServiceString format:@"YYYY-MM-dd HH:mm:ss"];
            NSString *endString = [NSDate stringWithYearMonthDayHourMinusSecondsWithDate:[NSDate dateWithTimeIntervalSince1970:end - 24 * 60 * 60 * (days)]];
            NSString *beginString = [NSDate stringWithYearMonthDayHourMinusSecondsWithDate:[NSDate dateWithTimeIntervalSince1970:end - 24 * 60 * 60 * days - 7* 24 * 60 * 60]];
            
            self.block([self cutTimeHourAndSeconds:beginString], [self cutTimeHourAndSeconds:endString]);

        }
    }
    [self hideAnimation];
}

- (void)showAnimation{
    self.bgV.top = -196;
    [UIView animateWithDuration:0.4 animations:^{
        self.bgV.top = 0;
    }];
}


- (void)hideAnimation {
    [self removeFromSuperview];
}

+ (void)hideAnimationFromView:(UIView *)view  {
    [[CLTimeSelectView sharedView] removeFromSuperview];
}

+ (CLTimeSelectView *)buildTimeSelectdatView:(UIView *)view andLocalTime:(NSString *)locTime CallBack:(TimeSelectedBlock)callBack {
    CLTimeSelectView *pic = [CLTimeSelectView sharedView];
    pic.frame = CGRectMake(0,0,ScreenWidth,ScreenHeight);
    pic.block = callBack;
    pic.localServiceString = locTime;
    [view addSubview:pic];
    return pic;
}


- (void)selectBeginTime:(id)sender {
    [LMPickerManager sharedView].titleString = @"选择时间";

    [LMPickerManager buildDatePickerDefultDate:0  atView:self CallBack:^(id object) {
        NSDate *d = (NSDate *)object;
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        dateFormatter.dateFormat = @"MM/dd HH:mm";
        NSString *currentDateStr = [dateFormatter stringFromDate:d];
        NSLog(@"start的时间: %@",currentDateStr);
        [self.beginTimeButton setTitle:currentDateStr forState:UIControlStateNormal];
        
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        df.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        df.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        self.startSelectedTimeString = [df stringFromDate:d];
        
    }];
}

- (void)selectEndTime:(id)sender {
    [LMPickerManager sharedView].titleString = @"选择时间";

    [LMPickerManager buildDatePickerDefultDate:0  atView:self CallBack:^(id object) {
        NSDate *d = (NSDate *)object;
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        dateFormatter.dateFormat = @"MM/dd HH:mm";
        NSString *currentDateStr = [dateFormatter stringFromDate:d];
        NSLog(@"start的时间: %@",currentDateStr);
        [self.endTimeButton setTitle:currentDateStr forState:UIControlStateNormal];
        
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        df.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        df.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        self.endSelectedTimeString = [df stringFromDate:d];
    }];

}

- (void)makeSure:(id)sender {
    if ((self.startSelectedTimeString !=nil && self.startSelectedTimeString.length > 0) &&
        self.endSelectedTimeString !=nil && self.endSelectedTimeString.length > 0) {
        
        NSTimeInterval star  = [NSDate timeFromString:self.startSelectedTimeString format:@"YYYY-MM-dd HH:mm:ss"];
        NSTimeInterval end  = [NSDate timeFromString:self.endSelectedTimeString format:@"YYYY-MM-dd HH:mm:ss"];
        if (star >= end) {
//            [SVProgressHUD showInfoWithStatus:@"结束时间应大余开始时间"];
            return;
        }else {
            if (self.block) {
                _block(self.startSelectedTimeString,self.endSelectedTimeString);
            }
        }
        for (UIButton *bt in self.buttons) {
            [bt setSelected:NO];
        }
        [self hideAnimation];
    }else if ((self.startSelectedTimeString == nil || self.startSelectedTimeString.length == 0)) {
//        [SVProgressHUD showInfoWithStatus:@"请选择开始时间"];
    }else if (self.endSelectedTimeString ==nil || self.endSelectedTimeString.length == 0) {
//        [SVProgressHUD showInfoWithStatus:@"请选择结束时间"];
    }
    
    
    
}

- (NSString *)cutTimeHourAndSeconds:(NSString *)fromTimeString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:fromTimeString];
    
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    [dateF setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString =  [dateF stringFromDate:date];
    //
    NSTimeInterval begin  = [NSDate timeFromString:beginString format:@"yyyy-MM-dd"];
    
    
    NSString *beginString_f = [NSDate stringWithYearMonthDayHourMinusSecondsWithDate:[NSDate dateWithTimeIntervalSince1970:begin]]; //2019-01-11 00:00
    return beginString_f;
}



@end
