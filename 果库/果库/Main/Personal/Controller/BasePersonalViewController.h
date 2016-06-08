//
//  BasePersonalViewController.h
//  果库
//
//  Created by HZApple on 16/6/2.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePersonalViewController : UIViewController{
    UIActivityIndicatorView *aiv;
}

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *PersonButton;
@property (weak, nonatomic) IBOutlet UIView *personlaView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanLabel;

@property (weak, nonatomic) IBOutlet UIView *likeView;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (weak, nonatomic) IBOutlet UIView *graphicView;
@property (weak, nonatomic) IBOutlet UILabel *graphicLabel;
@property (weak, nonatomic) IBOutlet UIButton *graphicButton;

@property (weak, nonatomic) IBOutlet UIView *entityView;
@property (weak, nonatomic) IBOutlet UILabel *entityLabel;
@property (weak, nonatomic) IBOutlet UIButton *entityButton;

@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *tagButton;

@property (nonatomic, strong) NSMutableArray *PersonalDataArray;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL isNotSelf;


@end
