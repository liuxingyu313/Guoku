//
//  EntityCollectionViewCell.m
//  果库
//
//  Created by mac106 on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "EntityCollectionViewCell.h"
#import "UIView+FindViewcontroller.h"
#import "CommodityViewController.h"

@implementation EntityCollectionViewCell

- (UIImageView *)chief {
    if (_chief == nil) {
        _chief = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, (kScreenWidth - 40) / 2, (kScreenWidth - 40) / 2 )];
        [self addSubview:_chief];
    }
    return _chief;
}

- (UILabel *)brand {
    if (_brand == nil) {
        _brand = [[UILabel alloc] initWithFrame:CGRectMake(10, _chief.bottom + 5, _chief.width - 10, 20)];
        [self addSubview:_brand];
    }
    return _brand;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, _brand.bottom + 5, _chief.width - 10, 40)];
        [self addSubview:_title];
    }
    return _title;
}

- (UILabel *)price {
    if (_price == nil) {
        _price = [[UILabel alloc] initWithFrame:CGRectMake(10, _title.bottom + 5, 100, 20)];
        _price.textColor = [UIColor blueColor];
        [self addSubview:_price];
    }
    return _price;
}

- (void)setModel:(CommondityModel *)model {
    
    _model = model;
    NSURL *url = [NSURL URLWithString:_model.chief_image];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    self.chief.image = image;
    
    self.brand.text = _model.brand;
    self.title.text = _model.commodityTitle;
    self.price.text = [NSString stringWithFormat:@"￥%@",_model.price];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_chief];
    if ([_chief pointInside:location withEvent:event]) {
        
        UIViewController *viewcontroller = [_chief findViewcontroller];
        viewcontroller.hidesBottomBarWhenPushed = YES;
        CommodityViewController *commodity = [[CommodityViewController alloc] init];
        commodity.chief_image = _model.chief_image;
        
        NSString *string = _model.brand;
        if (string.length > 0) {
            string = [string stringByAppendingPathComponent:@" - "];
        }
        string = [string stringByAppendingPathComponent:_model.commodityTitle];
        commodity.commodityTitle = string;
        commodity.price = _model.price;
        commodity.detail_images = _model.detail_images;
        commodity.like_count = [NSString stringWithFormat:@"%@",_model.like_count];
        
        [viewcontroller.navigationController pushViewController:commodity animated:YES];
         viewcontroller.hidesBottomBarWhenPushed = NO;
    }
}

@end
