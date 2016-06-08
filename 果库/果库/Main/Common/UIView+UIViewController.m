//
//  UIView+UIViewController.m
//  04 事件响应者链
//
//  Created by ZhuJiaCong on 16/4/11.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)


- (UIViewController *)ViewController {
    
    
//    if ([self.nextResponder isKindOfClass:[UIViewController class]]) {
//        return (UIViewController *)self.nextResponder;
//    }

    UIResponder *next = self.nextResponder;
    while (YES) {
        
        if ([next.nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next.nextResponder;
        } else if (next.nextResponder == nil) {
            return nil;
        }
        
        next = next.nextResponder;
    }
}


@end
