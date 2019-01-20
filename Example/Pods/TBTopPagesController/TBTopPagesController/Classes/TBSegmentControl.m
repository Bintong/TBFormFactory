//
//  TBSegmentControl.m
//  Pods-TBTopPagesController_Example
//
//  Created by BinTong on 2019/1/17.
//

#import "TBSegmentControl.h"
#define DefaultCurrentBtnColor [UIColor blackColor]




@interface TBSegmentButton ()

@end

@implementation TBSegmentButton

- (void)setHighlighted:(BOOL)highlighted {
    // 取消高亮效果
}

@end


@interface TBSegmentControl ()<UIScrollViewDelegate> {
    NSUInteger _btnCount; // 按钮总数
    TBSegmentButton *_currentBtn;   // 指示视图当前所在的按钮
    BOOL _isDrag;
}

@property (nonatomic, strong) UIView *indicatorView; // 指示视图(滑动视图)
@property (nonatomic, strong) NSMutableArray *buttons; // 存放button
@property (nonatomic, assign) CGFloat btnWidth; // 按钮宽度

@end

@implementation TBSegmentControl

@synthesize indicatorViewColor = _indicatorViewColor;


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius  = frame.size.height / 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)makeOther{
    [self setupScrollView:self.superViewController.view];
    [self setupViewControllers:self.superViewController.view];
}

#pragma mark setter/getter方法

/**
 *  设置按钮标题数组--最后一步
 */
- (void)setTitles:(NSArray *)titles
{
    _titles = [titles copy];
    
    _btnCount = [_titles count];
    
    [self createUI];
}

/**
 *  设置圆角半径
 */
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = _cornerRadius;
    _indicatorView.layer.cornerRadius = _cornerRadius;
}

/**
 *  设置保存按钮的数组
 */
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}



/**
 *  设置背景色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    [_currentBtn setBackgroundColor:[UIColor whiteColor]];
}


#pragma mark 创建视图
- (void)createUI
{
    _btnWidth = self.frame.size.width / _btnCount;
    CGFloat btnHeight = self.frame.size.height;
    
    // 创建各个按钮
    for (int i = 0; i < _btnCount; i++)
    {
        TBSegmentButton *btn = [TBSegmentButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(_btnWidth * i, 0, _btnWidth, btnHeight - 4);
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        btn.tag = i;
        
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleColor forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        [self.buttons addObject:btn]; // 加入数组
    }
    
    _currentBtn = (TBSegmentButton *)self.buttons[0];

    if (_titleSelectColor) {
        [_currentBtn setTitleColor:_titleSelectColor forState:UIControlStateNormal];
        [_currentBtn setTitleColor:_titleSelectColor forState:UIControlStateHighlighted];
    }else {
        [_currentBtn setTitleColor:DefaultCurrentBtnColor forState:UIControlStateNormal];
    }
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0,btnHeight - 4, _btnWidth, 4)];

    
    UIView *indicatorSubView = [[UIView alloc] initWithFrame:CGRectMake((_btnWidth - 30)/2, 0, 30, 4)];
    indicatorSubView.backgroundColor = _indicatorViewColor;
    indicatorSubView.layer.cornerRadius = 2;
    
    [_indicatorView addSubview:indicatorSubView];
    [self addSubview:_indicatorView];
}

#pragma mark self的触摸事件处理

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint prevP = [touch previousLocationInView:self];
    
    CGFloat delta = point.x - prevP.x; // 手势改变的x范围
    
    CGRect frame = _indicatorView.frame;
    
    // 限制_indicatorView的滑动范围
    if (frame.origin.x + delta >= 0 && frame.origin.x + delta <= (_btnCount - 1) * _btnWidth) {
        frame.origin = CGPointMake(frame.origin.x + delta, 0);
    }
    
    CGFloat persent = _indicatorView.frame.origin.x / (_btnCount * _btnWidth);
    if ([self.delegate respondsToSelector:@selector(segmentControl:didScrolledPersent:)]) {
        [self.delegate segmentControl:self didScrolledPersent:persent];
    }
}





- (void)setIndicatorViewPercent:(CGFloat)percent {
    CGRect frame = _indicatorView.frame;
    frame.origin.x = _btnCount * _btnWidth * percent;
    
    _indicatorView.frame = frame;
}

#pragma mark 按钮点击事件处理
- (void)btnClicked:(UIButton *)btn{
    [self setSelectedIndex:btn.tag scroll:NO];
}

#pragma mark 设置选中按钮
- (void)setSelectedIndex:(NSInteger)index scroll:(BOOL)scroll
{
    // 告诉代理选中了哪个按钮
    if ([self.delegate respondsToSelector:@selector(segmentControl:didSelectedIndex:)]) {
        [self.delegate segmentControl:self didSelectedIndex:index];
    }
    
    __weak typeof(self)weakSelf = self;
    
    if (scroll) {
        [UIView animateWithDuration:0.25f animations:^{
            
            weakSelf.indicatorView.frame = CGRectMake(weakSelf.btnWidth * index, self.frame.size.height - 4,  weakSelf.indicatorView.frame.size.width, 4);
            
        } completion:^(BOOL finished) {
            
            [self selectedEnd];
        }];
        
    }else {
        [self selectedBegan];
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.25f animations:^{
            weakSelf.indicatorView.frame = CGRectMake(weakSelf.btnWidth * index, self.frame.size.height - 4, weakSelf.indicatorView.frame.size.width, 4);
            weakSelf.contentScrollView.contentOffset = CGPointMake(self.superViewController.view.frame.size.width * index,0);
        } completion:^(BOOL finished) {
            
            [self selectedEnd];
        }];
    }
    _currentBtn = self.buttons[index];
}

/** 选开始的设置，指示视图变暗，字体颜色改变 */
- (void)selectedBegan{
    [_currentBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
}

/** 选开始的设置 */
- (void)selectedEnd {
    UIColor *color = nil;
    if (self.titleSelectColor) {
        color = _titleSelectColor;
    }else {
         color = [UIColor blackColor];
    }
    
    [_currentBtn setTitleColor:color forState:UIControlStateNormal];
}



/** 设置scrollView */
- (void)setupScrollView:(UIView *)fatherView;
{
    CGFloat Y = 64;
    
    int vcWidth =  fatherView.frame.size.width;
    int vcHeight = fatherView.frame.size.height - Y;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, Y, vcWidth, vcHeight)];
    scrollView.contentSize = CGSizeMake(vcWidth * self.controllers.count , vcHeight);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate      = self;
    [fatherView addSubview:scrollView];
    self.contentScrollView = scrollView;
}



/** 设置子视图控制器，这个方法必须在viewDidLoad方法里执行，否则子视图控制器各项属性为空 */
- (void)setupViewControllers:(UIView *)fatherView
{
    CGFloat Y = 64;
    
    int vcWidth =  fatherView.frame.size.width;
    int vcHeight = fatherView.frame.size.height - Y;
    
    int cnt = (int)self.controllers.count;
    for (int i = 0; i < cnt; i++) {
        UIViewController *vc = self.controllers[i];
        [self.superViewController addChildViewController:vc];
        
        vc.view.frame = CGRectMake(vcWidth * i, 0, vcWidth, vcHeight);
        [self.contentScrollView addSubview:vc.view];
    }
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self selectedBegan];
    _isDrag = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_isDrag) {
        CGFloat percent = scrollView.contentOffset.x / scrollView.contentSize.width;
        
        [self setIndicatorViewPercent:percent];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate == NO) {
        [self selectedEnd];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self setSelectedIndex:index scroll:YES];
    _isDrag = NO;
}

@end
