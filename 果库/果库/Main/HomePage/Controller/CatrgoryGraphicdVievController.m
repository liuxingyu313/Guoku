//
//  CatrgoryGraphicdVievController.m
//  果库
//
//  Created by HZApple on 16/5/31.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CatrgoryGraphicdVievController.h"
#import "ArticlesModel.h"
#import "CatrgoryGraphicsCell.h"
#import "WebViewController.h"


@interface CatrgoryGraphicdVievController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CatrgoryGraphicdVievController

- (void)viewDidLoad {
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[CatrgoryGraphicsCell class] forCellReuseIdentifier:@"CatrgoryGraphicsCell"];
    [self.view addSubview:tableview];
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CatrgoryGraphicsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatrgoryGraphicsCell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticlesModel *model = _dataArray[indexPath.row];
    WebViewController *webview= [[WebViewController alloc] init];
    webview.url = model.url;
    [self.navigationController pushViewController:webview animated:NO];
    
}

@end
