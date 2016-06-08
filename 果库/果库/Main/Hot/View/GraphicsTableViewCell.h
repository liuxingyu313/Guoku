//
//  GraphicsTableViewCell.h
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphicsLayout.h"




@interface GraphicsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *mainImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) GraphicsLayout *layout;



@end
