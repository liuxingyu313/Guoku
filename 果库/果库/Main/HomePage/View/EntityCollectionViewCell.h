//
//  EntityCollectionViewCell.h
//  果库
//
//  Created by mac106 on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommondityModel.h"

@interface EntityCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *chief;

@property (nonatomic, strong) UILabel *brand;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *price;

@property (nonatomic, strong) CommondityModel *model;

@end
