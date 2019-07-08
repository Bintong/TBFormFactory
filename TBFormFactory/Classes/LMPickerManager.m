//
//  HBPickerManager.m
//  HBFastLoan
//
//  Created by BinTong on 2017/5/8.
//  Copyright © 2017年 HBFastLoan. All rights reserved.
//

#import "LMPickerManager.h"
#import "objc/runtime.h"

#import "LMTimeDateManager.h"


#define hScale 1
@interface PickerChoiceView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bgV;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *conpleteBtn;
@property (nonatomic, strong) UIPickerView *pickerV;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic,strong) UIButton *buttonBgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSString *titleString;


@property(nonatomic, strong) NSMutableArray *addressArr;
@property (nonatomic,copy) void(^backBlock)(id object);
@property(nonatomic, assign) NSInteger normlRow;
@property (nonatomic,assign) NSInteger defaultInterval;

@end

@implementation PickerChoiceView



- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _array = [NSMutableArray array];
        _addressArr = [NSMutableArray array];
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        _buttonBgView = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonBgView.frame = [[UIScreen mainScreen] bounds];
        _buttonBgView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_buttonBgView];
        
        _bgV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 250*hScale)];
        _bgV.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgV];
        
        //title
        self.titleLabel = [UILabel bold_labelWithFontSize:16 FontColor:[UIColor blackColor] frame:CGRectMake(0, 0, ScreenWidth, 50) Text:@""];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bgV addSubview:self.titleLabel];
        [self showAnimation];
        
        //取消
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(15, 10, 70, 32);
        [_bgV addSubview:_cancelBtn];
        
        
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn setTitle:@"取消"  forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitleColor:[UIColor sd_colorWithHex:0x999999] forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor sd_colorWithHex:0xF6F6F6]];
        _cancelBtn.layer.cornerRadius = 16;
        _cancelBtn.layer.masksToBounds = YES;
        //完成
        _conpleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _conpleteBtn.frame = CGRectMake(ScreenWidth - 70 - 15 ,10 , 70, 32);
        [_bgV addSubview:_conpleteBtn];
        
        _conpleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_conpleteBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_conpleteBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_conpleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_conpleteBtn setBackgroundColor:[UIColor sd_colorWithHex:0x03A35C]];
        
        _conpleteBtn.layer.cornerRadius = 16;
        _conpleteBtn.layer.masksToBounds = YES;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, 1)];
        lineView.backgroundColor = [UIColor sd_colorWithHex:0xF6F6F6];
        [_bgV addSubview:lineView];
        
        //选择器
        
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.frame = CGRectMake(0, _cancelBtn.bottom, ScreenWidth, _bgV.height - _cancelBtn.height - 10);
        NSString *language = [NSLocale preferredLanguages].firstObject;
        
        
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
        _datePicker.locale = locale;
        
        
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        
        [_datePicker addTarget:self action:@selector(dateValueChange:) forControlEvents:UIControlEventValueChanged];
        [_bgV addSubview:_datePicker];
        
        unsigned int count = 0;
        objc_property_t *propertys = class_copyPropertyList([UIDatePicker class], &count);
        for(int i = 0;i < count;i ++){
            
            //获得每一个属性
            objc_property_t property = propertys[i];
            //获得属性对应的nsstring
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            //输出打印看对应的属性
            NSLog(@"propertyname = %@",propertyName);
        }
    }
    return self;
}

- (void)setDefaultInterval:(NSInteger)defaultInterval {
    if (defaultInterval > 0) {
        _defaultInterval = defaultInterval;
        _datePicker.date = [LMTimeDateManager timestampSwitchTimeToDate:defaultInterval];
    }
}

- (void)showAnimation{
    self.bgV.top = ScreenHeight;
    [UIView animateWithDuration:0.4 animations:^{
        self.bgV.top = ScreenHeight - 250*hScale - BOTTOM_HEIGHT - 44;
    }];
}

//隐藏动画
- (void)hideAnimation{
    self.addressArr = nil;
    self.array = nil;
    self.dataArray = nil;
    [self removeFromSuperview];
}

- (void)cancelBtnClick{
    [self hideAnimation];
}

- (void)dateValueChange:(id)sender {
    
}


#pragma mark-----UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.array.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    return arr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 34;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor sd_colorWithHex:0xDCDCDC];
        }
    }
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / self.array.count, 34)];
    //    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor sd_colorWithHex:0x222933];
    label.font = [UIFont systemFontOfSize:16];
    
    
    return label;
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.array.count > 0){
        return ScreenWidth/self.array.count;
    }else{
        return 0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%s",__func__);
    return;
    
}

- (void)completeBtnClick{
    self.backBlock(self.datePicker.date);
    [self hideAnimation];
    return;
}

- (void)updateAddress {
    
}

@end

@interface LMPickerManager ()

@end

@implementation LMPickerManager

+ (LMPickerManager *)sharedView {
    static dispatch_once_t predicate;
    static LMPickerManager *alert = nil;
    dispatch_once(&predicate, ^{
        alert = [[LMPickerManager alloc] init];
    });
    return alert;
}



+ (void)buildDatePickerDefultDate:(NSInteger )dateInterval CallBack:(void(^)(id object))callBack {
    PickerChoiceView *pic = [[PickerChoiceView alloc] initWithFrame:CGRectMake(0,0,ScreenWidth,ScreenHeight)];
    
    pic.defaultInterval = dateInterval;
    pic.titleString = [LMPickerManager sharedView].titleString;
    pic.backBlock = callBack;
    pic.titleLabel.text = [LMPickerManager sharedView].titleString;
    UIView * _parentView = nil;
    NSArray* windows = [UIApplication sharedApplication].windows;
    UIWindow *_window = [windows objectAtIndex:0];
    if(_window.subviews.count > 0){
        _parentView = [_window.subviews objectAtIndex:0];
    }
    [_parentView addSubview:pic];
}


+ (void)buildDatePickerDefultDate:(NSInteger )dateInterval atView:(UIView *)view CallBack:(void(^)(id object))callBack {
    PickerChoiceView *pic = [[PickerChoiceView alloc] initWithFrame:CGRectMake(0,0,ScreenWidth,ScreenHeight)];
    
    pic.defaultInterval = dateInterval;
    pic.titleString = [LMPickerManager sharedView].titleString;
    pic.backBlock = callBack;
    pic.titleLabel.text = [LMPickerManager sharedView].titleString;
    
    [view addSubview:pic];
}


@end

