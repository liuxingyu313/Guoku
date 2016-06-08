//
//  AtriclesTableViewCell.h
//  果库
//
//  Created by HZApple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesModel.h"

@interface AtriclesTableViewCell : UITableViewCell

@property (nonatomic, strong) ArticlesModel *model;

@property (nonatomic, strong) UIImageView *cover;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *conentLabel;

@end
