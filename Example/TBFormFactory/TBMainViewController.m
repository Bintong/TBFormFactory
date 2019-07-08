//
//  TBMainViewController.m
//  TBFormFactory_Example
//
//  Created by BinTong on 2019/1/20.
//  Copyright © 2019 https://github.com/Bintong/TBCoreAnimation.git. All rights reserved.
//

#import "TBMainViewController.h"
#import "TBBaseFormController.h"
#import "TBUserFormViewController.h"
#import "TBTopMainController.h"
//#import "TBLoginViewController.h"
#define TBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define TBColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TBMainViewController ()

@end

@implementation TBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TBTopMainController *vc = [[TBTopMainController alloc] init];
    TBBaseFormController *allList = [[TBBaseFormController alloc] init];
    TBUserFormViewController *meList = [[TBUserFormViewController alloc] init];
//    TBLoginViewController *loginVc = [[TBLoginViewController alloc] init];
    
    vc.segmentBgColor = [UIColor whiteColor];
    vc.indicatorViewColor = TBColorFromRGB(0xf9dc4a);
    vc.titleColor = TBColorFromRGB(0x999999);
    vc.titleSelectColor = TBColorFromRGB(0x333333);
    [vc setTitles:@[@"BaseForm",@"动态高度"]];
    [vc setViewControllers:@[allList, meList]];
    [self.navigationController pushViewController:vc animated:YES];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
