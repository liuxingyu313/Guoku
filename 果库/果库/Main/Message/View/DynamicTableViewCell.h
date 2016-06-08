//
//  DynamicTableViewCell.h
//  果库
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicLayout.h"

@interface DynamicTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userImgView;

@property (nonatomic, strong) UILabel *userLabel;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *nickLabel;

@property (nonatomic, strong) UILabel *timeLabel;


//@property (nonatomic, strong) UIImageView *dynamicImgView;
@property (nonatomic, strong) UIButton *chiefButton;


@property (nonatomic, strong) DynamicLayout *layout;


@end
