//
//  BannerView.m
//  果库
//
//  Created by HZApple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "BannerView.h"
#import "UIImageView+WebCache.h"
#import "UIView+FindViewcontroller.h"
#import "WebViewController.h"
#import "CommodityViewController.h"

@implementation BannerView

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    [self _loadview];
}

- (void)_loadview {
    
    UIImageView *banner = [[UIImageView alloc] initWithFrame:self.bounds];
    NSString *string = _dic[@"img"];
    [banner sd_setImageWithURL:[NSURL URLWithString:string]];
    [self addSubview:banner];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    BOOL _isinside =  [self pointInside:location withEvent:event];
    
    if (_isinside) {
        
        NSString *string = _dic[@"url"];
        NSString *string1 = @"http";
        UIViewController *viewController  = [self findViewcontroller];
        if ([string hasPrefix:string1]) {
           
            WebViewController *webview = [[WebViewController alloc] init];
            webview.url = string;
            [viewController.navigationController pushViewController:webview animated:YES];
        }else {
            
            [viewController.navigationController pushViewController:[[CommodityViewController alloc] init] animated:YES];
            
        }
        
    }
    
    
}

@end
