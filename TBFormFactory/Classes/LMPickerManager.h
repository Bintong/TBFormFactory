//
//  LMPickerManager.h
//  HBFastLoan
//
//  Created by BinTong on 2017/5/8.
//  Copyright © 2017年 HBFastLoan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UILabel+WPAdd.h"

@interface PickerChoiceView : UIView

@property(nonatomic, strong) NSArray *dataArray;

@end


@interface LMPickerManager : NSObject

@property(nonatomic, copy) NSString *titleString;


- (void)hideAnimation;

+ (LMPickerManager *)sharedView;

+ (void)buildDatePickerDefultDate:(NSInteger )dateInterval CallBack:(void(^)(id object))callBack;

+ (void)buildDatePickerDefultDate:(NSInteger )dateInterval atView:(UIView *)view CallBack:(void(^)(id object))callBack;

@end
