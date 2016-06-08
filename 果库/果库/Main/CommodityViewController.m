//
//  CommodityViewController.m
//  果库
//
//  Created by HZApple on 16/5/28.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CommodityViewController.h"
#import "UILabel+LabelHeight.h"
#import "AFNetworking.h"
#import "UIButton+WebCache.h"
#import "CommentModel.h"
#import "CommentView.h"
#import "GuessModel.h"
#import "GuessCollectionViewCell.h"
#import "CommondityModel.h"
#import "CatrgoryViewController.h"
#import "LikeTableViewController.h"


@interface CommodityViewController ()<UIScrollViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource> {
    
    UIScrollView *mainScrollView;
    
    UIPageControl *pageControl;
    
    NSMutableArray *likePeopleDataArray;
    
    NSMutableArray *commentDataArray;
    
    NSMutableArray *guessDataArray;
    
    NSMutableArray *commondityDataArray;
    
    CGFloat y;
    
    UIButton *buyButton;
    
    UIView *backview;
    
    
    
}

@end

@implementation CommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"商品";
    
 
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49)];
    [self.view addSubview:mainScrollView];
    mainScrollView.delegate = self;
    mainScrollView.tag = 11;
    mainScrollView.contentSize = CGSizeMake(0, 1000);
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, kScreenHeight - 30, 60, 60)];
    indicator.activityIndicatorViewStyle = 2;
    [indicator stopAnimating];
    [self.view addSubview:indicator];
    [self _loadView];
    [self _loadData];
    
    
    


}

- (void)_loadData {
    
    likePeopleDataArray = [NSMutableArray array];
    commentDataArray = [NSMutableArray array];
    guessDataArray = [NSMutableArray array];
    commondityDataArray = [NSMutableArray array];
    
    NSString *string = @"http://api.guoku.com/mobile/v4/entity/4632761/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=b9f9119e711fa50715694cd863c0bcbe";
    
    
    [[AFHTTPSessionManager manager] GET:string parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

            NSDictionary *dic =  responseObject;


            NSArray *like_user = dic[@"like_user_list"];
            NSArray *note = dic[@"note_list"];
            NSDictionary *entity = dic[@"entity"];

            for (int i = 0 ; i < like_user.count; i ++) {
                NSDictionary *dic1 = like_user[i];

                NSString *string = dic1[@"avatar_small"];
                [likePeopleDataArray addObject:string];

            }

            for (int i = 0; i < note.count; i ++) {
                NSDictionary  *dic2 = note[i];
                CommentModel *model = [[CommentModel alloc] init];

                model.content = dic2[@"content"];

                NSString *string = dic2[@"post_time"];
                NSUInteger length = string.length;
                NSRange range = NSMakeRange(10, length - 10);
                string = [string stringByReplacingCharactersInRange:range withString:@""];
                model.postTime = string;
                model.poke_count = dic2[@"poke_count"];
                model.comment_count = dic2[@"comment_count"];

                NSDictionary *dic3 = dic2[@"creator"];
                model.avatar_small = dic3[@"avatar_small"];
                model.nick = dic3[@"nick"];
                model.cellHeight = [model countCellHeight];
                [commentDataArray addObject:model];
            }
        
            CommondityModel *model = [[CommondityModel alloc] init];
        model.chief_image = entity[@"chief_image"];
        model.brand = entity[@"brand"];
        model.commodityTitle = entity[@"title"];
        model.detail_images = entity[@"detail_images"];
        model.like_count = entity[@"like_count"];
        model.price = entity[@"price"];
        [commondityDataArray addObject:model];
        
        if (_chief_image == nil) {
            [self _loadNewView];

        }
        
                [self _loadView1];
                [self _loadView2];
        
                NSString *string1 = @"http://api.guoku.com/mobile/v4/entity/guess/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&cid=23&count=9&eid=4632761&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=469aded20016f60525c5a8929752fa67";
            
            
                [[AFHTTPSessionManager manager] GET:string1 parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
                    NSArray *array = responseObject;
                    for (NSDictionary *dic4 in array) {
                        GuessModel *model = [[GuessModel alloc] init];
            
                        model.chief_image = dic4[@"chief_image"];
                        model.detail_images = dic4[@"detail_images"];
                        model.like_count = dic4[@"like_count"];
                        model.commodityTitle = dic4[@"title"];
                        model.price = dic4[@"price"];
            
                        [guessDataArray addObject:model];
            
                    }

                    [self _loadView3];
                    [self _loadView4];
                    mainScrollView.contentSize = CGSizeMake(0, y);
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];

    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];


    
}

