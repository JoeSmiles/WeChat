//
//  FindVC.m
//  WeChat
//
//  Created by admin on 2018/1/22.
//  Copyright © 2018年 zjw. All rights reserved.
//

#import "FindVC.h"
#import "DiscoverCell.h"
#import "DiscoverModel.h"

@interface FindVC ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat sectionHeaderHeight;
}

@property (nonatomic, strong) NSArray *discoverGroups;

@end

@implementation FindVC

#pragma mark- 懒加载
- (NSArray *)discoverGroups
{
    if (_discoverGroups == nil) {
        DiscoverModel *dis1 = [[DiscoverModel alloc] init];
        dis1.name = @[@"朋友圈"];
        dis1.imageName = @[@"ff_IconShowAlbum"];
        
        DiscoverModel *dis2 = [[DiscoverModel alloc] init];
        dis2.name = @[@"扫一扫",@"摇一摇"];
        dis2.imageName = @[@"ff_IconQRCode",@"ff_IconShake"];
        
        DiscoverModel *dis3 = [[DiscoverModel alloc] init];
        dis3.name = @[@"附近的人",@"漂流瓶"];
        dis3.imageName = @[@"ff_IconLocationService",@"ff_IconBottle"];
        
        DiscoverModel *dis4 = [[DiscoverModel alloc] init];
        dis4.name = @[@"购物",@"游戏"];
        dis4.imageName = @[@"CreditCard_ShoppingBag",@"MoreGame"];
        
        _discoverGroups = @[dis1, dis2, dis3, dis4];
    }
    return _discoverGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupNavBar];
    [self setTableview];
}

- (void)setupNavBar
{
    self.title = @"发现";
    self.navigationController.navigationBar.barTintColor= [UIColor colorWithRed:40/255.0 green:40/255.0 blue:45/255.0 alpha:1];
    NSMutableDictionary *navigationBarTitleAttrs = [NSMutableDictionary dictionary];
    navigationBarTitleAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = navigationBarTitleAttrs;
}

- (void)setTableview
{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
//    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = BACKGROUNDCOLOR;
    self.myTableView.sectionFooterHeight = 0;
    
}

//#pragma mark-
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView == self.myTableView) {
//        NSLog(@"%lf",sectionHeaderHeight);
//        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}

#pragma mark- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 1;
//    }else
//        return 2;
    DiscoverModel *dis = self.discoverGroups[section];
    return dis.name.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 16;
    return self.discoverGroups.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        sectionHeaderHeight = 10;
    }else{
        sectionHeaderHeight = 15;
    }
    return sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"DiscoverCell";
    DiscoverCell *cell = (DiscoverCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiscoverCell" owner:self options:nil] lastObject];
    }
//    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    
    DiscoverModel *dis = self.discoverGroups[indexPath.section];

    NSString *name = dis.name[indexPath.row];
    NSString *imageName = dis.imageName[indexPath.row];

    cell.name.text = name;
    cell.imageName.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",imageName]];
    

    return cell;
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
