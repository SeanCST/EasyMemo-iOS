//
//  EMPointDetailViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/27.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMPointDetailViewController.h"
#import "EMProjectModel.h"

@interface EMPointDetailViewController ()
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, strong) NSArray *pointArr;

@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) UIButton *rememberBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIButton *showAnswerBtn;

@end

@implementation EMPointDetailViewController

- (instancetype)initWithPointArr:(NSArray *)pointArr currentIndex:(NSUInteger)currentIndex{
    self = [super init];
    if(self) {
        self.currentIndex = currentIndex;
        self.pointArr = pointArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自评模式";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    // 问题
    UILabel *questionLabel = [UILabel new];
    questionLabel.font = [UIFont systemFontOfSize:20];
    questionLabel.numberOfLines = 0;
    questionLabel.preferredMaxLayoutWidth = kScreenWidth - 40; // 多行时必须设置
    [self.view addSubview:questionLabel];
    questionLabel.sd_layout
    .topSpaceToView(self.view, NAVIGATION_BAR_HEIGHT + 20)
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .heightIs(40);
//    .autoHeightRatio(0);
    [questionLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.questionLabel = questionLabel;
    EMKnowPointModel *model = self.pointArr[self.currentIndex];
//    self.questionLabel.text = [NSString stringWithFormat:@"问题：\n\n%@", model.question];
    self.questionLabel.backgroundColor = EMBackgroundColor;
    self.questionLabel.text = model.question;
    self.questionLabel.layer.cornerRadius = 5.0f;
    self.questionLabel.clipsToBounds = YES;

    // 答案
    UILabel *answerLabel = [UILabel new];
    answerLabel.font = [UIFont systemFontOfSize:20];
    answerLabel.numberOfLines = 0;
    questionLabel.preferredMaxLayoutWidth = kScreenWidth - 40; // 多行时必须设置
    [self.view addSubview:answerLabel];
    answerLabel.sd_layout
    .topSpaceToView(questionLabel, 10)
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .heightIs(40);
//    .autoHeightRatio(0);
    [answerLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.answerLabel = answerLabel;
//    self.answerLabel.text = [NSString stringWithFormat:@"答案：\n\n%@", model.answer];
    self.answerLabel.backgroundColor = EMBackgroundColor;
    self.answerLabel.text = model.answer;
    self.answerLabel.layer.cornerRadius = 5.0f;
    self.answerLabel.clipsToBounds = YES;
    
    // 记得按钮
    UIButton *rememberBtn = [UIButton new];
    [self.view addSubview:rememberBtn];
    [rememberBtn setTitle:@"记得" forState:UIControlStateNormal];
    [rememberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rememberBtn addTarget:self action:@selector(rememberBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [rememberBtn setBackgroundColor:EMBackgroundColor];
    rememberBtn.layer.cornerRadius = 5.0f;
    rememberBtn.clipsToBounds = YES;
    rememberBtn.sd_layout
    .widthIs(100)
    .heightIs(44)
    .centerXIs(kScreenWidth / 4)
    .bottomSpaceToView(self.view, 80);
    self.rememberBtn = rememberBtn;

    // 忘记按钮
    UIButton *forgetBtn = [UIButton new];
    [self.view addSubview:forgetBtn];
    [forgetBtn setTitle:@"忘记" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [forgetBtn setBackgroundColor:EMRGBColor(237, 80, 79)];
    forgetBtn.layer.cornerRadius = 5.0f;
    forgetBtn.clipsToBounds = YES;
    forgetBtn.sd_layout
    .widthIs(100)
    .heightIs(44)
    .centerXIs(kScreenWidth / 4 * 3)
    .bottomEqualToView(rememberBtn);
    self.forgetBtn = forgetBtn;
    
    // 显示答案按钮
    UIButton *showAnswerBtn = [UIButton new];
    [self.view addSubview:showAnswerBtn];
    [showAnswerBtn setTitle:@"点击屏幕显示答案" forState:UIControlStateNormal];
    [showAnswerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [showAnswerBtn addTarget:self action:@selector(showAnswerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [showAnswerBtn setBackgroundColor:[UIColor whiteColor]];
    showAnswerBtn.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(questionLabel, 0)
    .bottomEqualToView(self.view);
    self.showAnswerBtn = showAnswerBtn;
}


#pragma mark - 按钮点击
- (void)rememberBtnClicked {


    if (self.currentIndex == self.pointArr.count - 1) {
        [SVProgressHUD showSuccessWithStatus:@"已复习完本笔记！"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    } else {
        EMKnowPointModel *model = self.pointArr[++self.currentIndex];
//        self.questionLabel.text = [NSString stringWithFormat:@"问题：\n\n%@", model.question];
//        self.answerLabel.text = [NSString stringWithFormat:@"答案：\n\n%@", model.answer];
        self.questionLabel.text = model.question;
        self.answerLabel.text = model.answer;
    }
    self.showAnswerBtn.hidden = NO;
}

- (void)forgetBtnClicked {
    
    if (self.currentIndex == self.pointArr.count - 1) {
        [SVProgressHUD showSuccessWithStatus:@"已复习完本笔记！"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    } else {
        EMKnowPointModel *model = self.pointArr[++self.currentIndex];
//        self.questionLabel.text = [NSString stringWithFormat:@"问题：\n\n%@", model.question];
//        self.answerLabel.text = [NSString stringWithFormat:@"答案：\n\n%@", model.answer];
        self.questionLabel.text = model.question;
        self.answerLabel.text = model.answer;
    }
    
    self.showAnswerBtn.hidden = NO;
}

- (void)showAnswerBtnClicked {
    self.showAnswerBtn.hidden = YES;
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
