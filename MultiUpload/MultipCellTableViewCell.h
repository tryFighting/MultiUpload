//
//  MultipCellTableViewCell.h
//  MultiUpload
//
//  Created by zrq on 2019/4/15.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

#import <UIKit/UIKit.h>
//! 相册 照相回调
typedef void (^Photo)(NSInteger tag,NSInteger addRow);
//! 删除图片回调
typedef void (^RemoveImageBlock)(NSMutableArray *imageArr,NSInteger deleteRow);
//! 添加图片回调
typedef void(^AddImageBlock)(NSArray *imageArr, NSInteger addRow);
// !查看图片回调
typedef void(^LookImageBlock)(NSMutableArray *imageArr, NSInteger lookRow);
NS_ASSUME_NONNULL_BEGIN

@interface MultipCellTableViewCell : UITableViewCell

///collectionview
@property (nonatomic, strong) UICollectionView *proofCollectionView;
@property (copy, nonatomic) Photo photoClick;
@property (copy, nonatomic) RemoveImageBlock removeBlock;
@property (nonatomic, copy) AddImageBlock addBlock;
@property (nonatomic, copy) LookImageBlock lookBlock;
@property (nonatomic, strong) NSString *tips;
@property (nonatomic, strong) NSString *footerTips;
@property (nonatomic, assign) BOOL isChange;
- (void)reloadCollectionView:(NSMutableArray *)arr section:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END

