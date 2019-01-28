//
//  TBBaseFormController.m
//  TBFormFactory_Example
//
//  Created by BinTong on 2019/1/20.
//  Copyright © 2019 https://github.com/Bintong/TBCoreAnimation.git. All rights reserved.
//

#import "TBBaseFormController.h"
#import "TBNormalCell.h"
#import "UIView+WPCoordinate.h"
#import "BaseRowFormer.h"
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height


@interface TBBaseFormController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *listView;
@property (nonatomic ,strong) NSMutableArray *views;

@end

@implementation TBBaseFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildViews];
    [self buildListView];
    // Do any additional setup after loading the view.
}


- (void)buildViews {
    self.views = [NSMutableArray array];
    BaseRowFormItem *nameView =   [BaseRowFormer buildNormalText:@"姓名" placeHolder:@"请输入姓名" target:self];
    [self.views addObject:nameView];
    
    BaseRowFormItem *ageView =   [BaseRowFormer buildNormalText:@"年龄" placeHolder:@"请输入年龄" target:self];
    [self.views addObject:ageView];
    
    BaseRowFormItem *phoneView =   [BaseRowFormer buildNormalText:@"联系方式" placeHolder:@"请输入联系方式" target:self];
    phoneView.contentField.keyboardType =  UIKeyboardTypeNumberPad;
    [self.views addObject:phoneView];
    
    BaseRowFormItem *companyView = [BaseRowFormer buildNormalText:@"公司" placeHolder:@"请输入公司名称" target:self];
    [self.views addObject:companyView];
    
    
    BaseRowFormItem *infoLabel_1 = [BaseRowFormer buildNormalTextLabel:@"消息" subLabel:@"消息已打开" target:self];
    [self.views addObject:infoLabel_1];
    
}

- (void)buildListView {
    self.listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.listView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    self.listView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.listView.height = kScreenHeight - getRectNavAndStatusHight;
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.rowHeight = 46;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.pagingEnabled = NO;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.bounces = NO;
    
    [self.view addSubview:self.listView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.views.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UIView *v =  [self.views objectAtIndex:indexPath.row];
    return v.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBNormalCell *myCell = [TBNormalCell cellWithTableView:tableView];
    myCell.accessoryView = [self.views objectAtIndex:indexPath.row];
    [myCell setNeedsLayout];
    return myCell;
}

@end