- (void)_loadView {
    
    y = 0;
    backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 500)];
    backview.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:backview];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, (kScreenWidth - 20) * 0.8)];
    scrollView.contentSize = CGSizeMake((kScreenWidth - 20) * (_detail_images.count + 1), 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    scrollView.tag = 22;
    
    y += 10 + scrollView.height;
    
    for (NSInteger i = 0; i < _detail_images.count + 1; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + i * (kScreenWidth -  20), 0, (kScreenWidth - 20) , (kScreenWidth - 20) * 0.8)];
        if (i == 0 ) {
            
            NSURL *url = [NSURL URLWithString:_chief_image];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            imageView.contentMode = 1;
            imageView.image = image;
            
            
            //[imageView sd_setImageWithURL:[NSURL URLWithString:_chief_image]];
        } else {
            //[imageView sd_setImageWithURL:[NSURL URLWithString:_detail_images[i - 1]]];
            NSURL *url = [NSURL URLWithString:_detail_images[i - 1]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            imageView.contentMode = 1;
            imageView.image = image;
            
        }
        [scrollView addSubview:imageView];
    }
    [backview addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollView.bottom - 20, kScreenWidth, 5)];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = _detail_images.count + 1;
    [backview insertSubview:pageControl aboveSubview:scrollView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, scrollView.bottom + 10, kScreenWidth, 20)];
    titleLabel.font = k14Font;
    titleLabel.textAlignment = 1;
    CGFloat height = [titleLabel getTextHeightWithFontSize:14 width:kScreenWidth text:_commodityTitle];
    titleLabel.height = height;
    titleLabel.text = _commodityTitle;
    [backview addSubview:titleLabel];
    
    y += 10 + 20;
    
    //likebutton
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(kScreenWidth / 4, titleLabel.bottom + 10, 30, 30);
    likeButton.tag = 30;
    [likeButton setImage:[UIImage imageNamed:@"myfavor_hot"] forState:UIControlStateNormal];
    [backview addSubview:likeButton];
    //commentbutton
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton setImage:[UIImage imageNamed:@"comment_hot"] forState:UIControlStateNormal];
    commentButton.frame = CGRectMake(kScreenWidth / 4 * 2, titleLabel.bottom + 10, 30, 30);
    [backview addSubview:commentButton];
    //sharebutton
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(kScreenWidth / 4 * 3, titleLabel.bottom + 10, 30, 30);
    [shareButton setImage:[UIImage imageNamed:@"more_hot"] forState:UIControlStateNormal];
    [backview addSubview:shareButton];
    
    y += 10 + 30;
    
    buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buyButton.frame = CGRectMake(10, likeButton.bottom + 10, kScreenWidth - 20, 30);
    [buyButton setBackgroundImage:[UIImage imageNamed:@"common_button_big_blue"] forState:UIControlStateNormal];
    [buyButton setTitle:[NSString stringWithFormat:@"￥%@去购买",_price] forState:UIControlStateNormal];
    buyButton.layer.cornerRadius = 8;
    buyButton.layer.masksToBounds = YES;
    [backview insertSubview:buyButton atIndex:0];
    
    y += 10 + 30;
    
    backview.height = y;
    
}

