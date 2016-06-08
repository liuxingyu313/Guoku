//
//  LikeTableViewCell.h
//  果库
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeModel.h"

@interface LikeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userImgView;

@property (nonatomic, strong) UILabel *userLabel;

@property (nonatomic, strong) UILabel *followLabel;

@property (nonatomic, strong) UILabel *fanLabel;

@property (nonatomic,strong) UIButton *followButton;

@property (nonatomic,strong) LikeModel *model;

@end
