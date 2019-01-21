//
//  UIView+WPDrawLine.m
//  Pods-TBFormFactory_Example
//
//  Created by BinTong on 2019/1/20.
//

#import "UIView+WPDrawLine.h"

#import "UIView+WPCoordinate.h"

@implementation UIView (WPDrawLine)

- (void)drawX:(CGFloat)x lineY:(CGFloat)y width:(CGFloat)width color:(UIColor *)color value:(UIViewAutoresizing)value {
    
    if (!color)
    {
        color = kLineColor;
    }
    
    CGRect rect = CGRectMake(x,y,width,kLineSpace);
    UIView *lineView = [[UIView alloc] initWithFrame:rect];
    lineView.autoresizingMask = value;
    lineView.userInteractionEnabled = NO;
    lineView.backgroundColor = color;
    
    if ([self isKindOfClass:[UITableViewCell class]])
    {
        [[(UITableViewCell *)self contentView] addSubview:lineView];
    }
    else
    {
        [self addSubview:lineView];
    }
    
}

- (void)bottomLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color {
    
    [self drawX:x lineY:self.height-kLineSpace width:width color:color value:UIViewAutoresizingFlexibleTopMargin];
}

@end
