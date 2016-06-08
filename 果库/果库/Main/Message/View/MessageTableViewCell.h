//
//  MessageTableViewCell.h
//  果库
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageLayout.h"

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userImgView;

@property (nonatomic, strong) UILabel *userLabel;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic,strong) MessageLayout *layout;

@end
