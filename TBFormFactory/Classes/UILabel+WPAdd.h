//
//  UILabel+WPAdd.h
//  BMWorkVisitor_Example
//
//  Created by BinTong on 2018/5/7.
//  Copyright © 2018年 yaxun_123@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WPAdd)
+ (UILabel *)labelWithFontSize:(int)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text;



+ (UILabel *)labelSizeToFitWithFontSize:(int)fontSize FontColor:(UIColor *)fontColor text:(NSString *)text top:(CGFloat)top left:(CGFloat)left ;



//行间距
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

@end
