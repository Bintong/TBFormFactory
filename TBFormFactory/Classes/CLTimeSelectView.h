//
//  CLTimeSelectView.h
//  salesPerson
//
//  Created by BinTong on 2019/6/10.
//  Copyright © 2019 北京舟济科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TimeSelectedBlock)(NSString *startTimeStr,NSString *endTimeStr);


@interface CLTimeSelectView : UIView

@property (nonatomic, copy) TimeSelectedBlock block;


+ (void)hideAnimationFromView:(UIView *)view ;

//+ (CLTimeSelectView *)sharedView;



/**
 时间筛选控件

 @param view 显示在哪个view 上
 @param locTime 本地服务器时间
 @param callBack 选择后回掉
 @return CLTimeSelectView 对象 目前没用 为后来产品设计脑洞做b准备
 */
+ (CLTimeSelectView *)buildTimeSelectdatView:(UIView *)view andLocalTime:(NSString *)locTime CallBack:(TimeSelectedBlock)callBack;

@end



