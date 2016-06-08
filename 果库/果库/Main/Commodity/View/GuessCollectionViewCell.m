//
//  GuessCollectionViewCell.m
//  果库
//
//  Created by HZApple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "GuessCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+FindViewcontroller.h"
#import "CommodityViewController.h"

@implementation GuessCollectionViewCell

- (UIImageView *)chiefImageView {
    if (_chiefImageView == nil) {
        _chiefImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_chiefImageView];
    }
    return _chiefImageView;
}

- (void)setModel:(GuessModel *)model {
    
    _model = model;
    
    [self.chiefImageView sd_setImageWithURL:[NSURL URLWithString:_model.chief_image]];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_chiefImageView];
    if ([_chiefImageView pointInside:location withEvent:event]) {
        
        UIViewController *viewcontroller = [_chiefImageView findViewcontroller];
        
       
        viewcontroller.hidesBottomBarWhenPushed = YES;
        CommodityViewController *commodity = [[CommodityViewController alloc] init];
        
        commodity.chief_image = _model.chief_image;
        commodity.commodityTitle = _model.commodityTitle;
        commodity.price = _model.price;
        commodity.detail_images = _model.detail_images;
        commodity.like_count = [NSString stringWithFormat:@"%@",_model.like_count];
        
        [viewcontroller.navigationController pushViewController:commodity animated:YES];
        
        
        
    }
}

@end
