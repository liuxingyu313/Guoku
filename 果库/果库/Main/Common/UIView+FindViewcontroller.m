//
//  UIView+FindViewcontroller.m
//  果库
//
//  Created by HZApple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "UIView+FindViewcontroller.h"

@implementation UIView (FindViewcontroller)

- (UIViewController *)findViewcontroller {
    
    UIResponder *next = self.nextResponder;
    while (YES) {
        if ([next.nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next.nextResponder;
        }else if (next.nextResponder == nil) {
            return nil;
        }
        next = next.nextResponder;
    }

}

@end
