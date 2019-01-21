//
//  TBNormalCell.m
//  TBFormFactory_Example
//
//  Created by BinTong on 2019/1/20.
//  Copyright © 2019 https://github.com/Bintong/TBCoreAnimation.git. All rights reserved.
//

#import "TBNormalCell.h"

@implementation TBNormalCell


+ (TBNormalCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"TBNormalCell";
    TBNormalCell *myCell = (TBNormalCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (myCell == nil) {
        myCell = [[TBNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    return myCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.accessoryView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height);
}

@end
