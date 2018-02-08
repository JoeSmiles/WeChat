//
//  MineVC.m
//  WeChat
//
//  Created by admin on 2018/1/17.
//  Copyright © 2018年 zjw. All rights reserved.
//

#import "MineVC.h"
#import "MineHeadCell.h"
#import "MineListCell.h"
#import "MineListModel.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *mineGroups;

@end

@implementation MineVC

#pragma mark- 懒加载
- (NSArray *)mineGroups
{
    if (_mineGroups == nil) {
        MineListModel *mine1 = [[MineListModel alloc] init];
        mine1.name = @[@"钱包"];
        mine1.imageName = @[@"MoreMyBankCard"];
        
        MineListModel *mine2 = [[MineListModel alloc] init];
        mine2.name = @[@"收藏",@"相册",@"卡包",@"表情"];
        mine2.imageName = @[@"MoreMyFavorites",@"MoreMyAlbum",@"MyCardPackageIcon",@"MoreExpressionShops"];
        
        MineListModel *mine3 = [[MineListModel alloc] init];
        mine3.name = @[@"设置"];
        mine3.imageName = @[@"MoreSetting"];
        
        _mineGroups = @[mine1,mine2,mine3];
    }
    return _mineGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupNavBar];
    [self setTableview];
    
}

- (void)setTableview
{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.myTableView.backgroundColor = BACKGROUNDCOLOR;
    self.myTableView.sectionFooterHeight = 0;
}

- (void)setupNavBar
{
    self.title = @"我的";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:45/255.0 alpha:1];
    NSMutableDictionary *navigationBarTitleAttrs = [NSMutableDictionary dictionary];
    navigationBarTitleAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = navigationBarTitleAttrs;
}

#pragma mark- tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }else{
        return 25;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else
        return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        MineListModel *mine = self.mineGroups[section-1];
        return mine.name.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mineGroups.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellid = @"MineHeadCell";
        MineHeadCell *cell = (MineHeadCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineHeadCell" owner:self options:nil] lastObject];
        }
        return cell;

    }else{
        static NSString *cellid = @"MineListCell";
        MineListCell *cell = (MineListCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineListCell" owner:self options:nil] lastObject];
        }
        MineListModel *mine = self.mineGroups[indexPath.section-1];
        
        NSString *name = mine.name[indexPath.row];
        NSString *imageName = mine.imageName[indexPath.row];
        
        cell.name.text = name;
        cell.imageName.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",imageName]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
