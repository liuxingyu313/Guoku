//
//  Commen.h
//  KuGou
//
//  Created by 陈淼 on 16/5/18.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#ifndef Commen_h
#define Commen_h


#define WS(weakSelf)  __weak __typeof(self)weakSelf = self;

//默认坐标相关宏定义
#define NavigationBar_HEIGHT 44
#define kTabbarHeight 49
#define UILABEL_DEFAULT_FONT_SIZE 20.0f
#define GuoKuWebImage @"http://imgcdn.guoku.com"
#define GraphicsUrl @"http://m.guoku.com"


//当前系统版本
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

#define IOS7Later [[[UIDevice currentDevice] systemVersion]floatValue]>=7

//判断设备类型
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


//图片大小是360 ＊ 640
#define kWidth(R) (R)*(kScreenWidth)/360
#define kHeight(R) (iPhone4?((R)*(kScreenHeight)/480):((R)*(kScreenHeight)/640))

#define backColor [UIColor colorWithWhite:0.8 alpha:0.8]


#define k12Font [UIFont systemFontOfSize:12.0f]
#define k14Font [UIFont systemFontOfSize:14.0f]
#define k15Font [UIFont systemFontOfSize:15.0f]
#define k18Font [UIFont systemFontOfSize:18.0f]

#endif /* Commen_h */
