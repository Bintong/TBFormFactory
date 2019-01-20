//
//  TBTopMainController.h
//  Pods-TBTopPagesController_Example
//
//  Created by BinTong on 2019/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBTopMainController : UIViewController

@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, strong) NSArray *titles;

/** 指示视图的颜色 */
@property (nonatomic, strong) UIColor *indicatorViewColor;
/** segment的背景颜色 */
@property (nonatomic, strong) UIColor *segmentBgColor;
/**
 *  segment每一项的文字颜色
 */
@property (nonatomic, strong) UIColor *titleColor;
/** 选中时的按钮文字颜色 */
@property (nonatomic, strong) UIColor *titleSelectColor;
/** segment每一项的宽 */
@property (nonatomic, assign) CGFloat itemWidth;
/** segment每一项的高 */
@property (nonatomic, assign) CGFloat itemHeight;

@end

NS_ASSUME_NONNULL_END
