//
//  MessageViewController.m
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "MessageViewController.h"
#import "YYModel.h"
#import "DataService.h"
#import "DynamicModel.h"
#import "MessageModel.h"
#import "DynamicTableViewCell.h"
#import "MessageTableViewCell.h"
#import "NSString+TimeAgo.h"
#import "DynamicLayout.h"
#import "MessageLayout.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIButton *button1;
    UIButton *button2;
    UIView *_view;
    UIView *_view1;
}

@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UITableView *dynamicTableView;

@property (nonatomic, strong) UITableView *messageTableView;

@property (nonatomic, strong) NSMutableArray *dynamicDataArray;

@property (nonatomic, strong) NSMutableArray *messageDataArray;



@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    [self _loadData];
//    [self _loadView];
    self.tabBarController.tabBar.hidden = NO;
    
}



- (void)_loadView {
   
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(kScreenWidth / 3 - 30, 6, 50, 25);
    [button1 setTitle:@"动态" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(button1Action)  forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:button1];
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth / 3 * 2 - 30, 6, 50, 25);
    [button2 setTitle:@"消息" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button2 addTarget:self action:@selector(button2Action)  forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:button2];
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(button1.left, button1.bottom + 6, 50, 3)];
    _view1.backgroundColor = [UIColor redColor];
    [_view addSubview:_view1];
    
    [self.navigationController.navigationBar addSubview:_view];
}

//加载数据
- (void)_loadData {
    _dynamicDataArray = [NSMutableArray array];
    _messageDataArray = [NSMutableArray array];
    
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    view.frame = CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 50 ,100, 100);
    [self.scroll addSubview:view];
    [view startAnimating];
    
    //使用AFNetworking的二次封装

    //动态界面
    NSString *urlString = @"mobile/v4/feed/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&scale=friend&session=bf883e61868a00a3c69914bdb5f75f46&sign=5b15d03389da975e6266b8cb336b8c2c&timestamp=1464350593&type=entity";
    
    [DataService requestWithURL:urlString params:nil fileData:nil httpMethod:@"get" success:^(NSURLSessionDataTask *task, id result) {
      //  NSLog(@"%@",result);
        for (NSDictionary *dic in result) {
            NSDictionary *dic1 = dic[@"content"];
            NSDictionary *dic2 = dic1[@"liker"];
            NSDictionary *dic3 = dic1[@"entity"];
            
            DynamicModel *model = [DynamicModel yy_modelWithDictionary:dic3];
            model.type = dic[@"type"];  //类型
            model.created_time = [NSString TimeAgo:[dic[@"created_time"] stringValue]];
            model.avatar_small = dic2[@"avatar_small"]; //用户图片
            model.nick = dic2[@"nick"]; //用户名
            
            DynamicLayout *layout = [[DynamicLayout alloc] init];
            layout.model = model;
            
            
            //转化时间
            
            
            [_dynamicDataArray addObject:layout];
            
        }
        _scroll = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scroll.contentSize = CGSizeMake(2 * kScreenWidth, 0);
        _scroll.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
        _scroll.tag = 33;
        _scroll.pagingEnabled = YES;
        _scroll.delegate = self;
        [self.view addSubview:_scroll];
        
        
        while (_dynamicDataArray == 0) {
            [NSThread sleepForTimeInterval:1];
        }
        _dynamicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
        [_dynamicTableView registerClass:[DynamicTableViewCell class] forCellReuseIdentifier:@"11"];
        _dynamicTableView.tag = 11;
        _dynamicTableView.delegate = self;
        _dynamicTableView.dataSource = self;
        [_scroll addSubview:_dynamicTableView];
        
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth , 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
        [_messageTableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"22"];
        _messageTableView.tag = 22;
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        [_scroll addSubview:_messageTableView];
        

        
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
    //消息界面
    NSString *urlString1 = @"mobile/v4/message/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&count=30&session=bf883e61868a00a3c69914bdb5f75f46&sign=1ef993065a8505811261cba5c6030ba4&timestamp=1464446234.056399";
    
    [DataService requestWithURL:urlString1 params:nil fileData:nil httpMethod:@"get" success:^(NSURLSessionDataTask *task, id result) {
         // NSLog(@"%@",result);
        for (NSDictionary *dic in result) {
            NSDictionary *dic1 = dic[@"content"];
            NSDictionary *dic2 = dic1[@"follower"];
            MessageModel *model = [MessageModel yy_modelWithDictionary:dic2];
            model.created_time = [NSString TimeAgo:[dic[@"created_time"] stringValue]];
            model.type = dic[@"type"];  //类型
            
            MessageLayout *layout = [[MessageLayout alloc] init];
            layout.model = model;

            
            [_messageDataArray addObject:layout];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
    
}





#pragma mark tableviewdatasourse

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView.tag == 11) {
        DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"11" forIndexPath:indexPath];
        cell.layout = _dynamicDataArray[indexPath.row];
        return cell;
    }
    
        MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"22" forIndexPath:indexPath];
        cell.layout = _messageDataArray[indexPath.row];
        
        return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 11) {
        return _dynamicDataArray.count;
    }
    return _messageDataArray.count;
}
#pragma mark tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 11) {
        return 60;
    }
    return 65;

}


#pragma mark scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 33) {
        CGFloat x = scrollView.contentOffset.x;
        
        NSInteger i = x / kScreenWidth;
        
        if (i == 0) {
            _view1.left = button1.left;
            button1.selected = YES;
            button2.selected = NO;
        }else {
            _view1.left = button2.left;
            button2.selected = YES;
            button1.selected = NO;
        }
        
        
    }
    
}


#pragma mark buttonAction
- (void)button1Action {
    
    button1.selected = YES;
    button2.selected = NO;
    _view1.left = button1.left;
    _scroll.contentOffset = CGPointMake(0, 0);
}

- (void)button2Action {
    _view1.left = button2.left;
    button2.selected = YES;
    button1.selected = NO;
    _scroll.contentOffset = CGPointMake(kScreenWidth, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    [self _loadView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_view removeFromSuperview];
    self.tabBarController.tabBar.hidden = YES;
}




@end
