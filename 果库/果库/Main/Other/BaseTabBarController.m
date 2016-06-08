//
//  BaseTabBarController.m
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "BaseTabBarController.h"
#import "GKTabBarButton.h"

@interface BaseTabBarController () {
     UIImageView *_selectImage;
}

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadSubViewCtrls];
     [self _createCustomTabBar];
    // Do any additional setup after loading the view.
}

- (void)_loadSubViewCtrls {
    
    NSArray *storyboardNames = @[@"Hot", @"Homepage", @"Message", @"Personal"];
    
    NSMutableArray *navs = [NSMutableArray array];
    
    for (NSString *name in storyboardNames) {
        
        //获取到故事板
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        
        //加载故事板中的导航控制器--initial Controller
        UINavigationController *nav = [storyBoard instantiateInitialViewController];
        
        [navs addObject:nav];
        
    }
  
    self.viewControllers = navs;
    
    
}

- (void)_createCustomTabBar {
    
    //移除系统自带的tabBar按钮
    for (UIView *view in self.tabBar.subviews) {

        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [view removeFromSuperview];
            
        }
    }
    
     CGFloat itemWidth = kScreenWidth / 4;
    
     //tabBar背景图片
     [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg_all@2x"]];
     
     //选中背景图片
     _selectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectTabBar_ba_all1@2x"]];
     _selectImage.frame = CGRectMake(6, 1, kScreenWidth / 4 - 18, 45);
     [self.tabBar addSubview:_selectImage];
     
     NSArray *nameArray = @[@"热门商品",@"主页",@"消息",@"个人"];
     NSArray *imageArray = @[
                             @"hot_tabBar",
                             @"homePage_tabBar",
                             @"message_tabBar",
                             @"personal_tabBar"
                             ];
     
     for (NSInteger i = 0; i < nameArray.count; i++) {
        
//         UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//         button.frame = CGRectMake(i * width, 0, width, kTabbarHeight);
//         [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
//        
//         button.tag = i;
//        
//         [button setTitle:nameArray[i] forState:UIControlStateNormal];
//         [button setTitle:nameArray[i] forState:UIControlStateHighlighted];
//         [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//         [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//         
//         button.backgroundColor = [UIColor blackColor];
         
         NSString *title = nameArray[i];
         NSString *imgName = imageArray[i];
         
         GKTabBarButton *item = [[GKTabBarButton alloc] initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, 49) withImgName:imgName withTitle:title];
         [item addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
         item.tag = 100 + i;
//          item.tag = i;
//         item.backgroundColor = [UIColor redColor];
          
         [self.tabBar addSubview:item];
    }
      _selectImage.center = [self.tabBar viewWithTag:100].center;
}

- (void)clickButton:(UIButton *)button {
     
     self.selectedIndex = button.tag - 100;
     
     [UIView animateWithDuration:0.3 animations:^{

          _selectImage.center = button.center;
 
     }];
     
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
