//
//  SetupViewController.m
//  果库
//
//  Created by mac on 2015/07/06.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "SetupViewController.h"
#import "SetupDetailCell.h"

@interface SetupViewController () {
    
}
//
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;




@end

@implementation SetupViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor clearColor];
    
//    [self _createUI];
//    [self.view addSubview:_setupTableView];
//    
//    _setupTableView.delegate = self;
//    _setupTableView.dataSource = self;
    
}


- (void)_createUI {
    
    [self.setupTableView registerNib:[UINib nibWithNibName:@"Personal" bundle:nil] forCellReuseIdentifier:@"SetupDetailCell"];
}

#pragma mark - UITableViewDataSource

//一个tableview上分4个组，每组2个cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (NSInteger i = 0; i < 3; i++) {
        
        for (NSInteger j = 0; j < 2; j++) {
            
            if (indexPath.section == i) {
                
                NSString *cellIdentifier = [NSString stringWithFormat:@"SetupDetailCell%ld", i + 1];
                if (indexPath.row == j) {
                    NSString *finCellIdentifer = [cellIdentifier stringByAppendingString:[NSString stringWithFormat:@"%ld", j]];
                    
                    SetupDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:finCellIdentifer forIndexPath:indexPath];
                    
                    return cell;
                }
            }
        }
    }
    return nil;
}


#pragma mark - UITableViewDelegate

//组头前的高度为2
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2;
}

//组间的高度为8
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

//每组中一个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"zhou yang haha ");
}
@end
