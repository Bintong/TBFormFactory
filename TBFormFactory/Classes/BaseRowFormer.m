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
        _height = 44;
        _showLeftIcon = NO;
        _leftInterval =  16;
        _imgToLabInterval = 8;
        _titleToContentInterval = 8;
        _showAccessoryView = NO;
        _titleLabelColor = [UIColor blackColor];
        _rowBackgroundColor = [UIColor whiteColor];
        _showLine = YES;
        _leftOffSet = 50;
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

    if (former.leftInterval > 0) {
        [item bottomLineX:former.leftOffSet width:(kScreenWidth - former.leftOffSet) color:TBColorFromRGB(0xe1e6ed)];
    }
    
    return item;
}


@end
