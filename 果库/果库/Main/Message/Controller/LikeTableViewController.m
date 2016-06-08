//
//  LikeTableViewController.m
//  果库
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "LikeTableViewController.h"
#import "DataService.h"
#import "LikeModel.h"
#import "YYModel.h"
#import "LikeTableViewCell.h"

@interface LikeTableViewController ()

@property (nonatomic, strong) NSMutableArray *likeDataArray;

//@property (nonatomic, strong) UITableView *likeTableView;

//http://api.guoku.com/mobile/v4/authorized/users/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=46234c406577b65a77fce348307c03a0&size=30

@end

@implementation LikeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    if (_tag == 1) {
        self.navigationItem.title = [NSString stringWithFormat:@"%@人喜爱",_like_count];
    }else if (_tag == 2){
        self.navigationItem.title = @"推荐用户";
    }
    
    [self _loadData];
}


- (void)_loadData {
    _likeDataArray = [NSMutableArray array];
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    view.frame = CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 50 ,100, 100);
    [self.view addSubview:view];
    [view startAnimating];
    
    //使用AFNetworking的二次封装
    
    //界面
    NSString *urlString ;
    if (_tag == 1) {
        urlString = @"mobile/v4/entity/4632767/liker/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&session=bf883e61868a00a3c69914bdb5f75f46&sign=dd84ecfe5c237494108ca4f7c2b64b05";
    }else if (_tag == 2) {
        urlString = @"mobile/v4/authorized/users/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=46234c406577b65a77fce348307c03a0&size=30";
    }

    [DataService requestWithURL:urlString params:nil fileData:nil httpMethod:@"get" success:^(NSURLSessionDataTask *task, id result) {
       // NSLog(@"%@",result);
        NSArray *array;
        if (_tag == 1) {
            array = result[@"data"];
        }else if (_tag == 2) {
            array = result[@"authorized_user"];
        }
        
        for (NSDictionary *dic in array) {
            
            LikeModel *model = [LikeModel yy_modelWithDictionary:dic];
            model.avatar_small = dic[@"avatar_small"]; //用户图片
            model.nick = dic[@"nick"];
            model.following_count = dic[@"following_count"];
            model.fan_count = dic[@"fan_count"];
            
            //转化时间
            
            
            [_likeDataArray addObject:model];
    
        }

        [self.tableView registerClass:[LikeTableViewCell class] forCellReuseIdentifier:@"10"];

        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
    [view stopAnimating];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _likeDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"10" forIndexPath:indexPath];
    
    cell.model = _likeDataArray[indexPath.row];
    return cell;
}

#pragma mark tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
