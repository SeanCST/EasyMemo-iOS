//
//  EMPublishViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/30.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMPublishViewController.h"
#import "UIImage+GetImage.h"
#import "ZYHeadImageClipController.h"

@interface EMPublishViewController () <UINavigationControllerDelegate ,UIImagePickerControllerDelegate>
@property (nonatomic, strong) EMProjectModel *projectModel;

@property (nonatomic, strong) UITextField *projctNameField;
@property (nonatomic, strong) UITextView *briefTextView;
@property (nonatomic, strong) UITextField *schoolField;
@property (nonatomic, strong) UITextField *majorField;

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@end

@implementation EMPublishViewController

- (instancetype)initWithProjectModel:(EMProjectModel *)model {
    self = [super init];
    if (self) {
        self.projectModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    // 名称
    UILabel *projctNameLabel = [UILabel new];
    [self.view addSubview:projctNameLabel];
    projctNameLabel.font = [UIFont systemFontOfSize:16];
    projctNameLabel.textColor = UIColorFromRGB(0x000000);
    projctNameLabel.text = @"名称";
    projctNameLabel.sd_layout
    .leftSpaceToView(self.view, 20)
    .heightIs(50)
    .widthIs(50)
    .topSpaceToView(self.view, NAVIGATION_BAR_HEIGHT + 20);
    
    UITextField *projctNameField = [UITextField new];
    [self.view addSubview:projctNameField];
    projctNameField.placeholder = @"填写笔记名称";
    [self.view addSubview:projctNameField];
    projctNameField.sd_layout
    .topEqualToView(projctNameLabel)
    .leftSpaceToView(projctNameLabel, 10)
    .rightSpaceToView(self.view, 50)
    .heightIs(50);
    self.projctNameField = projctNameField;
    
    UIView *projctNameFieldBtmLine = [[UIView alloc] init];
    projctNameFieldBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:projctNameFieldBtmLine];
    projctNameFieldBtmLine.sd_layout
    .bottomEqualToView(projctNameField)
    .leftEqualToView(projctNameField)
    .rightEqualToView(projctNameField)
    .heightIs(1);
    
    // 简介
    UILabel *briefLabel = [UILabel new];
    [self.view addSubview:briefLabel];
    briefLabel.font = [UIFont systemFontOfSize:16];
    briefLabel.textColor = UIColorFromRGB(0x000000);
    briefLabel.text = @"简介";
    briefLabel.sd_layout
    .leftSpaceToView(self.view, 20)
    .heightIs(20)
    .widthIs(100)
    .topSpaceToView(projctNameLabel, 20);
    
    UITextView *briefTextView = [UITextView new];
    [self.view addSubview:briefTextView];
    briefTextView.font = [UIFont systemFontOfSize:16];
    briefTextView.layer.borderColor = [UIColor grayColor].CGColor;
    briefTextView.layer.borderWidth = 1.0f;
    briefTextView.sd_layout
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .heightIs(120)
    .topSpaceToView(briefLabel, 10);
    self.briefTextView = briefTextView;
    
    // Label - 学校
    UILabel *schoolLabel = [UILabel new];
    [self.view addSubview:schoolLabel];
    [schoolLabel  setTextColor:[UIColor blackColor]];
    [schoolLabel  setFont:[UIFont systemFontOfSize:16.0f]];
    [schoolLabel setText:@"学校"];
    schoolLabel.sd_layout
    .topSpaceToView(briefTextView, 20)
    .leftEqualToView(briefLabel)
    .widthIs(50)
    .heightIs(50);
    
    UITextField *schoolField = [[UITextField alloc] init];
    schoolField.placeholder = @"填写学校";
    [self.view addSubview:schoolField];
    schoolField.sd_layout
    .topEqualToView(schoolLabel)
    .leftSpaceToView(schoolLabel, 10)
    .rightSpaceToView(self.view, 50)
    .heightIs(50);
    self.schoolField = schoolField;
    
    UIView *schoolFieldBtmLine = [[UIView alloc] init];
    schoolFieldBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:schoolFieldBtmLine];
    schoolFieldBtmLine.sd_layout
    .bottomEqualToView(schoolField)
    .leftEqualToView(schoolField)
    .rightEqualToView(schoolField)
    .heightIs(1);
    
    
    // label - 专业
    UILabel *majorLabel = [UILabel new];
    [self.view addSubview:majorLabel];
    [majorLabel  setTextColor:[UIColor blackColor]];
    [majorLabel  setFont:[UIFont systemFontOfSize:16.0f]];
    [majorLabel setText:@"专业"];
    majorLabel.sd_layout
    .topSpaceToView(schoolLabel, 20)
    .leftEqualToView(briefLabel)
    .widthIs(50)
    .heightIs(50);
    
    // 填写手机号
    UITextField *majorField = [[UITextField alloc] init];
    majorField.placeholder = @"填写专业";
    [self.view addSubview:majorField];
    majorField.sd_layout
    .topEqualToView(majorLabel)
    .leftSpaceToView(majorLabel, 10)
    .rightSpaceToView(self.view, 50)
    .heightIs(50);
    self.majorField = majorField;
    
    UIView *majorFieldBtmLine = [[UIView alloc] init];
    majorFieldBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:majorFieldBtmLine];
    majorFieldBtmLine.sd_layout
    .bottomEqualToView(majorField)
    .leftEqualToView(majorField)
    .rightEqualToView(majorField)
    .heightIs(1);
    
    
    // label - 封面
    UILabel *coverLabel = [UILabel new];
    [self.view addSubview:coverLabel];
    [coverLabel  setTextColor:[UIColor blackColor]];
    [coverLabel  setFont:[UIFont systemFontOfSize:16.0f]];
    [coverLabel setText:@"封面"];
    coverLabel.sd_layout
    .topSpaceToView(majorLabel, 20)
    .leftEqualToView(briefLabel)
    .widthIs(50)
    .heightIs(50);
    
    UIImageView *coverImageView = [UIImageView new];
    [coverImageView setImage:[UIImage imageNamed:@"add_pic"]];
    [coverImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:coverImageView];
    coverImageView.sd_layout
    .leftSpaceToView(coverLabel, 20)
    .topEqualToView(coverLabel)
    .widthIs(80)
    .heightIs(100);
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageViewTaped)];
    [coverImageView addGestureRecognizer:recognizer];
    coverImageView.userInteractionEnabled = YES;
    self.coverImageView = coverImageView;
    
    // 提交按钮
    UIButton *pubBtn = [[UIButton alloc] init];
    [pubBtn setTitle:@"提交" forState:UIControlStateNormal];
    [pubBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pubBtn setBackgroundImage:[UIImage imageWithColor:EMBackgroundColor] forState:UIControlStateNormal];
    [pubBtn setBackgroundImage:[UIImage imageWithColor:EMButtonClickedColor] forState:UIControlStateHighlighted];
    [pubBtn addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pubBtn];
    pubBtn.sd_layout
    .topSpaceToView(coverImageView, 30)
    .leftEqualToView(majorField)
    .rightEqualToView(majorField)
    .heightRatioToView(majorField, 1);
}

