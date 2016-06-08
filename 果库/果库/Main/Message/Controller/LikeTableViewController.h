//
//  LikeTableViewController.h
//  果库
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeTableViewController : UITableViewController

@property (nonatomic, copy) NSString *like_count;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) NSNumber *following_count; //关注数
@property (nonatomic, copy) NSString *avatar_small; //用户头像
@property (nonatomic, copy) NSString *nick; //用户名
@property (nonatomic, assign) NSNumber *fan_count; //粉丝数

@property (nonatomic,strong) UIButton *button;

@end