- (void)_loadNewView {
    
    y = 0;
    CommondityModel *model = commondityDataArray[0];
    backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 500)];
    backview.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:backview];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, (kScreenWidth - 20) * 0.8)];
    scrollView.contentSize = CGSizeMake((kScreenWidth - 20) * (model.detail_images.count + 1), 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    scrollView.tag = 22;
    
    y += 10 + scrollView.height;
    
    for (NSInteger i = 0; i < model.detail_images.count + 1; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + i * (kScreenWidth -  20), 0, (kScreenWidth - 20) , (kScreenWidth - 20) * 0.8)];
        if (i == 0 ) {
            
            NSURL *url = [NSURL URLWithString:model.chief_image];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            imageView.contentMode = 1;
            imageView.image = image;
            
            
            //[imageView sd_setImageWithURL:[NSURL URLWithString:_chief_image]];
        } else {
            //[imageView sd_setImageWithURL:[NSURL URLWithString:_detail_images[i - 1]]];
            NSURL *url = [NSURL URLWithString:model.detail_images[i - 1]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            imageView.contentMode = 1;
            imageView.image = image;
            
        }
        [scrollView addSubview:imageView];
    }
    [backview addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollView.bottom - 20, kScreenWidth, 5)];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = model.detail_images.count + 1;
    [backview insertSubview:pageControl aboveSubview:scrollView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, scrollView.bottom + 10, kScreenWidth, 20)];
    titleLabel.font = k14Font;
    titleLabel.textAlignment = 1;
    NSString *string = model.brand;
    if (string.length > 0) {
        string = [string stringByAppendingPathComponent:@" - "];
    }
    string = [string stringByAppendingPathComponent:model.commodityTitle];
    CGFloat height = [titleLabel getTextHeightWithFontSize:14 width:kScreenWidth text:string];
    titleLabel.height = height;
    titleLabel.text = string;
    [backview addSubview:titleLabel];
    
    y += 10 + 20;
    
    //likebutton
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(kScreenWidth / 4, titleLabel.bottom + 10, 30, 30);
    [likeButton setImage:[UIImage imageNamed:@"myfavor_hot"] forState:UIControlStateNormal];
    likeButton.tag = 30;
    [backview addSubview:likeButton];
    //commentbutton
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(kScreenWidth / 4 * 2, titleLabel.bottom + 10, 30, 30);
    [commentButton setImage:[UIImage imageNamed:@"comment_hot"] forState:UIControlStateNormal];
    [backview addSubview:commentButton];
    //sharebutton
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(kScreenWidth / 4 * 3, titleLabel.bottom + 10, 30, 30);
    [shareButton setImage:[UIImage imageNamed:@"more_hot"] forState:UIControlStateNormal];
    [backview addSubview:shareButton];
    
    y += 10 + 30;
    
    buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buyButton.frame = CGRectMake(10, likeButton.bottom + 10, kScreenWidth - 20, 30);
    [buyButton setBackgroundImage:[UIImage imageNamed:@"common_button_big_blue"] forState:UIControlStateNormal];
    [buyButton setTitle:[NSString stringWithFormat:@"￥%@去购买",model.price] forState:UIControlStateNormal];
    buyButton.layer.cornerRadius = 8;
    buyButton.layer.masksToBounds = YES;
    [backview insertSubview:buyButton atIndex:0];
    
    y += 10 + 30;
    
    backview.height = y;
}

- (void)_loadView1 {
    if (![_like_count isEqualToString:@"0"]) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, buyButton.bottom + 10, kScreenWidth, 45 + kScreenWidth / 10)];
        view.backgroundColor = [UIColor whiteColor];
        [mainScrollView addSubview:view];
        
        
        UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,  10, 100, 20)];
        likeLabel.text = [NSString stringWithFormat:@"%@人喜欢",_like_count];
        [view addSubview:likeLabel];
        
        UIButton *likePeopleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        likePeopleButton.frame = CGRectMake(kScreenWidth - 50,  10, 30, 20);
        likePeopleButton.tag = 55;
        [likePeopleButton addTarget:self action:@selector(buttonAction1) forControlEvents:UIControlEventTouchUpInside];
        [likePeopleButton setBackgroundColor:[UIColor yellowColor]];
        [view addSubview:likePeopleButton];
        
        for (NSInteger i = 0; i < MIN(8, likePeopleDataArray.count); i++ ) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10 + (kScreenWidth / 10 + 5) * i,  35, kScreenWidth / 10, kScreenWidth  / 10);
            button.layer.cornerRadius = kScreenWidth / 20;
            button.layer.masksToBounds = YES;
            
            //            NSURL *url = [NSURL URLWithString:likePeopleDataArray[i]];
            //            NSData *data = [NSData dataWithContentsOfURL:url];
            //            UIImage *image = [UIImage imageWithData:data];
            //
            //            [button setBackgroundImage:image forState:UIControlStateNormal];
            
            [button sd_setImageWithURL:[NSURL URLWithString:likePeopleDataArray[i]] forState:UIControlStateNormal];
            
            [view addSubview:button];
        }
        
        y += 10 + 20 + 5 + kScreenWidth / 10 + 20;
        
    }
    
    
    
}

