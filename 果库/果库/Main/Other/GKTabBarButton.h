//
//  GKTabBarButton.h
//  果库
//
//  Created by mac on 2015/07/06.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKTabBarButton : UIControl
{
    UIImageView *imageView;
    UILabel *titleLabel;
    //    高亮背景 选中的背景
}

- (instancetype)initWithFrame:(CGRect)frame
                  withImgName:(NSString *) imgName
                    withTitle:(NSString *)title;

- (void)imageForSelected:(NSString *)imageName;
@end
