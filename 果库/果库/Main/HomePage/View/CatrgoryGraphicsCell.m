//
//  CatrgoryGraphicsCell.m
//  果库
//
//  Created by HZApple on 16/5/31.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CatrgoryGraphicsCell.h"

@implementation CatrgoryGraphicsCell

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth / 3 * 2 - 20, 50)];
        _titleLabel.font = k15Font;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)coverImageView {
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + _titleLabel.right, 10, kScreenWidth / 3, 60)];
        [self addSubview:_coverImageView];
    }
    return _coverImageView;
}

- (void)setModel:(ArticlesModel *)model {
    _model = model;
    self.titleLabel.text = _model.title;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",GuoKuWebImage, _model.cover]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    self.coverImageView.image = image;
    
}

@end
