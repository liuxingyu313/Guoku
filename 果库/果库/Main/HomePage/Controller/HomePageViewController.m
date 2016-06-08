//
//  HomePageViewController.m
//  果库
//
//  Created by HZApple on 16/5/28.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "HomePageViewController.h"
#import "AFNetworking.h"
#import "AuthorizeduserUserModel.h"
#import "ArticlesModel.h"
#import "CategoryModel.h"
#import "CommondityModel.h"
#import "YYModel.h"
#import "UIImageView+WebCache.h"
#import "BannerView.h"
#import "AuthorizedUserView.h"
#import "CatrgoryView.h"
#import "AtriclesTableViewCell.h"
#import "EntityCollectionViewCell.h"
#import "WebViewController.h"
#import "LikeTableViewController.h"

@interface HomePageViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate> {
    
    UIScrollView *mainScrollView;
    
    NSMutableArray *authorizeUserDataArray;
    
    NSMutableArray *articlesDataArray;
    
    NSMutableArray *bannerDataArray;
    
    NSMutableArray *categoriesDataArray;
    
    NSMutableArray *entityDataArray;
    
    UIScrollView *bannerscroll;
    
    CGFloat y ;
    
    NSInteger time;
    
    BOOL flag;
    
    UITableView * tableView1;
    
    UIActivityIndicatorView *aiv;
}

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    
   
    self.navigationController.navigationBar.translucent = NO;
    
    time = 1;
    
    flag = NO;
    
    aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 100, 100, 100)];
    aiv.activityIndicatorViewStyle = 0;
    aiv.backgroundColor = [UIColor grayColor];
    [aiv startAnimating];
    [self.view insertSubview:aiv atIndex:0];
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.backgroundColor = backColor;
    mainScrollView.tag = 11;
    mainScrollView.delegate = self;
    mainScrollView.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:mainScrollView];
    [self _loadData];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)_loadData {
    
    authorizeUserDataArray = [NSMutableArray array];
    articlesDataArray = [NSMutableArray array];
    bannerDataArray = [NSMutableArray array];
    categoriesDataArray = [NSMutableArray array];
    entityDataArray = [NSMutableArray array];
    
    NSString *urlString = @"http://api.guoku.com/mobile/v4/discover/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&session=be8f65131c3153df9fb6971122e2b5f1&sign=cf701c7bb14e1f120404760604be433f";
    [[AFHTTPSessionManager manager] GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *authorize = dic[@"authorizeduser"];
        NSArray *articles = dic[@"articles"];
        bannerDataArray = dic[@"banner"];
        NSArray *categories = dic[@"categories"];
        NSArray *entities = dic[@"entities"];
        
        for (int i = 0; i < authorize.count; i++) {
            NSDictionary *dic1 = authorize[i];
            NSDictionary *dic2 = dic1[@"user"];
            
            AuthorizeduserUserModel *model = [AuthorizeduserUserModel yy_modelWithDictionary:dic2];
            [authorizeUserDataArray addObject:model];
        
        }
        
        for (int i = 0; i < articles.count; i++) {
            NSDictionary *dic1 = articles[i];
            NSDictionary *dic2 = dic1[@"article"];
            
            ArticlesModel *model = [ArticlesModel yy_modelWithDictionary:dic2];
            [articlesDataArray addObject:model];
        }
        
        for (int i = 0; i < categories.count; i ++) {
            NSDictionary *dic1 = categories[i];
            NSDictionary *dic2 = dic1[@"category"];
            
            CategoryModel *model = [CategoryModel yy_modelWithDictionary:dic2];
            [categoriesDataArray addObject:model];
            
        }
        
        for (int i = 0; i < entities.count; i ++) {
            NSDictionary *dic1 = entities[i];
            NSDictionary *dic2 = dic1[@"entity"];
            
            CommondityModel *model = [CommondityModel yy_modelWithDictionary:dic2];
            model.commodityTitle = dic2[@"title"];
            [entityDataArray addObject:model];
            
        }
        
        [self _loadView1];
        [self _loadView2];
        [self _loadView3];
        [self _loadView4];
      
            
        [self _loadView5];
        mainScrollView.contentSize = CGSizeMake(0, y + 49);
        [aiv stopAnimating];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)_loadView1 {
    
    bannerscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 4)];
    bannerscroll.contentSize = CGSizeMake(kScreenWidth * bannerDataArray.count, 0);
    bannerscroll.userInteractionEnabled = YES;
    bannerscroll.pagingEnabled = YES;
    bannerscroll.showsHorizontalScrollIndicator = NO;
    bannerscroll.tag = 22;
    [mainScrollView addSubview:bannerscroll];
    for (int i = 0; i < bannerDataArray.count; i ++) {
        BannerView *bannerView = [[BannerView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight / 4)];
        bannerView.dic = bannerDataArray[i];

        [bannerscroll addSubview:bannerView];
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    y += bannerscroll.height;
}

