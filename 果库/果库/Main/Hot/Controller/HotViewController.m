//
//  HotViewController.m
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "HotViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "WareTableViewCell.h"
#import "WareModel.h"
#import "WareLayout.h"
#import "GraphicsTableViewCell.h"
#import "GraphicsModel.h"
#import "GraphicsLayout.h"


@interface HotViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, NSURLSessionDataDelegate> {
    UIButton *button1;
    UIButton *button2;
    UIView *view1;
    UIView *backview;
    
    UIActivityIndicatorView *aiv;
    
}

@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UITableView *wareTableView;

@property (nonatomic, strong) UITableView *graphicsTableView;

@property (nonatomic, strong) NSMutableArray *wareDataArray;

@property (nonatomic, strong) NSMutableArray *graphicsDataArray;

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    //self.navigationController.navigationBar.backgroundColor = [UIColor]
    
    
    _scroll = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scroll.contentSize = CGSizeMake(2 * kScreenWidth, 0);
    _scroll.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
    _scroll.tag = 33;
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 100, 100, 100)];
    aiv.activityIndicatorViewStyle = 0;
    aiv.backgroundColor = [UIColor grayColor];
    [aiv startAnimating];
    [self.view insertSubview:aiv aboveSubview:_scroll];
    
    [self _loadData];
    
    
    while (_wareDataArray.count == 0) {
        [NSThread sleepForTimeInterval:1];
    }

    
    _wareTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    [_wareTableView registerClass:[WareTableViewCell class] forCellReuseIdentifier:@"11"];
    _wareTableView.tag = 11;
    _wareTableView.delegate = self;
    _wareTableView.dataSource = self;
    [_scroll addSubview:_wareTableView];
    

    _graphicsTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [_graphicsTableView registerClass:[GraphicsTableViewCell class] forCellReuseIdentifier:@"22"];
    _graphicsTableView.tag = 22;
    _graphicsTableView.delegate = self;
    _graphicsTableView.dataSource = self;
    [_scroll addSubview:_graphicsTableView];
    
    
    // Do any additional setup after loading the view.
}

- (void)_loadView {
    
    backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    backview.backgroundColor = [UIColor whiteColor];
    
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(kScreenWidth / 3 - 30, 6, 50, 25);
    [button1 setTitle:@"商品" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(button1Action)  forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:button1];
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth / 3 * 2 - 30, 6, 50, 25);
    [button2 setTitle:@"图文" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button2 addTarget:self action:@selector(button2Action)  forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:button2];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(button1.left, button1.bottom + 6, 50, 3)];
    view1.backgroundColor = [UIColor redColor];
    [backview addSubview:view1];
    
    [self.navigationController.navigationBar addSubview:backview];
    
}

