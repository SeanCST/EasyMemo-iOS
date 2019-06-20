//
//  EMHeaderUploadViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/28.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMHeaderUploadViewController.h"
#import "ZYHeadImageClipController.h"

@interface EMHeaderUploadViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic ,strong) UIImageView *picImageView;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@end

@implementation EMHeaderUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0x000000);
    [self createUI];
    self.title = @"个人头像";

}

- (void)createUI{
    UIImageView *headView = [UIImageView new];
    self.picImageView = headView;
    [self.view addSubview:headView];
    [headView setBackgroundColor:[UIColor whiteColor]];
    headView.sd_layout
    .widthIs(kScreenWidth)
    .heightEqualToWidth()
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view);
    
    EMUserModel *model = [EMUserInfo getLocalUser];
    NSString *completeUrlStr = [NSString stringWithFormat:@"%@%@", kBaseURL, model.img];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:completeUrlStr] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];

    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
//    [rightBtn setImage:[UIImage imageNamed:@"nav_btm_more-1"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"更换头像" forState:UIControlStateNormal];
    [rightBtn setTitleColor:EMBackgroundColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chosePhoto:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)chosePhoto:(UIButton *)button{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getImageFromIpc:1];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getImageFromIpc:0];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getImageFromIpc:(NSInteger)index
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    self.imagePicker = ipc;
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = index;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:ipc animated:YES completion:nil];
    });
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController.navigationItem.leftBarButtonItem == nil && [navigationController.viewControllers count] > 1) {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [backButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
//        backButton.titleLabel.font = FD_FONT_BARITEMFONTSIZE;
//        [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
//        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        
        [backButton addTarget:self action:@selector(imageLeftBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
}

- (void)imageLeftBarItemClick:(id)sender{
    [_imagePicker popViewControllerAnimated:YES];
}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *pickedImage = info[UIImagePickerControllerOriginalImage]; // 拿到图片
    
    ZYHeadImageClipController *headVC = [[ZYHeadImageClipController alloc] init];
    headVC.oldImage = pickedImage;
    headVC.ZYHeadImageBlock = ^(UIImage * headimage){
        
        EMUserModel *userModel = [EMUserInfo getLocalUser];
        NSString *fileName = [NSString stringWithFormat:@"headImage_%@_%@.png", userModel.username, [NSString stringWithFormat:@"%d", arc4random() % 10000]];
        
        // 上传头像
        [[EMSessionManager shareInstance] uploadImageWithURL:@"/easyM/upload_head_image" image:headimage fileName:fileName uploadToIdName:@"user_id" uploadToId:userModel.uID success:^(id  _Nullable responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"上传头像成功"];
            
            // 取出头像地址并存储
            NSDictionary *resultDict = responseObject[@"result"];
            NSString *imageUrl = resultDict[@"image"];
            EMUserModel *model = [EMUserInfo getLocalUser];
            model.img = imageUrl;
            [EMUserInfo saveLocalUser:model];
            
            NSString *completeUrlStr = [NSString stringWithFormat:@"%@%@", kBaseURL, [EMUserInfo getLocalUser].img];
            [self.picImageView sd_setImageWithURL:[NSURL URLWithString:completeUrlStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        } fail:^(NSError * _Nullable error) {
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
            NSLog(@"%@", error);
        }];
    };

    [self.navigationController pushViewController:headVC animated:YES];
    
//    // 上传头像
//    [[EMSessionManager shareInstance] uploadImageWithURL:@"/easyM/upload_head_image" image:pickedImage success:^(id  _Nullable responseObject) {
//        [SVProgressHUD showSuccessWithStatus:@"上传头像成功"];
//
//        // 取出头像地址并存储
//        NSDictionary *resultDict = responseObject[@"result"];
//        NSString *imageUrl = resultDict[@"image"];
//        EMUserModel *model = [EMUserInfo getLocalUser];
//        model.img = imageUrl;
//        [EMUserInfo saveLocalUser:model];
//
//        NSString *completeUrlStr = [NSString stringWithFormat:@"%@%@", kBaseURL, imageUrl];
//        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:completeUrlStr] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
//    } fail:^(NSError * _Nullable error) {
//
//    }];
    
    
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