- (void)_loadView2 {
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, y + 3, kScreenWidth, 100)];
    backView.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:backView];
    
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, kScreenWidth, 75)];
    
    view.showsHorizontalScrollIndicator = NO;
    view.backgroundColor = [UIColor whiteColor];
    [backView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 20)];
    label.text = @"推荐用户";
    [backView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"arrow_hot"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(kScreenWidth - 30, 5, 20, 20);
    button.backgroundColor = [UIColor cyanColor];
    [backView addSubview:button];
    
    for (int i = 0; i < authorizeUserDataArray.count; i ++) {
        AuthorizedUserView *authorized = [[AuthorizedUserView alloc] initWithFrame:CGRectMake(10 + 60 * i, 3, 50, 70)];
        authorized.model = authorizeUserDataArray[i];
        [view addSubview:authorized];
    }
    
    view.contentSize = CGSizeMake(60 * authorizeUserDataArray.count + 20, 0);
    
    y += 103;
}

- (void)_loadView3 {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, y + 6, kScreenWidth, kScreenWidth / 4 + 35)];
    backView.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:backView];
    
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenWidth / 4)];
    view.showsHorizontalScrollIndicator = NO;
    view.backgroundColor = [UIColor whiteColor];
    [backView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 20)];
    label.text = @"推荐品类";
    [backView addSubview:label];

    for (int i = 0; i < categoriesDataArray.count; i++) {
        CatrgoryView *category = [[CatrgoryView alloc] initWithFrame:CGRectMake(6 + (kScreenWidth / 4 + 6) * i, 0, kScreenWidth / 4, kScreenWidth / 4)];
        category.model = categoriesDataArray[i];
        [view addSubview:category];
    }
    view.contentSize = CGSizeMake(12 + (kScreenWidth / 4 + 6) * categoriesDataArray.count, 0);
    y += 30 + kScreenWidth / 4 + 11;
}

- (void)_loadView4 {
    
    tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, y + 6, kScreenWidth, 40 + 80 * articlesDataArray.count) style:UITableViewStyleGrouped];
    tableView1.scrollEnabled = NO;
    tableView1.tag = 55;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [tableView1 registerClass:[AtriclesTableViewCell class] forCellReuseIdentifier:@"11"];
    [mainScrollView addSubview:tableView1];
    
    y += 40 + 80 * articlesDataArray.count + 6;
}

- (void)_loadView5 {
    
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y + 6, kScreenWidth, 40 + ((kScreenWidth - 40) /  2 + 105) * 5) collectionViewLayout:layout];
    collectionView.tag = 22;
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[EntityCollectionViewCell class] forCellWithReuseIdentifier:@"EntityCollectionViewCell"];
    [mainScrollView addSubview:collectionView];
    
    y += ((kScreenWidth - 40) /  2 + 105) * 5;
    
    
}

#pragma mark collectionviewdatasourse 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ((collectionView.tag == 22)) {
        return 10;
    }else {
        return entityDataArray.count - 10;
    }
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EntityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EntityCollectionViewCell" forIndexPath:indexPath];
    if ((collectionView.tag == 22)) {
        cell.model = entityDataArray[indexPath.row];
    } else {
        cell.model = entityDataArray[indexPath.row + 10];
    }
    
    
    return cell;
    
}

#pragma mark collectionViewFLowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth - 20) / 2,((kScreenWidth - 40) /  2 + 95) );
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark tableviewdatasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AtriclesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"11" forIndexPath:indexPath];
    cell.model = articlesDataArray[indexPath.row];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return articlesDataArray.count;
}

#pragma mark tableviewdelagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 10)];
    label.text = @"热门图文";
    [view addSubview:label];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 55) {
        self.hidesBottomBarWhenPushed = YES;
        ArticlesModel *model = articlesDataArray[indexPath.row];
        NSString *string = model.url;
        WebViewController *webview = [[WebViewController alloc] init];
        webview.url = string;
        [self.navigationController pushViewController:webview animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
}

- (void)timerAction {
    
    if (time < 4) {
        [bannerscroll setContentOffset:CGPointMake(time  * kScreenWidth, 0)];
        time ++;
    }else {
        [bannerscroll setContentOffset:CGPointMake(0, 0)];
        time = 1;
    }
  
}
# pragma mark uiscrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 11) {
        if (scrollView.contentOffset.y > 1588) {
            if (!flag) {
                [self _loadview6];
                mainScrollView.contentSize = CGSizeMake(0, y);
                flag = YES;
            }
            
        }
    }
}

- (void)_loadview6 {
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y + 6 , kScreenWidth, 40 + ((kScreenWidth - 40) /  2 + 105) * ((entityDataArray.count + 1) / 2 - 5)) collectionViewLayout:layout];
    collectionView.tag = 33;
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[EntityCollectionViewCell class] forCellWithReuseIdentifier:@"EntityCollectionViewCell"];
    [mainScrollView addSubview:collectionView];
    
    y += ((kScreenWidth - 40) /  2 + 105) * ((entityDataArray.count + 1) / 2 - 5);
    
}

- (void)buttonAction {
    
    LikeTableViewController *like = [[LikeTableViewController alloc] init];
    like.tag =  2;
    [self.navigationController pushViewController:like animated:NO];
    
}

@end
