//
//  DisplayViewController.m
//  MultiUpload
//
//  Created by zrq on 2019/4/15.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

#import "DisplayViewController.h"

@interface DisplayViewController ()

@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看图片";
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIImageView *imgeV = [[UIImageView alloc] initWithImage:self.photoArr[self.lookTag]];
    imgeV.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    [self.view addSubview:imgeV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    btn.frame = CGRectMake(kSCREEN_WIDTH - 50, 60, 30, 30);
    
    [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}
- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
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
