//
//  ContactsVC.m
//  WeChat
//
//  Created by admin on 2018/1/17.
//  Copyright © 2018年 zjw. All rights reserved.
//

#import "ContactsVC.h"
#import "ContactListCell.h"
#import "ContactModel.h"
#import "NSString+PinYin.h"

@interface ContactsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat sectionHeaderHeight;
}

@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;

@property (nonatomic, strong) NSMutableArray *headImages;

@property (nonatomic,strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ContactsVC


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupNavBar];
    [self setTableview];
    
    [self getDataWithCount:30];
    
}

- (void)setupNavBar
{
    self.title = @"通讯录";
    /// 设置导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:45/255.0 alpha:1];
    /// 设置导航栏标题的字体颜色
    NSMutableDictionary *navigationBarTitleAttrs = [NSMutableDictionary dictionary];
    navigationBarTitleAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    navigationBarTitleAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    self.navigationController.navigationBar.titleTextAttributes = navigationBarTitleAttrs;
    
    /// 设置导航栏右边加号
    // 设置图片不渲染
    UIImage *rightImage = [[UIImage imageNamed:@"contacts_add_friend"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
     
}

- (void)setTableview
{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.backgroundColor = BACKGROUNDCOLOR;
    
    UISearchBar  *mSearchBar = [[UISearchBar alloc] init];
//    mSearchBar.delegate = self;
    mSearchBar.placeholder = @"搜索";
    [mSearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mSearchBar sizeToFit];
    self.myTableView.tableHeaderView=mSearchBar;
    
//    [self addSearchView];
}

- (void)addSearchView
{
    // 搜索框
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
    [searchView addSubview:searchLabel];
    searchLabel.text = @"搜索";
    searchLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    searchLabel.font = [UIFont systemFontOfSize:15];
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

- (void)getDataWithCount:(NSInteger)count
{
    NSArray *xings = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王",@"冯",@"陈",@"楚",@"卫",@"蒋",@"沈",@"韩",@"杨",@"陶",@"111",@"Tom"];
    NSArray *ming1 = @[@"大",@"美",@"帅",@"应",@"超",@"海",@"江",@"湖",@"春",@"夏",@"秋",@"冬",@"上",@"左",@"有",@"纯"];
    NSArray *ming2 = @[@"强",@"好",@"领",@"亮",@"超",@"华",@"奎",@"海",@"工",@"青",@"红",@"潮",@"兵",@"垂",@"刚",@"山"];
    [self headImage];
    
    for (int i = 0; i < count; i++) {
        NSString *name = xings[arc4random_uniform((int)xings.count)];
        NSString *ming = ming1[arc4random_uniform((int)ming1.count)];
        name = [name stringByAppendingString:ming];
        if (arc4random_uniform(10) > 3) {
            NSString *ming = ming2[arc4random_uniform((int)ming2.count)];
            name = [name stringByAppendingString:ming];
        }
        int randomIndex = arc4random_uniform((int)self.headImages.count);
        ContactModel *model = [ContactModel new];
        model.name = name;
        model.imageName = self.headImages[randomIndex];
        [self.dataArray addObject:model];
    }
    
    [self setupTableSection];
}

- (void)setupTableSection
{
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    // create a temp sectionArray
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc] init]];
    }
    
    // insert Persons info into newSectionArray
    for (ContactModel *model in self.dataArray) {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(name)];
        [newSectionArray[sectionIndex] addObject:model];
    }
    
    // sort the person of each section
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(name)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    self.sectionTitlesArray = [NSMutableArray new];
    
    __weak NSMutableArray *sectionTitlesArray;
    sectionTitlesArray = self.sectionTitlesArray;
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr , NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        }else{
            [sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    
    NSMutableArray *operrationModels = [NSMutableArray new];
    NSArray *dicts = @[@{@"name" : @"新的朋友", @"imageName" : @"plugins_FriendNotify"},
                       @{@"name" : @"群聊", @"imageName" : @"add_friend_icon_addgroup"},
                       @{@"name" : @"标签", @"imageName" : @"Contact_icon_ContactTag"},
                       @{@"name" : @"公众号", @"imageName" : @"add_friend_icon_offical"}];
    for (NSDictionary *dict in dicts) {
        ContactModel *model = [ContactModel new];
        model.name = dict[@"name"];
        model.imageName = dict[@"imageName"];
        [operrationModels addObject:model];
    }
    
    [newSectionArray insertObject:operrationModels atIndex:0];
    [self.sectionTitlesArray insertObject:@"" atIndex:0];
    
    self.sectionArray = newSectionArray;

}

- (NSMutableArray *)headImage{
    if (!self.headImages) {
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < 24; i++) {
            NSString *headImage = [NSString stringWithFormat:@"%d.jpg",i];
            [temp addObject:headImage];
        }
        self.headImages = [temp copy];
    }
    return self.headImages;
}

#pragma mark- 搜索栏的点击事件
- (void)clickSearch{
    NSLog(@"你点击了搜索栏");
}

#pragma mark- 导航栏右侧按钮的点击事件
- (void)rightAction{
    NSLog(@"你点击了右侧按钮");
}

#pragma mark- 语音点击搜索事件
- (void)clickVoiceSearch{
    NSLog(@"你点击了语音搜索");
}

#pragma mark- UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.sectionArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sectionArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellid = @"ContactListCell";
    ContactListCell *cell = (ContactListCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactListCell" owner:self options:nil] lastObject];
    }

    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];

    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    ContactModel *model = self.sectionArray[section][row];
    cell.model = model;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        sectionHeaderHeight = 0;
    }else{
        sectionHeaderHeight = 20;
    }
    
    return sectionHeaderHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitlesArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{

    NSLog(@"%ld===%@",index,title);

//    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
//    if ([title isEqualToString:UITableViewIndexSearch]){
//        [tableView setContentOffset:CGPointZero animated:YES];//tabview移至顶部
//        return NSNotFound;
//    }
//    else{
//        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] - 1; // -1 添加了搜索标识
//    }
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitlesArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
