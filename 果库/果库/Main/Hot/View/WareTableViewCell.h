//
//  WareTableViewCell.h
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WareLayout.h"

@interface WareTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *pictureImageView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *likeCountLabel;

@property (nonatomic, strong) UIButton *likeButton;

@property (nonatomic, strong) WareLayout *layout;

@end
