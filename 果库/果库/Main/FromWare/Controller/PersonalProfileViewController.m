//
//  FromWareViewController.m
//  果库
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "PersonalProfileViewController.h"
#import "PersonalProfileTableViewCell.h"
#import "DataService.h"
#import "UIImageView+WebCache.h"
#import "NickNameViewController.h"
#import "MBProgressHUD.h"
#import "AddressChoicePickerView.h"

@interface PersonalProfileViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    MBProgressHUD *HUD;
    
    AddressChoicePickerView *addressPickerView;
}
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;

@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic, strong) UITableView *profileTableView;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation PersonalProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"编辑个人资料";
    NSString *urlString = @"http://static.guoku.com/static/v4/2d1125c82b518a59f3b75222f07ec069a9f20112/images/avatar/man.png";
    [_userImgView sd_setImageWithURL:[NSURL URLWithString:urlString]];


}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getString:) name:@"textField" object:nil];
}

- (void)getString:(NSNotification *)notification {
    NSString *string = notification.object;
    _textLabel.text = string;
}

//移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"textField" object:nil];
}


- (IBAction)tapPress:(UITapGestureRecognizer *)sender {
    addressPickerView = [[AddressChoicePickerView alloc] init];
    addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate) {
        self.addressLabel.text = [NSString stringWithFormat:@"%@",locate];
        self.addressLabel.textColor = [UIColor blackColor];
        
    };
    [addressPickerView show];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [addressPickerView removeFromSuperview];;
}

//#pragma mark -UITableViewDataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 5;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    PersonalProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"11" forIndexPath:indexPath];
//    return cell;
//    
//}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"照片库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = sourceType;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:NULL];
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alertCtrl dismissViewControllerAnimated:YES completion:NULL];
        }];
        [alertCtrl addAction:cameraAction];
        [alertCtrl addAction:photoLibraryAction];
        [alertCtrl addAction:cancelAction];
        [self presentViewController:alertCtrl animated:YES completion:NULL];
    }
    
    if (indexPath.row == 2 && indexPath.section == 0) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *maleAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertAction];
            _sexLabel.text = @"男";
        }];
        UIAlertAction *femaleAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertAction];
            _sexLabel.text = @"女";


        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"其它" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertAction];
            _sexLabel.text = @"其它";


        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alertCtrl dismissViewControllerAnimated:YES completion:NULL];
        }];
        [alertCtrl addAction:maleAction];
        [alertCtrl addAction:femaleAction];
        [alertCtrl addAction:otherAction];
        [alertCtrl addAction:cancelAction];

        [self presentViewController:alertCtrl animated:YES completion:NULL];
    }

    
    if (indexPath.row == 3) {
        
    }
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *selectImg = info[UIImagePickerControllerOriginalImage];
    _userImgView.image = selectImg;
}


- (void)alertAction{
//    [self.navigationController popViewControllerAnimated:YES];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    //    HUD.delegate = self;
    HUD.labelText = @"保存成功";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
}

#pragma mark -buttonAction 
- (void)buttonAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}





@end
