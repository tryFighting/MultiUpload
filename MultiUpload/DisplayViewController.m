//
//  DisplayViewController.m
//  MultiUpload
//
//  Created by zrq on 2019/4/15.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

#import "DisplayViewController.h"

@interface DisplayViewController ()<UIScrollViewDelegate>{
   
}
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation DisplayViewController
- (UIScrollView *)scrollView{

    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _scrollView.backgroundColor = UIColor.whiteColor;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看图片";
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH * (self.photoArr.count - 1) , kSCREEN_HEIGHT);
    
    for (int i = 0; i < self.photoArr.count - 1; i++) {
        UIImageView *imgeV = [[UIImageView alloc] initWithImage:self.photoArr[i]];
        imgeV.userInteractionEnabled = YES;
        imgeV.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [imgeV addGestureRecognizer:tap];
        imgeV.frame = CGRectMake(i * kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
         [self.scrollView addSubview:imgeV];
    }
    
    
    [self.scrollView scrollRectToVisible:CGRectMake(self.lookTag*kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) animated:NO];
    self.scrollView.pagingEnabled = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    btn.frame = CGRectMake(kSCREEN_WIDTH - 50, 60, 30, 30);
    
    [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   NSInteger index = scrollView.contentOffset.x / kSCREEN_WIDTH;
    
    NSLog(@"--------%d-----------%ld",(int)scrollView.contentOffset.x,(long)index);

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
