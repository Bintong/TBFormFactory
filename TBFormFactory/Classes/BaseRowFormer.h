//
//  BaseRowFormer.h
//  Pods-TBFormFactory_Example
//
//  Created by BinTong on 2019/1/20.
//

#import <Foundation/Foundation.h>
#import "BaseRowFormItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseRowFormer : NSObject

/**
 Height:高度
 */
@property (nonatomic,assign) NSInteger height;

/**
 是否显示左边icon
 */
@property (nonatomic,assign) BOOL showLeftIcon;

/**
 左边间隔
 */
@property (nonatomic,assign) NSInteger leftInterval;

/**
 图片文案间隔
 */
@property (nonatomic,assign) NSInteger imgToLabInterval;

/**
 中间文案间隔
 */
@property (nonatomic,assign) NSInteger titleToContentInterval;

/**
 是否有箭头
 */
@property (nonatomic,assign) BOOL showAccessoryView;



//------------COLOR--------------------
/**
 title Label text Color
 */
@property (nonatomic, assign) UIColor *titleLabelColor;
@property (nonatomic, assign) UIColor *rowBackgroundColor;
@property (nonatomic, assign) UIColor *bottomLineColor;
//------------Line--------------------
@property (nonatomic, assign) BOOL showLine;
@property (nonatomic, assign) NSInteger leftOffSet;
@property (nonatomic, assign) NSInteger rightOffSet;


+ (BaseRowFormItem *)buildNormalText:(NSString *)leftName placeHolder:(NSString *)placeHolder target:(id)sender;

@end

NS_ASSUME_NONNULL_END