- (void)_loadView2 {
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, y + 3, kScreenWidth, 20)];
    view1.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
    label.text = [NSString stringWithFormat:@"%li人点评",commentDataArray.count];
    [view1 addSubview:label];
    
    y += 20;
    
    
    for (int i = 0; i < commentDataArray.count; i ++) {
        CommentView *view = [[CommentView alloc] initWithFrame:CGRectMake(0, y , kScreenWidth, 100)];
        view.backgroundColor = [UIColor whiteColor];
        view.model = commentDataArray[i];
        view.height = view.model.cellHeight;
        y += view.height + 3;
        [mainScrollView addSubview:view];
        
    }
    
}

- (void)_loadView3 {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, 40)];
    [mainScrollView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    label.text = @"来自‘香氛’";
    [view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 50, 10, 20, 20);
    [button setBackgroundColor:[UIColor cyanColor]];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    y += 40;
    
}

- (void)_loadView4 {
    
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kScreenWidth) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[GuessCollectionViewCell class] forCellWithReuseIdentifier:@"GuessCollectionViewCell"];
    [mainScrollView addSubview:collectionView];
    
    y += kScreenWidth;
    
}
#pragma mark collectionviewDatasourse

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return guessDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        GuessCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuessCollectionViewCell" forIndexPath:indexPath];
        cell.model = guessDataArray[indexPath.row];
    
        return cell;

}


//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
////    GuessCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuessCollectionViewCell" forIndexPath:indexPath];
////    cell.model = guessDataArray[indexPath.row];
////    
////    return cell;
//}

#pragma mark collectionViewFLowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth - 30) / 3, (kScreenWidth - 30) / 3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


#pragma mark scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 22) {
        int i = scrollView.contentOffset.x / (kScreenWidth - 20);
        pageControl.currentPage = i;
    }
    
    if (scrollView.tag == 11) {
        
        CGFloat heightY = scrollView.contentOffset.y;
        
        if (heightY > 335 + 64) {
            buyButton.frame = CGRectMake(10, 0, kScreenWidth - 20, 30);
            [self.view addSubview:buyButton];
            
            UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            likeButton.frame = CGRectMake(0, 0, 30, 30);
           [likeButton setImage:[UIImage imageNamed:@"myfavor_hot"] forState:UIControlStateNormal];
            UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithCustomView:likeButton];
            
            //commentbutton
            UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
            commentButton.frame = CGRectMake(0, 0, 30, 30);
            [commentButton setImage:[UIImage imageNamed:@"comment_hot"] forState:UIControlStateNormal];
            UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithCustomView:commentButton];
            //sharebutton
            UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
            shareButton.frame = CGRectMake(0, 0, 30, 30);
           [shareButton setImage:[UIImage imageNamed:@"more_hot"] forState:UIControlStateNormal];
            UIBarButtonItem *button3 = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
            
            NSArray *array = @[button3, button2, button1];
            
            self.navigationItem.rightBarButtonItems = array;
            
            
        }else {
            
            buyButton.frame = CGRectMake(10, 335 + 64, kScreenWidth - 20, 30);
            [backview addSubview:buyButton];
            
            self.navigationItem.rightBarButtonItems = nil;
            
        }
        
    }
    
}

- (void)buttonAction {
    
    self.hidesBottomBarWhenPushed = YES;
    CatrgoryViewController *catrgory = [[CatrgoryViewController alloc] init];
    catrgory.catrgorytitle = @"香氛";
    catrgory.urlstring1 = @"http://api.guoku.com/mobile/v4/category/sub/23/articles/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=ba08553c317bd7df6d1a79ee7928de7d";
    catrgory.urlstring2 = @"http://api.guoku.com/mobile/v4/category/23/entity/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&count=30&offset=0&reverse=0&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=169bb1d3ec96b17b7e932b74665eefdc&sort=time";
    [self.navigationController pushViewController:catrgory animated:NO];
    
}

- (void)buttonAction1 {
    
    LikeTableViewController *like = [[LikeTableViewController alloc] init];
    like.like_count = _like_count;
    like.tag = 1;
    [self.navigationController pushViewController:like animated:NO];
}

@end
