//
//  BasePersonalViewController.m
//  果库
//
//  Created by HZApple on 16/6/2.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "BasePersonalViewController.h"
#import "AFNetworking.h"
#import "PersonalModel.h"
#import "YYModel.h"
#import "ArticlesModel.h"
#import "PersonalProfileViewController.h"
#import "EntityNoteViewController.h"
#import "SetupViewController.h"

#import "CatrgoryGraphicdVievController.h"

@interface BasePersonalViewController ()

@property (nonatomic, strong) NSMutableArray *articlesDataArray;


@end


@implementation BasePersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 100, 100, 100)];
    aiv.activityIndicatorViewStyle = 0;
    aiv.backgroundColor = [UIColor grayColor];
    [aiv startAnimating];
    
    self.view.backgroundColor = backColor;
    //self.tabBarController.tabBar.hidden = YES;
    
    //创建子线程，在子线程中加载数据，提高运行效率
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(globalQueue, ^{
        
        [self _loadData];
    });
    
}



- (void)_loadData {
    
    _PersonalDataArray = [NSMutableArray array];
    _articlesDataArray = [NSMutableArray array];
    
    if (!_isNotSelf) {
        _url = @"http://api.guoku.com/mobile/v4/user/1994265/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&session=bf883e61868a00a3c69914bdb5f75f46&sign=140b16df06a3a626c0a972431c841c99";
    }
    
    
    
    [[AFHTTPSessionManager manager] GET:_url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dic = responseObject;
        NSDictionary *dic1 = dic[@"user"];
        NSArray *array = dic[@"last_user_like"];
        
        PersonalModel *model = [PersonalModel yy_modelWithDictionary:dic1];
        
        model.chief_imageArray = [NSMutableArray array];
        
        for (int i = 0; i < MIN(4, array.count); i ++) {
            NSDictionary *dic2 = array[i];
            NSString *chief_image = dic2[@"chief_image"];
            [model.chief_imageArray addObject:chief_image];
        }
        
        [_PersonalDataArray addObject:model];
        
        
        NSArray *array1 = dic[@"last_post_article"];
        
        for (int i = 0 ; i < array1.count; i ++) {
            NSDictionary *dic1 = array1[i];
            ArticlesModel *model = [ArticlesModel yy_modelWithDictionary:dic1];
            model.content = dic1[@"digest"];
            [_articlesDataArray addObject:model];
        }
        
//        //创建子线程，在子线程中加载数据，提高运行效率
//        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        
//        dispatch_async(globalQueue, ^{
//            
//            [self _loadView];
//        });

        [self _loadView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)_loadView {
    
    PersonalModel *model = _PersonalDataArray[0];
    
    NSURL *url = [NSURL URLWithString:model.avatar_small];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    _coverImageView.image = image;
    _coverImageView.layer.cornerRadius = 30;
    _coverImageView.layer.borderWidth = 1;
    _coverImageView.clipsToBounds = YES;
    

    _nickLabel.text = model.nick;
    _followLabel.text = [NSString stringWithFormat:@"关注%@",model.following_count];
    _fanLabel.text = [NSString stringWithFormat:@"粉丝%@",model.fan_count];
    
    for (int i = 0; i < model.chief_imageArray.count; i ++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (kScreenWidth / 4 - 10)* i, 40, kScreenWidth / 4 - 10, 70)];
        NSURL *url = [NSURL URLWithString:model.chief_imageArray[i]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        imageview.image = image;
        [_likeView addSubview:imageview];
    }
    self.navigationItem.title = model.nick;
    
    [self viewDidLayoutSubviews];
    
    if (_isNotSelf) {
        
        _likeLabel.text = [NSString stringWithFormat:@"TA 的喜爱%@",model.like_count];
        _graphicLabel.text = [NSString stringWithFormat:@"TA 的图文%@",model.dig_count];
        _entityLabel.text = [NSString stringWithFormat:@"TA 的点评%@",model.entity_note_count];
        _tagLabel.text = [NSString stringWithFormat:@"TA 参与过的标签%@",model.tag_count];
        
    }else {
        
        _PersonButton.layer.borderWidth = 1;
        _PersonButton.layer.borderColor = [UIColor blueColor].CGColor;
        _PersonButton.layer.cornerRadius = 5;
        [_PersonButton setTitle:@"编辑个人资料" forState:UIControlStateNormal];
        _likeLabel.text = [NSString stringWithFormat:@"我的喜爱%@",model.like_count];
        _graphicLabel.text = [NSString stringWithFormat:@"我的图文%@",model.dig_count];
        _entityLabel.text = [NSString stringWithFormat:@"我的点评%@",model.entity_note_count];
        _tagLabel.text = [NSString stringWithFormat:@"我参与过的标签%@",model.tag_count];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 30, 30);
        button.layer.cornerRadius = 5;
        button.clipsToBounds = YES;
        
        [button setBackgroundImage:[UIImage imageNamed:@"setup_personal.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        //rightBarButtonItem的设置
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
  
        self.navigationItem.rightBarButtonItem = barButton;
    }
    
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    if (_PersonalDataArray .count > 0) {
        PersonalModel *model = _PersonalDataArray[0];
        if ([model.like_count integerValue] == 0) {
            _likeView.hidden = YES;
            _graphicView.top = _personlaView.bottom +6;
        }
        if ([model.dig_count integerValue] == 0) {
            _graphicView.hidden = YES;
            _entityView.top = _likeView.bottom + 6;
        }
        if ([model.entity_note_count integerValue] == 0) {
            _entityView.hidden = YES;
            _tagView.top = _entityView.bottom + 6;
        }
        if ([model.tag_count integerValue] == 0) {
            _tagView.hidden = YES;
        }
    }
}


//编辑个人资料
- (IBAction)buttonAction:(UIButton *)sender {
    
    if (sender.tag == 2) {
        
        CatrgoryGraphicdVievController *catrgory = [[CatrgoryGraphicdVievController alloc] init];
        catrgory.dataArray = _articlesDataArray;
        [self.navigationController pushViewController:catrgory animated:NO];
        
    }
    if (sender.tag == 5 && !_isNotSelf) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PersonalProfile" bundle:nil];
        PersonalProfileViewController *personal = [storyboard instantiateViewControllerWithIdentifier:@"11"];
        [self.navigationController pushViewController:personal animated:NO];
    }
   
}

- (void)buttonAction {
 
//    EntityNoteViewController *entityNoteCtrl = [[EntityNoteViewController alloc] init];
    
    //隐藏底部标签栏，当push的时候
//    entityNoteCtrl.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:entityNoteCtrl animated:YES];

    //从storyboard加载控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SetupDetail" bundle:nil];
    SetupViewController *setupCtrl = [storyboard instantiateViewControllerWithIdentifier:@"SetupVIewController"];
    
    //隐藏底部标签栏，当push的时候
    setupCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setupCtrl animated:YES];

}

@end
