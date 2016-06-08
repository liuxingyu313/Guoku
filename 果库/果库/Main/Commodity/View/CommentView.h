//
//  CommentView.h
//  果库
//
//  Created by HZApple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentView : UIView

@property (nonatomic, strong) UIButton *iconButton;

@property (nonatomic, strong) UIButton *nickButton;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UILabel *pariseLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) CommentModel *model;

@end
