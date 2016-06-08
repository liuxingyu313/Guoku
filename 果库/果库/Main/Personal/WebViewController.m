//
//  WebViewController.m
//  果库
//
//  Created by mac106 on 16/5/26.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "WebViewController.h"



#define kweb  @"http://m.guoku.com"

@interface WebViewController ()<UIWebViewDelegate> {
    UIWebView *webview;
    UIActivityIndicatorView *aiv;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.navigationItem.title = @"图文";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    button.backgroundColor = [UIColor cyanColor];
    button.titleLabel.text = @"返回";
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 30, 30);
    button1.backgroundColor = [UIColor cyanColor];
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 30, 30);
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    NSArray *array = @[barButton1, barButton2];
    
    self.navigationItem.rightBarButtonItems = array;
    
    aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 100, 100, 100)];
    aiv.activityIndicatorViewStyle = 0;
    aiv.backgroundColor = [UIColor grayColor];
    
    [self.view insertSubview:aiv atIndex:0];
    
   
    webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webview.delegate = self;
    
    NSString *string1 = @"http";
    
    if ([_url hasPrefix:string1]) {
         [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }else {
        NSString *string = [NSString stringWithFormat:@"%@%@",GraphicsUrl,_url];
        
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
    }
    
   
    [self.view addSubview:webview];
    
    
   
    //NSString *string = [NSString stringWithFormat:@"%@%@",kweb,];
    
    
    
    // Do any additional setup after loading the view.
}


- (void)buttonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)button1Action {
    NSLog(@"button1");
}
- (void)button2Action {
    NSLog(@"button2");
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [aiv startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [aiv stopAnimating];
}

//- (void)webviewUrl:(NSNotification *)notifation {
//    NSString *string = [NSString stringWithFormat:@"%@%@",GraphicsUrl,notifation.object];
//    NSLog(@"%@",string);
//
//}

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
