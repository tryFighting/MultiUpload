//
//  UIViewController+Add.h
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^photoBlock)(UIImage *photo);


@interface UIViewController (Add)

/**
 *  照片选择->图库/相机
 *
 *  @param edit  照片是否需要裁剪,默认NO
 *  @param block 照片回调
 */
- (void)showCanEdit:(BOOL)edit photo:(photoBlock)block;

// 自定义UI   0 拍照  1 相册
- (void)showCanEdit:(BOOL)edit andIndex:(int)index photo:(photoBlock)block;

@end
