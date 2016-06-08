//
//  GuessCollectionViewCell.h
//  果库
//
//  Created by HZApple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuessModel.h"

@interface GuessCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) GuessModel *model;

@property (nonatomic, strong) UIImageView *chiefImageView;

@end
