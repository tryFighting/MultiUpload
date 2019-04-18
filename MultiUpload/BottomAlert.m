//
//  BottomAlert.m
//  LifeInsurance
//
//  Created by zrq on 2018/9/21.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import "BottomAlert.h"
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface BottomAlert ()
@property (nonatomic, strong) UIView *btnBack;
@end


@implementation BottomAlert

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addElement];
    }
    return self;
}

- (void)addElement {
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    bgview.backgroundColor = [UIColor blackColor];
    bgview.alpha = 0.6;
    bgview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewClick:)];
    [bgview addGestureRecognizer:tap];
    [self addSubview:bgview];
    //遮罩浮窗
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT - 75, kSCREEN_WIDTH, 75)];
    subview.backgroundColor = [UIColor whiteColor];
    [self addSubview:subview];
    NSArray *dataSource = @[ @{ @"name" : @"相册",
                                @"image" : @"identity.jpg" },
                             @{ @"name" : @"相机",
                                @"image" : @"identity.jpg" } ];
    for (int i = 0; i < dataSource.count; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15 + i * kSCREEN_WIDTH / 2, 10, kSCREEN_WIDTH / 2 - 30, 30)];
        imageV.image = [UIImage imageNamed:dataSource[i][@"image"]];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.userInteractionEnabled = YES;
        imageV.tag = 100 - i;
        [subview addSubview:imageV];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        [imageV addGestureRecognizer:tap];

        //90 + 15 + 15 + 30
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15 + i * kSCREEN_WIDTH / 2, 40 + 5, kSCREEN_WIDTH / 2 - 30, 30)];
        label.text = dataSource[i][@"name"];
        label.textAlignment = NSTextAlignmentCenter;
        [subview addSubview:label];
    }
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
}
- (void)ViewClick:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
- (void)imageClick:(UITapGestureRecognizer *)tap {
    if (self.selectItemClick) {
        self.selectItemClick(tap.view.tag);
    }
}
@end