- (void)_loadData {
    
   _wareDataArray = [NSMutableArray array];
//    _wareArray = [NSMutableArray array];
   _graphicsDataArray = [NSMutableArray array];
//    _graphicsArray = [NSMutableArray array];
//    
//    
//    NSString *string = @"http://api.guoku.com/mobile/v4/selection/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&count=30&rcat=0&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=6f0737d0f5819c5e43bca9a71d44ff44&timestamp=1464229424.321447";
//
//    
//    [[AFHTTPSessionManager manager] GET:string parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        
//        _wareArray =  responseObject;
//        
//        
//        for (NSDictionary *dic in _wareArray) {
//            
//            WareModel *model = [WareModel yy_modelWithDictionary:dic];
//            WareLayout *layout = [[WareLayout alloc] init];
//            layout.model = model;
//            [_wareDataArray addObject:layout];
//        }
//       
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//    
//  
//    
//    NSString *string1 = @"http://api.guoku.com/mobile/v4/articles/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=f4a1788fe5a912b912232d70f2b7d464&size=20&timestamp=1464230822.062401";
//    [[AFHTTPSessionManager manager] GET:string1 parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        
//        _graphicsArray =  responseObject;
//        
//        
//        for (NSDictionary *dic in _graphicsArray) {
//            
//            GraphicsModel *model = [GraphicsModel yy_modelWithDictionary:dic];
//            GraphicsLayout *layout = [[GraphicsLayout alloc] init];
//            layout.model = model;
//            [_graphicsDataArray addObject:layout];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    
   UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    view.frame = CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 50 ,100, 100);
    [self.scroll addSubview:view];
    [view startAnimating];
     NSURL *url = [NSURL URLWithString:@"http://api.guoku.com/mobile/v4/selection/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&count=30&rcat=0&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=b23317482802a4dfd8d7b1bbc5afc138&timestamp=1464415822.353371"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求出错:%@", error);
            return;
        }
        
        
        NSArray * array= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
        for (NSDictionary *dic in array) {
            
            NSDictionary *dic1 = dic[@"content"];
            NSDictionary *dic2 = dic1[@"entity"];
            NSDictionary *dic3 = dic1[@"note"];
            
            
            WareModel *model = [WareModel yy_modelWithDictionary:dic2];
            model.post_time = dic[@"post_time"];
            model.content = dic3[@"content"];
            
            NSArray *dic4 = dic2[@"item_list"];
            NSDictionary *dic5 = dic4[0];
            model.buy_link = dic5[@"buy_link"];
            
            WareLayout *layout = [[WareLayout alloc] init];
            layout.model = model;
            [_wareDataArray addObject:layout];
      }
        
        
    }];
    [dataTask resume];
    
    NSURL *url1 = [NSURL URLWithString:@"http://api.guoku.com/mobile/v4/articles/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=f4a1788fe5a912b912232d70f2b7d464&size=20&timestamp=1464230822.062401"];
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url1];
    request1.HTTPMethod = @"GET";
    request1.timeoutInterval = 60;
    NSURLSession *session1 = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask1 = [session1 dataTaskWithRequest:request1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求出错:%@", error);
            return;
        }
        
        NSArray * array= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
        for (NSDictionary *dic in array) {
        
            GraphicsModel *model = [GraphicsModel yy_modelWithDictionary:dic];
            GraphicsLayout *layout = [[GraphicsLayout alloc] init];
            layout.model = model;
            [_graphicsDataArray addObject:layout];
        }
        
        
    }];
    
    
    [dataTask1 resume];
    [aiv stopAnimating];
}

#pragma mark tableviewdatasourse

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    if (tableView.tag == 11) {
        WareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"11" forIndexPath:indexPath];
        cell.layout = _wareDataArray[indexPath.row];
        return cell;
    }
    GraphicsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"22" forIndexPath:indexPath];
    cell.layout = _graphicsDataArray[indexPath.row];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 11) {
        return _wareDataArray.count;
    }
    return _graphicsDataArray.count;
}
#pragma mark tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 11) {
        return [_wareDataArray[indexPath.row] cellHeight];
    }
    return [_graphicsDataArray[indexPath.row] cellHeight];
}


#pragma mark scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 33) {
        CGFloat x = scrollView.contentOffset.x;
        
        NSInteger i = x / kScreenWidth;
        
        if (i == 0) {
            view1.left = button1.left;
            button1.selected = YES;
            button2.selected = NO;
        }else {
            view1.left = button2.left;
            button2.selected = YES;
            button1.selected = NO;
        }
        
        
    }
    
}
#pragma mark buttonAction
- (void)button1Action {
    
    button1.selected = YES;
    button2.selected = NO;
    view1.left = button1.left;
    _scroll.contentOffset = CGPointMake(0, 0);
}

- (void)button2Action {
    view1.left = button2.left;
    button2.selected = YES;
    button1.selected = NO;
    _scroll.contentOffset = CGPointMake(kScreenWidth, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillDisappear:(BOOL)animated {
    
    [backview removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated{
    [self _loadView];

    
}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
