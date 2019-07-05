//
//  BaseRowFormer.m
//  Pods-TBFormFactory_Example
//
//  Created by BinTong on 2019/1/20.
//

#import "BaseRowFormer.h"
#import "UILabel+WPAdd.h"
#import "UIView+WPCoordinate.h"
#import "UIView+WPDrawLine.h"
#import "LMPickerManager.h"
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define TBColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation BaseRowFormer

+ (BaseRowFormer *)sharedBaseRowFormer{
    static BaseRowFormer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _height = 60;
        _showLeftIcon = NO;
        _leftInterval =  16;
        _imgToLabInterval = 8;
        _titleToContentInterval = 8;
        _showAccessoryView = NO;
        _titleLabelColor = [UIColor blackColor];
        _subTitleLabelColor = [UIColor grayColor];
        _rowBackgroundColor = [UIColor whiteColor];
        _showLine = YES;
        _line_leftOffSet = 50;
        _bottomLineColor = TBColorFromRGB(0xE1E6ED);
    }
    return self;
} 


+ (BaseRowFormItem *)buildNormalText:(NSString *)leftName placeHolder:(NSString *)placeHolder target:(id)sender {
    BaseRowFormer *former = [BaseRowFormer sharedBaseRowFormer];
    BaseRowFormItem *item = [[BaseRowFormItem alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, former.height)];
    item.backgroundColor = former.rowBackgroundColor;
    UILabel *titleLabel = [UILabel labelWithFontSize:14 FontColor:former.titleLabelColor frame:CGRectMake(former.leftInterval, 0, 0, former.height) Text:leftName];
    if (!former.showLeftIcon) {
        
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(former.leftInterval, 0, titleLabel.frame.size.width, former.height);
        item.titleLabel = titleLabel;
        [item addSubview:titleLabel];
        
    }
    
    
    UITextField *contentField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabel.right + former.titleToContentInterval, 0, kScreenWidth-former.titleToContentInterval - 2*former.leftInterval, 32)];
    contentField.centerY = titleLabel.centerY;
    item.contentField = contentField;
    
    contentField.placeholder = placeHolder;
    contentField.delegate = sender;
    contentField.font = [UIFont systemFontOfSize:14];
    [item addSubview:contentField];

    if (former.line_leftOffSet > 0) {
        [item bottomLineX:former.line_leftOffSet width:(kScreenWidth - former.line_leftOffSet) color:TBColorFromRGB(0xe1e6ed)];
    }
    
    return item;
}

+ (BaseRowFormItem *)buildNormalTextLabel:(NSString *)leftName subLabel:(NSString *)subTitle target:(id)sender {
    BaseRowFormer *former = [BaseRowFormer sharedBaseRowFormer];
    BaseRowFormItem *item = [[BaseRowFormItem alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, former.height)];
    item.backgroundColor = former.rowBackgroundColor;
    UILabel *titleLabel = [UILabel labelWithFontSize:14 FontColor:former.titleLabelColor frame:CGRectMake(former.leftInterval, 0, 0, former.height) Text:leftName];
    if (!former.showLeftIcon) {
        
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(former.leftInterval, 0, titleLabel.frame.size.width, former.height);
        item.titleLabel = titleLabel;
        [item addSubview:titleLabel];
    }
    
    
    UILabel *subLabel = [UILabel labelWithFontSize:14 FontColor:former.subTitleLabelColor frame:CGRectMake(titleLabel.right + former.titleToContentInterval, 0, kScreenWidth - former.titleToContentInterval - 2* former.leftInterval - titleLabel.width, former.height-1) Text:subTitle];
    subLabel.textAlignment = NSTextAlignmentRight;
    [item addSubview:subLabel];
    
    if (former.line_leftOffSet > 0) {
        [item bottomLineX:former.line_leftOffSet width:(kScreenWidth - former.line_leftOffSet) color:TBColorFromRGB(0xe1e6ed)];
    } else {
        [item bottomLineX:15 width:(kScreenWidth - 30) color:TBColorFromRGB(0xe1e6ed)];

    }

    return item;
}

+ (BaseRowFormItem *)buildXZTextLabel:(NSString *)leftName subLabel:(NSString *)subTitle target:(id)sender {
    BaseRowFormer *former = [BaseRowFormer sharedBaseRowFormer];
    BaseRowFormItem *item = [[BaseRowFormItem alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    item.backgroundColor = [UIColor redColor];
    
    
    return item;
}


@end
