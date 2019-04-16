//
//  MultiHeaderView.m
//  MultiUpload
//
//  Created by zrq on 2019/4/15.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

#import "MultiHeaderView.h"

@implementation MultiHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self UIBaseSetting];
    }
    return self;
}
- (void)UIBaseSetting {
    self.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, 100, 20)];
    label.textColor = UIColor.blackColor;
    label.backgroundColor = UIColor.whiteColor;
    [self addSubview:label];
    self.label = label;
}
@end
