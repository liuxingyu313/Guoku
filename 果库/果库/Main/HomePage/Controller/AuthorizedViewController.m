//
//  AuthorizedViewController.m
//  果库
//
//  Created by HZApple on 16/5/31.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "AuthorizedViewController.h"
#import "AtriclesTableViewCell.h"
#import "ArticlesModel.h"
#import "YYModel.h"
#import "AFNetworking.h"
#import "WebViewController.h"

@interface AuthorizedViewController()<UIScrollViewDelegate> {
    
    NSMutableArray *graphicDataArray;
    UITableView *table;
    UIActivityIndicatorView *aiv;
    
    UIScrollView *mainscroll;
    
    CGFloat y ;
    
    BOOL flag;
}

@end

@implementation AuthorizedViewController

- (void)viewDidLoad {
    
    y = 0;
    
    flag = NO;
    
    //self.tabBarController.tabBar.hidden = YES;
    
    mainscroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    mainscroll.delegate = self;
    [self.view addSubview:mainscroll];
    
    self.navigationItem.title = _articlesModel.nick;
    
    table = [[UITableView alloc] initWithFrame:self.view.bounds];
    table.delegate = self;
    table.dataSource = self;
    table.scrollEnabled = NO;
    [table registerClass:[AtriclesTableViewCell class] forCellReuseIdentifier:@"AtriclesTableViewCell"];
    [mainscroll addSubview:table];
    
    aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 25, kScreenHeight / 2 + 100, 50, 50)];
    aiv.activityIndicatorViewStyle = 0;
    aiv.backgroundColor = [UIColor grayColor];
    [aiv startAnimating];
    [self.view insertSubview:aiv aboveSubview:table];
    
    [self _loadData];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}


- (void)_loadData {
    
    graphicDataArray = [NSMutableArray array];
    

    
    NSString *urlString = @"http://api.guoku.com/mobile/v4/user/1993734/articles/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=97fdf2a699eca4fd9fe3785d501d86c0&size=10";
    [[AFHTTPSessionManager manager] GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"articles"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary *dic1 = array[i];
            ArticlesModel *model = [ArticlesModel yy_modelWithDictionary:dic1];
            model.content = dic1[@"digest"];
            [graphicDataArray addObject:model];

        }
    
        [table reloadData];
         y += graphicDataArray.count * 80 + 200;
        table.frame = CGRectMake(0, 0, kScreenWidth, y);
        mainscroll.contentSize = CGSizeMake(0 , y + 49);
        [aiv stopAnimating];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    
}

- (void)_loadNewData {

    
    NSString *urlString = @"http://api.guoku.com/mobile/v4/user/1993734/articles/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=2&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=efcb3d9b3ed098d899d575f4e7b2433a&size=10";
    [[AFHTTPSessionManager manager] GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"articles"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary *dic1 = array[i];
            ArticlesModel *model = [ArticlesModel yy_modelWithDictionary:dic1];
            model.content = dic1[@"digest"];
            [graphicDataArray addObject:model];
            
        }
        
        [table reloadData];
        y += (graphicDataArray.count - 12 ) * 80 + 200;
        table.frame = CGRectMake(0, 0, kScreenWidth, y);
        mainscroll.contentSize = CGSizeMake(0 , y + 49);
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

#pragma mark tableViewdelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    view.backgroundColor = backColor;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 20, 20, 40, 40)];
    icon.layer.cornerRadius = 20;
    icon.layer.masksToBounds = YES;
    
    NSURL *url = [NSURL URLWithString:_articlesModel.avatar_small];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    icon.image= image;
    
    [view addSubview:icon];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, icon.bottom + 10, kScreenWidth, 20)];
    titleLabel.textAlignment = 1;
    titleLabel.font = k15Font;
    titleLabel.text = _articlesModel.nick;
    [view addSubview:titleLabel];
    
    UILabel *bioLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom + 5, kScreenWidth, 20)];
    bioLabel.textAlignment = 1;
    bioLabel.font = k14Font;
    bioLabel.text = _articlesModel.bio;
    [view addSubview:bioLabel];
    
    UILabel *followLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 100, bioLabel.bottom + 10, 100 , 20)];
    followLabel.textAlignment = 1;
    followLabel.text = [NSString stringWithFormat:@"关注%@",_articlesModel.like_count];
    [view addSubview:followLabel];
    
    UILabel *fanLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 , bioLabel.bottom + 10, 100, 20)];
    fanLabel.textAlignment = 1;
    fanLabel.text = [NSString stringWithFormat:@"粉丝%@",_articlesModel.fan_count];
    [view addSubview:fanLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth / 2 - 75, followLabel.bottom + 10, 150, 20);
    [button setTitle:@"+ 关注" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [view addSubview:button];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    ArticlesModel *model = graphicDataArray[indexPath.row];
    WebViewController *webview = [[WebViewController alloc] init];
    webview.url = model.url;
    
    [self.navigationController pushViewController:webview animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark tableviewdatasourse

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AtriclesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AtriclesTableViewCell" forIndexPath:indexPath];
    cell.model = graphicDataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return graphicDataArray.count;
}

#pragma mark scrollviewdelegatr 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {


    if (scrollView.contentOffset.y > 362) {
        if (!flag) {
            [self _loadNewData];
            flag = YES;
        }
    }
    
}

@end
