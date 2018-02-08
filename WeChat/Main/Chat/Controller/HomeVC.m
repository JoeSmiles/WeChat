//
//  HomeVC.m
//  WeChat
//
//  Created by admin on 2018/1/17.
//  Copyright © 2018年 zjw. All rights reserved.
//

#import "HomeVC.h"
#import "ChatListCell.h"
#import "YCXMenu.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;

@end

@implementation HomeVC

- (NSArray *)items{
    if (!_items) {
        _items = @[[YCXMenuItem menuItem:@"发起群聊" image:[UIImage imageNamed:[NSString stringWithFormat:@"contacts_add_newmessage"]] tag:100 userInfo:nil],
                   [YCXMenuItem menuItem:@"添加朋友" image:[UIImage imageNamed:[NSString stringWithFormat:@"contacts_add_friend"]] tag:101 userInfo:nil],
                   [YCXMenuItem menuItem:@"扫一扫" image:[UIImage imageNamed:[NSString stringWithFormat:@"contacts_add_scan"]] tag:102 userInfo:nil],
                   [YCXMenuItem menuItem:@"收付款" image:[UIImage imageNamed:[NSString stringWithFormat:@"contacts_add_scan"]] tag:103 userInfo:nil]
                   ];
    }
    
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupNavBar];
    [self setTableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillAppear) name:YCXMenuWillAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidAppear) name:YCXMenuDidAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillDisappear) name:YCXMenuWillDisappearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidDisappear) name:YCXMenuDidDisappearNotification object:nil];

    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Notification

- (void)menuWillAppear {
    NSLog(@"menu will appear");
}

- (void)menuDidAppear {
    NSLog(@"menu did appear");
}

- (void)menuWillDisappear {
    NSLog(@"menu will disappear");
}

- (void)menuDidDisappear {
    NSLog(@"menu did disappear");
}


- (void)setupNavBar
{
    self.title = @"微信";
    /// 设置内容区背景颜色
//    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    /// 设置导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:45/255.0 alpha:1];
    /// 设置导航栏标题的字体颜色
    NSMutableDictionary *navigationBarTitleAttrs = [NSMutableDictionary dictionary];
    navigationBarTitleAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    navigationBarTitleAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    self.navigationController.navigationBar.titleTextAttributes = navigationBarTitleAttrs;
    
    /// 设置导航栏右边加号
    // 设置图片不渲染
    UIImage *rightImage = [[UIImage imageNamed:@"barbuttonicon_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setTableview
{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
//    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.myTableView.backgroundColor = BACKGROUNDCOLOR;
    
    // 添加搜索框
    [self addSearchView];
    
}

- (void)addSearchView
{
    /// 搜索框
    UIView *searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
    self.myTableView.tableHeaderView = searchBgView;
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(12, 10, kScreenWidth-2*12, searchBgView.frame.size.height-2*10)];
    [searchBgView addSubview:searchView];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = 5;
    searchView.layer.masksToBounds = YES;
    //  在UIView中添加点击事件oc及swift UIView继承于UIResponder是没有addTarget 方法的,所有只能在UIView上添加手势UITapGestureRecognizer来实现点击事件
    UITapGestureRecognizer *searchRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearch)];
    searchView.userInteractionEnabled = YES;
    [searchView addGestureRecognizer:searchRecognizer];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchView addSubview:searchBtn];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(16);
        make.centerX.equalTo(searchView.mas_centerX).offset(-25);
        make.centerY.equalTo(searchView.mas_centerY).offset(0);
    }];
    UILabel *searchLabel = [[UILabel alloc] init];
    searchLabel.text = @"搜索";
    searchLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    searchLabel.font = [UIFont systemFontOfSize:15];
    [searchView addSubview:searchLabel];
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(searchView.mas_centerX).offset(5);
        make.centerY.equalTo(searchView.mas_centerY).offset(0);
    }];
    UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchView addSubview:voiceBtn];
    [voiceBtn setBackgroundImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:UIControlStateNormal];
    [voiceBtn setBackgroundImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateSelected];
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchView.mas_centerY).offset(0);
        make.right.equalTo(searchView.mas_right).offset(-10);
        make.width.and.height.mas_equalTo(20);
    }];
    [voiceBtn addTarget:self action:@selector(clickVoiceSearch) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark- 导航栏右侧按钮的点击事件
- (void)rightAction:(UIBarButtonItem *)barBtn
{
    if (barBtn == self.navigationItem.rightBarButtonItem) {
        [YCXMenu setTintColor:[UIColor blackColor]];
        [YCXMenu setSelectedColor:[UIColor grayColor]];
        [YCXMenu setTitleFont:[UIFont systemFontOfSize:13]];
        if ([YCXMenu isShow]) {
            [YCXMenu dismissMenu];
        }else{
            [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 55, 64, 50, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
                        switch (item.tag) {
                                        case 100:
                                            NSLog(@"跳转到发起群聊界面");
                                            break;
                                        case 101:
                                            NSLog(@"跳转到添加朋友界面");
                                            break;
                                        case 102:
                                            NSLog(@"跳转到扫一扫界面");
                                            break;
                                        case 103:
                                            NSLog(@"跳转到收付款界面");
                                            break;
                            
                                        default:
                                            break;
                                    }
            }];
        }
    }
    
}

#pragma mark- 搜索栏的点击事件
- (void)clickSearch
{
    NSLog(@"你点击了搜索栏");

}

#pragma mark- 语音点击搜索事件
- (void)clickVoiceSearch
{
    NSLog(@"你点击了语音搜索");

}


#pragma mark- UITableView delagate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"ChatListCell";
    ChatListCell *cell = (ChatListCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatListCell" owner:self options:nil] lastObject];
    }
//    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row % 2 == 1) {
        [cell.stateView setHidden:YES];
    }else{
        [cell.silentImage setHidden:YES];
    }
    
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
