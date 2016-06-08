//
//  NickNameTableViewController.m
//  果库
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "NickNameViewController.h"
#import "MBProgressHUD.h"
@interface NickNameViewController () {
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UITextField *textField1;

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"呢称";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
- (IBAction)textField:(id)sender {
    UITextField *textField = sender;
    NSString *newTextField = textField.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textField" object:newTextField];
    _textField1.text = newTextField;
    
}

- (void)buttonAction{
    [self.navigationController popViewControllerAnimated:YES];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    HUD.mode = MBProgressHUDModeCustomView;
    
//    HUD.delegate = self;
    HUD.labelText = @"保存成功";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
}









@end