- (void)submitBtnClicked {
    NSString *url = @"/easyM/editProject";
    NSDictionary *dict = @{
                             @"createUserId" : [EMUserInfo getLocalUser].uID,
                             @"knowProjectName" : self.projctNameField.text,
                             @"brief" : self.briefTextView.text,
                             @"school" : self.schoolField.text,
                             @"major" : self.majorField.text,
                             @"knowProjectID" : self.projectModel.knowProjectID
                             };
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *params = @{
                             @"projectJSON" : jsonString
                             };
    
    [[EMSessionManager shareInstance] postRequestWithURL:url parameters:params success:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        [self showPubAlert];
    } fail:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)showPubAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发布动态" message:@"是否发布刚编辑的笔记？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"是——");
        
        [self publicateProject];
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"否——");
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:yesAction];
    [alertController addAction:noAction];
    [self presentViewController:alertController animated:YES completion:^{
    }];
}

- (void)publicateProject {
    NSString *url = @"/easyM/shareKnowProject";
    NSDictionary *dict = @{
                           @"createUserId" : [EMUserInfo getLocalUser].uID,
                           @"knowProjectID" : self.projectModel.knowProjectID
                           };

    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *params = @{
                             @"projectJSON" : jsonString
                             };

    [[EMSessionManager shareInstance] postRequestWithURL:url parameters:params success:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];

}

# pragma mark - 图片上传
- (void)coverImageViewTaped {
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
    headVC.ZYHeadImageBlock = ^(UIImage * coverimage){
        
        // 上传封面
        NSString *fileName = [NSString stringWithFormat:@"coverImage_%@_%@.png", self.projectModel.knowProjectName,[NSString stringWithFormat:@"%d", arc4random() % 10000]];
        [[EMSessionManager shareInstance] uploadImageWithURL:@"/easyM/upload_cover_image" image:coverimage fileName:fileName uploadToIdName:@"project_id" uploadToId:self.projectModel.knowProjectID success:^(id  _Nullable responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"上传封面成功"];
            [self.coverImageView setImage:coverimage];
        } fail:^(NSError * _Nullable error) {
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
            NSLog(@"%@", error);
        }];
    };
    
    [self.navigationController pushViewController:headVC animated:YES];
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
