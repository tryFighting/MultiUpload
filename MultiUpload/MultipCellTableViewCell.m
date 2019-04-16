//
//  MultipCellTableViewCell.m
//  MultiUpload
//
//  Created by zrq on 2019/4/15.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

#import "MultipCellTableViewCell.h"
#import "MultiCollectionViewCell.h"
#import "BottomAlert.h"
@interface MultipCellTableViewCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,MultipCellDelegate>

@property (strong, nonatomic) NSMutableArray *imageArr;
@property (nonatomic, strong) UIView *backView;

@end
@implementation MultipCellTableViewCell
- (void)reloadCollectionView:(NSMutableArray *)arr {
    self.imageArr = [NSMutableArray arrayWithArray:arr];
    NSInteger numberRows = self.imageArr.count % 2 > 0 ? (self.imageArr.count / 2 + 1) : self.imageArr.count / 2;
    NSString *rowString = [NSString stringWithFormat:@"%zd", numberRows * (84 + 20) + 40 + 20];
    
    CGFloat footerHeight = 0;
    if (![self.footerTips isEqualToString:@""]) {
        footerHeight = [self.footerTips boundingRectWithSize:CGSizeMake(kSCREEN_WIDTH-30-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height+20;
    }
//    self.backView.frame = CGRectMake(15, 10, kSCREEN_WIDTH-30, [rowString integerValue]+footerHeight);
//
    self.proofCollectionView.frame = CGRectMake(15, 10, kSCREEN_WIDTH-30, [rowString integerValue]+footerHeight);
//    self.backView.layer.cornerRadius = 4;
//    self.backView.layer.shadowColor = [UIColor redColor].CGColor;
//    self.backView.layer.shadowOpacity = 0.5;
//    //路径阴影
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2, -2, self.backView.frame.size.width + 8, self.backView.frame.size.height + 8) cornerRadius:4]; // 圆角半径为30
//    //设置阴影路径
//    self.backView.layer.shadowPath = path.CGPath;
    
    //    self.proofCollectionView.backgroundColor = [UIColor redColor];
    [self.proofCollectionView reloadData];
}
- (void)moveImageBtnClick:(MultiCollectionViewCell *)aCell{
    NSIndexPath *indexPath = [self.proofCollectionView indexPathForCell:aCell];
    if (self.removeBlock) {
        self.removeBlock(_imageArr, indexPath.row);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self initilizeUI:@[]];
    }
    return self;
}
- (void)initilizeUI:(NSArray *)arr {
    //不要忘记初始化；
    //    self.imageArr = [NSMutableArray arrayWithArray:arr];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = UIColor.redColor;
    [self.contentView addSubview:self.backView];
    
    self.proofCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, kSCREEN_WIDTH-30, kSCREEN_HEIGHT) collectionViewLayout:flowLayout];
    self.proofCollectionView.scrollEnabled = NO;
    [self.proofCollectionView registerClass:[MultiCollectionViewCell class] forCellWithReuseIdentifier:@"MultiCollectionViewCell"];
    
    self.proofCollectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.proofCollectionView];
    
    self.proofCollectionView.dataSource = self;
    self.proofCollectionView.delegate = self;
    //[self.proofCollectionView registerClass:[PLProofCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    //[self.proofCollectionView registerClass:[PLProofFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MultiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MultiCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"identity"];
//    if (self.isChange) {
//        if (indexPath.row == self.imageArr.count-1) {
//            cell.close.hidden = YES;
//        }else{
//            cell.close.hidden = NO;
//        }
//    }else{
//
//        if ([[self.imageArr objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]) {
//            cell.close.hidden = NO;
//        }else{
//            cell.close.hidden = YES;
//        }
//
//    }
    if (indexPath.row == self.imageArr.count-1) {
        cell.close.hidden = YES;
    }else{
        cell.close.hidden = NO;
    }
    if ([[self.imageArr objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]) {
        cell.imageView.image = [self.imageArr objectAtIndex:indexPath.row];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"identity"];
    }
    //    cell.imageId = self.imageArr[indexPath.row];
    cell.delegate = self;
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isChange) {
        if (indexPath.row == self.imageArr.count - 1) {
            
            if ([[self.imageArr subarrayWithRange:NSMakeRange(0, self.imageArr.count-1)] containsObject:@""]) {
                NSLog(@"请先上传图片再添加");
                return;
            }
            
            [self.imageArr addObject:@""];
            //发送通知
            if (self.addBlock) {
                self.addBlock(self.imageArr, indexPath.row);
            }
            
        }else{
            
            //点击事件触发
            BottomAlert *alert = [[BottomAlert alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
            __weak typeof(alert) weakSel = alert;
            alert.selectItemClick = ^(NSInteger tag) {
                if (tag == 100) {
                    [weakSel removeFromSuperview];
                    self.photoClick(100, indexPath.row);
                } else {
                    [weakSel removeFromSuperview];
                    self.photoClick(101, indexPath.row);
                }
            };
        }
    }else{
        if (indexPath.row == self.imageArr.count - 1) {
            //点击事件触发
            BottomAlert *alert = [[BottomAlert alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
            __weak typeof(alert) weakSel = alert;
            alert.selectItemClick = ^(NSInteger tag) {
                if (tag == 100) {
                    [weakSel removeFromSuperview];
                    self.photoClick(100, indexPath.row);
                } else {
                    [weakSel removeFromSuperview];
                    self.photoClick(101, indexPath.row);
                }
            };
        }else{
            //展示view
            if (self.lookBlock) {
                self.lookBlock(self.imageArr, indexPath.row);
            }
        }
        
    }
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark----设置每个单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kSCREEN_WIDTH-60 - 40) / 2, 84);
}
#pragma mark---通过调整inset使单元格顶部和底部都有间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上左下右
    return UIEdgeInsetsMake(20, 20, 20, 20);
}
#pragma-mark 上下行cell的间距 ------竖向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
#pragma mark--同一行的cell的间距-----横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(kSCREEN_WIDTH / 2, 40);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    if ([self.footerTips isEqualToString:@""]) {
//        return CGSizeMake(kSCREEN_WIDTH / 2, 0);
//    }else{
//        CGFloat footerHeight = [self.footerTips boundingRectWithSize:CGSizeMake(kSCREEN_WIDTH-30-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height+20;
//        return CGSizeMake(kSCREEN_WIDTH / 2, footerHeight);
//    }
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
