# TBTopPagesController

[![CI Status](https://img.shields.io/travis/yaxun_123@163.com/TBTopPagesController.svg?style=flat)](https://travis-ci.org/yaxun_123@163.com/TBTopPagesController)
[![Version](https://img.shields.io/cocoapods/v/TBTopPagesController.svg?style=flat)](https://cocoapods.org/pods/TBTopPagesController)
[![License](https://img.shields.io/cocoapods/l/TBTopPagesController.svg?style=flat)](https://cocoapods.org/pods/TBTopPagesController)
[![Platform](https://img.shields.io/cocoapods/p/TBTopPagesController.svg?style=flat)](https://cocoapods.org/pods/TBTopPagesController)

Perf

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Not View . For ViewControllers

![GIF](https://github.com/Bintong/TBTopPagesController/blob/master/phone1.gif?raw=true)

## Requirements

This library requires `iOS 9.0+` and `Xcode 8.0+`.

## Installation

### Installation with CocoaPods

```ruby
pod 'TBTopPagesController'
```

### Manually

```objective-c
TBSegmentControl.h
TBSegmentControl.m
TBTopMainController.h
TBTopMainController.m
```

Copy Some specific class file to your projec

## Usage

```objective-c
    TBTopMainController *vc = [[TBTopMainController alloc] init];
    TBAViewController *allList = [[TBAViewController alloc] init];
    TBBViewController *meList = [[TBBViewController alloc] init];
    TBCViewController *cCV = [[TBCViewController alloc] init];
    
    vc.segmentBgColor = [UIColor whiteColor];
    vc.indicatorViewColor = TBColorFromRGB(0xf9dc4a);
    vc.titleColor = TBColorFromRGB(0x999999);
    vc.titleSelectColor = TBColorFromRGB(0x333333);
    [vc setTitles:@[@"精选",@"发现",@"好友圈"]];
    [vc setViewControllers:@[allList, meList,cCV]];
```

最后可以选择 怎么样展示设置好的viewController



## Author

yaxun_123@163.com,tongbinapp@gmail.com

## License

TBTopPagesController is available under the MIT license. See the LICENSE file for more info.
