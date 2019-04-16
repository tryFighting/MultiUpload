//
//  MultiCollectionViewCell.h
//  MultiUpload
//
//  Created by zrq on 2019/4/15.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultiCollectionViewCell;
@protocol MultipCellDelegate <NSObject>

- (void)moveImageBtnClick:(MultiCollectionViewCell *)aCell;

@end
NS_ASSUME_NONNULL_BEGIN

@interface MultiCollectionViewCell : UICollectionViewCell
/**
 删除方法代理
 */
@property (nonatomic, assign) id<MultipCellDelegate> delegate;
@property (nonatomic, strong) UILabel *text;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *close;
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic, strong) NSString *imageId;
@end

NS_ASSUME_NONNULL_END
