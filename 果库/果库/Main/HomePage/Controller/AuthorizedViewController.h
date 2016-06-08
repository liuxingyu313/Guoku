//
//  AuthorizedViewController.h
//  果库
//
//  Created by HZApple on 16/5/31.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorizeduserUserModel.h"

@interface AuthorizedViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AuthorizeduserUserModel *articlesModel;


@end
