
//
//  CatrgoryViewController.m
//  果库
//
//  Created by HZApple on 16/5/31.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CatrgoryViewController.h"
#import "CommondityModel.h"
#import "EntityCollectionViewCell.h"
#import "ArticlesModel.h"
#import "AtriclesTableViewCell.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "WebViewController.h"
#import "CatrgoryGraphicdVievController.h"

@interface CatrgoryViewController()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
 
    NSMutableArray *articlesDataArray;
    
    NSMutableArray *commondityDataArray;
    
    UITableView *tableView1;
    
    CGFloat y ;
    
    UIScrollView *mainscroll;
    
    UIActivityIndicatorView *aiv;
    
    BOOL flag;
    
}

@end

@implementation CatrgoryViewController

- (void)viewDidLoad {
    
    flag = NO;
    self.navigationItem.title = _catrgorytitle;
    
    mainscroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    mainscroll.delegate = self;
    mainscroll.tag = 11;
    [self.view addSubview:mainscroll];
    
    aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 100, 100, 100)];
    aiv.activityIndicatorViewStyle = 0;
    aiv.backgroundColor = [UIColor grayColor];
    [aiv startAnimating];
    [self.view insertSubview:aiv aboveSubview:mainscroll];
    
    [self _loadData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)_loadData {
    
    articlesDataArray = [NSMutableArray array];
    commondityDataArray = [NSMutableArray array];
    
    NSString *urlString = _urlstring1;
    [[AFHTTPSessionManager manager] GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary * dic = responseObject;
        NSArray *array = dic[@"articles"];
        
        for (int i = 0 ; i < array.count; i ++) {
            NSDictionary *dic1 = array[i];
            ArticlesModel *model = [ArticlesModel yy_modelWithDictionary:dic1];
            model.content = dic1[@"digest"];
            [articlesDataArray addObject:model];
        }
        [self _loadView];
        [aiv stopAnimating];
        
        NSString *string1 = _urlstring2;
        [[AFHTTPSessionManager manager] GET:string1 parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            NSArray *array = responseObject;
            for (NSDictionary *dic in array) {
                
                CommondityModel *model = [CommondityModel yy_modelWithDictionary:dic];
                model.commodityTitle = dic[@"title"];
                [commondityDataArray addObject:model];
                
            }
            [self _loadview1];
            [self _loadView2];
            mainscroll.contentSize = CGSizeMake(0, y );
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    
}

- (void)_loadView {
    
    tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, y + 6, kScreenWidth, 40 + 80 * articlesDataArray.count) style:UITableViewStyleGrouped];
    tableView1.scrollEnabled = NO;
    tableView1.tag = 55;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [tableView1 registerClass:[AtriclesTableViewCell class] forCellReuseIdentifier:@"11"];
    [mainscroll addSubview:tableView1];
    
    
    y += 40 + 80 * MIN(articlesDataArray.count, 3) + 6;
}

- (void)_loadview1 {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kScreenWidth -20, 30)];
    label.text = @"商品";
   
    [mainscroll addSubview:label];
    y += 30;
}

- (void)_loadView2 {
    
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y + 6, kScreenWidth, ((kScreenWidth - 40) /  2 + 105) * 5 + 64) collectionViewLayout:layout];
    collectionView.tag = 22;
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[EntityCollectionViewCell class] forCellWithReuseIdentifier:@"EntityCollectionViewCell"];
    [mainscroll addSubview:collectionView];
    
    y += ((kScreenWidth - 40) /  2 + 105) * 5 + 49 + 64;
    //NSLog(@"%f",y);
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AtriclesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"11" forIndexPath:indexPath];
    cell.model = articlesDataArray[indexPath.row];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MIN(articlesDataArray.count, 3) ;
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
    label.text = @"图文";
    [view addSubview:label];
    if (articlesDataArray.count > 3) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth - 60, 10, 60, 20);
        [button setTitle:@"更多" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:backColor forState:UIControlStateNormal];
        [view addSubview:button];
    }
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

#pragma mark collectionviewdatasourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ((collectionView.tag == 22)) {
        return 10;
    }else {
        return commondityDataArray.count - 10;
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EntityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EntityCollectionViewCell" forIndexPath:indexPath];
    if ((collectionView.tag == 22)) {
        cell.model = commondityDataArray[indexPath.row];
    } else {
        cell.model = commondityDataArray[indexPath.row + 10];
    }
    
    
    return cell;
    
}

#pragma mark collectionViewFLowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth - 20) / 2,((kScreenWidth - 40) /  2 + 105) );
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



# pragma mark uiscrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 11) {
        
        if (scrollView.contentOffset.y > 1176) {
            if (!flag) {
                [self _loadview3];
                mainscroll.contentSize = CGSizeMake(0, y );
                flag = YES;
            }
           // NSLog(@"%f",scrollView.contentOffset.y);
        }
    }
}

- (void)_loadview3 {
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y + 6 - 49, kScreenWidth, 40 + ((kScreenWidth - 40) /  2 + 105) * ((commondityDataArray.count + 1) / 2 - 5) + 64) collectionViewLayout:layout];
    collectionView.tag = 33;
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[EntityCollectionViewCell class] forCellWithReuseIdentifier:@"EntityCollectionViewCell"];
    [mainscroll addSubview:collectionView];
    
    y += ((kScreenWidth - 40) /  2 + 105) * ((commondityDataArray.count + 1) / 2 - 5) + 49 + 64;
    
}

- (void)buttonAction {
    
    CatrgoryGraphicdVievController *catrgory = [[CatrgoryGraphicdVievController alloc] init];
    catrgory.dataArray = articlesDataArray;
    [self.navigationController pushViewController:catrgory animated:NO];
}

@end
