//
//  UILabel+WPAdd.m
//  BMWorkVisitor_Example
//
//  Created by BinTong on 2018/5/7.
//  Copyright © 2018年 yaxun_123@163.com. All rights reserved.
//

#import "UILabel+WPAdd.h"
#import "UIView+WPCoordinate.h"
@implementation UILabel (WPAdd)
+ (UILabel *)labelWithFontSize:(int)fontSize
                     FontColor:(UIColor *)fontColor
                         frame:(CGRect)frame
                          Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.text = text;
    return lbTitle;
    
}

+ (UILabel *)labelSizeToFitWithFontSize:(int)fontSize FontColor:(UIColor *)fontColor text:(NSString *)text top:(CGFloat)top left:(CGFloat)left {
    UILabel *lbTitle = [[UILabel alloc] init];
    lbTitle.numberOfLines = 0;
    lbTitle.text = text;
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    [lbTitle sizeToFit];
    lbTitle.left = left;
    lbTitle.top = top;
    
    lbTitle.backgroundColor = [UIColor clearColor];
    return lbTitle;
}



+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}
@end
