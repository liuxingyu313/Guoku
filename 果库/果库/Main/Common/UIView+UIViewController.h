//
//  UIView+UIViewController.h
//  04 事件响应者链
//
//  Created by ZhuJiaCong on 16/4/11.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewController)


//查找当前视图所在的视图控制器
- (UIViewController *)ViewController;


@end
