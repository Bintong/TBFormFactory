//
//  TBUserFormViewController.m
//  TBFormFactory_Example
//
//  Created by BinTong on 2019/1/20.
//  Copyright © 2019 https://github.com/Bintong/TBCoreAnimation.git. All rights reserved.
//

#import "TBUserFormViewController.h"
#import "TBNormalCell.h"
#import "BaseRowFormer.h"
#import "BMWPCategory.h"

#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height


@interface TBUserFormViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *listView;
@property (nonatomic ,strong) NSMutableArray *views;

@end

@implementation TBUserFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildViews];
    [self buildListView];
    // Do any additional setup after loading the view.
}


- (void)buildViews {
    self.views = [NSMutableArray array];
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    v1.backgroundColor = [UIColor redColor];
    [self.views addObject:v1];
    
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    v2.backgroundColor = [UIColor blackColor];
    [self.views addObject:v2];
    
    UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    v3.backgroundColor = [UIColor orangeColor];
    [self.views addObject:v3];
    
    UIView *v4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    v4.backgroundColor = [UIColor purpleColor];
    [self.views addObject:v4];
    
    UIView *v5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    v5.backgroundColor = [UIColor yellowColor];
    [self.views addObject:v5];
    
    UIView *v6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
    v6.backgroundColor = [UIColor blueColor];
    [self.views addObject:v6];
    
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
