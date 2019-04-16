//
//  BottomAlert.h
//  LifeInsurance
//
//  Created by zrq on 2018/9/21.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectItem)(NSInteger tag);


@interface BottomAlert : UIView
@property (copy, nonatomic) SelectItem selectItemClick;
@end
