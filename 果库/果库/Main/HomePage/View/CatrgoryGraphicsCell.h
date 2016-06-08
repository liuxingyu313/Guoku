//
//  CatrgoryGraphicsCell.h
//  果库
//
//  Created by HZApple on 16/5/31.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesModel.h"

@interface CatrgoryGraphicsCell : UITableViewCell

@property (nonatomic, strong) ArticlesModel *model;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *coverImageView;


@end
