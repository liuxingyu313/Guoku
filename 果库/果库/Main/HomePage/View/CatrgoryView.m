//
//  CatrgoryView.m
//  果库
//
//  Created by HZApple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CatrgoryView.h"
#import "UIImageView+WebCache.h"
#import "UIView+FindViewcontroller.h"
#import "CatrgoryViewController.h"

@interface CatrgoryView () {
    UIImageView *imageView;
}

@end

@implementation CatrgoryView

- (void)setModel:(CategoryModel *)model {
    _model = model;
    [self _loadView];
}

- (void)_loadView {
    
    imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.cover_url]];
    [self addSubview:imageView];
    
    NSString *string = _model.title;
    
    NSArray *array = [string componentsSeparatedByString:@" "];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth / 4, 30)];
    label.font = k15Font;
    label.textAlignment = 1;
    //NSString *string1 = array[0];
//    NSLog(@"%@",string1);
    label.text = array[0];
    label.textColor = [UIColor whiteColor];
    [imageView addSubview:label];
    
    UILabel *label1= [[UILabel alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth / 4, 30)];
    label1.font = k14Font;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = array[1];
    label1.textColor = [UIColor whiteColor];
    [imageView addSubview:label1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:imageView];
    if ([imageView pointInside:location withEvent:event]) {
        
        UIViewController *viewController = [imageView findViewcontroller];
        viewController.hidesBottomBarWhenPushed = YES;
        CatrgoryViewController *catrgory = [[CatrgoryViewController alloc] init];
        catrgory.catrgorytitle = _model.title;
        catrgory.urlstring1 = @"http://api.guoku.com/mobile/v4/category/1/articles/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=ba08553c317bd7df6d1a79ee7928de7d";
        catrgory.urlstring2 = @"http://api.guoku.com/mobile/v4/category/1/selection/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=d2844d4c918723f4cce06341602a28bc&sort=time";
        
        [viewController.navigationController pushViewController:catrgory animated:YES];
        
    }
    
    
}

@end
