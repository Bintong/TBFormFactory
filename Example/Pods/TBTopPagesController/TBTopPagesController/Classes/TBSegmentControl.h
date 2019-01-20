//
//  TBSegmentControl.h
//  Pods-TBTopPagesController_Example
//
//  Created by BinTong on 2019/1/17.
//

#import <UIKit/UIKit.h>

@class TBSegmentControl;

NS_ASSUME_NONNULL_BEGIN
#pragma mark - JRSegmentButton
@interface TBSegmentButton : UIButton

@end


@protocol TBSegmentControlDelegate <NSObject>

/** 选中某个按钮时的代理回调 */
- (void)segmentControl:(TBSegmentControl *)segment didSelectedIndex:(NSInteger)index;

@optional

/** 指示视图滑动进度的代理回调 */
- (void)segmentControl:(TBSegmentControl *)segment didScrolledPersent:(CGFloat)persent;

@end

@interface TBSegmentControl : UIView


/**
 *  按钮标题数组
 */
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UIViewController *superViewController;

/** 按钮圆角半径 */
@property (nonatomic, assign) CGFloat cornerRadius;
/** 指示视图的颜色 */
@property (nonatomic, strong) UIColor *indicatorViewColor;
/** 未选中时的按钮文字颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 选中时的按钮文字颜色 */
@property (nonatomic, strong) UIColor *titleSelectColor;

@property (nonatomic, weak) id<TBSegmentControlDelegate> delegate;
@property (nonatomic, strong) UIScrollView *contentScrollView;
/** 设置segment的索引为index的按钮处于选中状态 */
- (void)setSelectedIndex:(NSInteger)index scroll:(BOOL)scroll;
//配制其他
- (void)makeOther;

@end

NS_ASSUME_NONNULL_END
