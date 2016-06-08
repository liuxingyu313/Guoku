
//
//  AuthorizedUserView.m
//  果库
//
//  Created by HZApple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "AuthorizedUserView.h"
#import "UIImageView+WebCache.h"
#import "UIView+FindViewcontroller.h"
#import "AuthorizedViewController.h"

@implementation AuthorizedUserView

- (void)setModel:(AuthorizeduserUserModel *)model {
    _model = model;
    [self _loadView];
}



- (void)_loadView {
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _iconImageView.layer.cornerRadius = 25;
    _iconImageView.layer.masksToBounds = YES;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatar_small]];

    [self addSubview:_iconImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 50, 15)];
    label.font = k12Font;
    label.text = _model.nick;
    [self addSubview:label];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    if ([_iconImageView pointInside:location withEvent:event]) {
        
        UIViewController *viewcontroller = [_iconImageView findViewcontroller];
        
        AuthorizedViewController *authorized = [[AuthorizedViewController alloc] init];
        authorized.articlesModel = _model;
        
        [viewcontroller.navigationController pushViewController:authorized animated:YES];
       // viewcontroller.hidesBottomBarWhenPushed = NO;
    }
    
}

@end
