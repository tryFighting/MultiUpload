//
//  ViewController.m
//  MultiUpload
//
//  Created by zrq on 2019/4/15.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

#import "ViewController.h"
#import "MultipCellTableViewCell.h"
#import "MultiHeaderView.h"
#import "UIViewController+Add.h"
#import "DisplayViewController.h"
#import "TestStruct.h"
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *collectDataSource;
///图片数组
@property(nonatomic,strong)NSMutableDictionary *collectionDic;

@property(nonatomic,assign)int number;
@end

@implementation ViewController
- (NSMutableArray *)collectDataSource{
    if (_collectDataSource == nil) {
        _collectDataSource = [NSMutableArray arrayWithCapacity:4];
    }
    return _collectDataSource;
}
- (NSMutableDictionary *)collectionDic{
    if (_collectionDic == nil) {
        _collectionDic = [NSMutableDictionary dictionary];
    }
    return _collectionDic;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    
    
    self.title = @"上传";
    self.view.backgroundColor = [UIColor whiteColor];
    
    ///样式1，2，3限定传 2张 3张  4张
    [self.collectDataSource addObject:[NSMutableArray arrayWithObject:[UIImage imageNamed:@"identity.jpg"]]];
    [self.collectDataSource addObject:[NSMutableArray arrayWithObject:[UIImage imageNamed:@"identity.jpg"]]];
    [self.collectDataSource addObject:[NSMutableArray arrayWithObject:[UIImage imageNamed:@"identity.jpg"]]];
    [self.tableView reloadData];
}
- (void)call:(TestStruct *)struct3{
    NSLog(@"%d------------%d",struct3.arg1->a,struct3.arg1->b);
}
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger numberRows = [self.collectDataSource[indexPath.section] count] % 2 > 0 ? ([self.collectDataSource[indexPath.section] count] / 2 + 1) : [self.collectDataSource[indexPath.section] count] / 2;
    return numberRows * (84 + 20) + 40 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *multiCell = @"MultipCellTableViewCell";
    MultipCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:multiCell forIndexPath:indexPath];
    ///刷新
    [cell reloadCollectionView:self.collectDataSource section:indexPath.section];
    //[cell reloadCollectionView:[self.collectionDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]];
    cell.photoClick = ^(NSInteger tag, NSInteger addRow) {

        if (tag == 100) {
            [self showCanEdit:NO andIndex:1 photo:^(UIImage *photo) {
                //相册
                
                NSMutableArray *photoArr = self.collectDataSource[indexPath.section];
                [photoArr insertObject:photo atIndex:photoArr.count - 1];
                if (photoArr.count == indexPath.section + 2) {
                    [photoArr removeObjectAtIndex:photoArr.count - 1];
                }
                [self.tableView reloadData];
            }];
        }else{
            [self showCanEdit:NO andIndex:0 photo:^(UIImage *photo) {
                //相机
                NSMutableArray *photoArr = self.collectDataSource[indexPath.section];
                [photoArr insertObject:photo atIndex:photoArr.count - 1];
                if (photoArr.count == indexPath.section + 2) {
                    [photoArr removeObjectAtIndex:photoArr.count - 1];
                }
                [self.tableView reloadData];
            }];
        }
        
    };
    cell.removeBlock = ^(NSMutableArray *imageArr, NSInteger deleteRow) {
        NSMutableArray *photoArr = self.collectDataSource[indexPath.section];
        [photoArr removeObjectAtIndex:deleteRow];
        // 0---1  1--2  2-3
        if ([photoArr containsObject:[UIImage imageNamed:@"identity.jpg"]]) {
            
        }else{
            [photoArr addObject:[UIImage imageNamed:@"identity.jpg"]];
        }
        [self.tableView reloadData];
    };
    cell.lookBlock = ^(NSMutableArray *imageArr, NSInteger lookRow) {
        
        DisplayViewController *dispaly = [DisplayViewController new];
        if ([imageArr containsObject:[UIImage imageNamed:@"identity.jpg"]]) {
            dispaly.isHave = YES;
        }else{
            dispaly.isHave = NO;
        }
        dispaly.photoArr = imageArr;
        dispaly.lookTag = lookRow;
        [self presentViewController:dispaly animated:YES completion:nil];
    };
    return cell;
}


#pragma mark - init

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[MultipCellTableViewCell class] forCellReuseIdentifier:@"MultipCellTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



#pragma mark ---DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MultiHeaderView *head = [[MultiHeaderView alloc] initWithReuseIdentifier:@"xxx"];
    head.label.text = [NSString stringWithFormat:@"样式%ld",section + 1];
    return head;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
    view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    return view;
}


@end
