//
//  UIView+WPDrawLine.h
//  Pods-TBFormFactory_Example
//
//  Created by BinTong on 2019/1/20.
//

#import <UIKit/UIKit.h>
#define kLineSpace  (2.0/[UIScreen mainScreen].scale)

#define kLineColor  [UIColor redColor]//[UIColor colorWithRed:((float)((0xDCDCDC & 0xFF0000) >> 16))/255.0 green:((float)((0xDCDCDC & 0xFF00) >> 8))/255.0 blue:((float)(0xDCDCDC & 0xFF))/255.0 alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WPDrawLine)

- (void)drawX:(CGFloat)x lineY:(CGFloat)y width:(CGFloat)width color:(UIColor *)color value:(UIViewAutoresizing)value;

- (void)bottomLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
