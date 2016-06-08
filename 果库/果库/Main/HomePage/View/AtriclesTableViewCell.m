//
//  AtriclesTableViewCell.m
//  果库
//
//  Created by HZApple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "AtriclesTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation AtriclesTableViewCell

- (UIImageView *)cover {
    if (_cover == nil) {
        _cover = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 60)];
        [self addSubview:_cover];
    }
    return _cover;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, kScreenWidth - 140, 30)];
        _titleLabel.font = k14Font;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)conentLabel {
    if (_conentLabel == nil) {
        
        _conentLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, kScreenWidth - 130, 34)];
        _conentLabel.font = k12Font;
        _conentLabel.numberOfLines = 2;
        [self addSubview:_conentLabel];
    }
    return _conentLabel;
}


- (void)setModel:(ArticlesModel *)model {
    
    self.backgroundColor = [UIColor whiteColor];
    _model = model;
    NSString *string;
    if (![_model.cover hasPrefix:@"http"]) {
         string = [NSString stringWithFormat:@"%@/%@",GuoKuWebImage,_model.cover];
    }else {
       string = _model.cover;
    }
    
   
    
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    self.cover.image = image;
    //[self.imageView sd_setImageWithURL:[NSURL URLWithString:string]];
    self.titleLabel.text = _model.title;
    self.conentLabel.text = _model.content;
    
}

@end
