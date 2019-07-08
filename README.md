# TBFormFactory


[![Version](https://img.shields.io/cocoapods/v/TBFormFactory.svg?style=flat)](https://cocoapods.org/pods/TBFormFactory)
[![License](https://img.shields.io/cocoapods/l/TBFormFactory.svg?style=flat)](https://cocoapods.org/pods/TBFormFactory)
[![Platform](https://img.shields.io/cocoapods/p/TBFormFactory.svg?style=flat)](https://cocoapods.org/pods/TBFormFactory)

## 前提

1 对于OC 编写App 大致UI 页面可区分为 列表 + 非列表

如图

![mindnode@2x](https://github.com/Bintong/TBFormFactory/blob/master/mindnode%402x.png)

# 介绍

简化**非列表**类型的UI编写步骤，节省 开发维护成本，减少iOS 一个项目中的维护人员。

MVVM 非rac 结构

cell 不用考了，更多精力放在自定义View 上

## 简单结构

![结构@2x](https://github.com/Bintong/TBFormFactory/blob/master/mindNode2%402x.png)

对于**非列表**编写的步骤 不用 建立各种的cell

而是用了viewManager 返回各种自定义view + viewsArray  + tableView（加载views）来加载

## 适合范围

**非列表**页面 说要不是下拉的业务页面 

## 预览

### 1 信息填写

![view1@2x](https://github.com/Bintong/TBFormFactory/blob/master/%E5%9F%BA%E6%9C%AC%E4%BF%A1%E6%81%AF%E5%A1%AB%E5%86%99.gif)



### 不同高度View 展示

![view1@2x](https://github.com/Bintong/TBFormFactory/blob/master/%E4%B8%8D%E5%90%8C%E6%A0%B7%E5%BC%8F.gif](https://github.com/Bintong/TBFormFactory/blob/master/不同样式.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TBFormFactory is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TBFormFactory'
```

## Author

yaxun_123@163.com tongbinapp@gmail.com

## License

TBFormFactory is available under the MIT license. See the LICENSE file for more info.
