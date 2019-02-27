//
//  EMPointDetailViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/27.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMPointDetailViewController.h"

@interface EMPointDetailViewController ()
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, strong) NSArray *pointArr;

@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) UIButton *rememberBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIButton *nextBtn;

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
    questionLabel.font = [UIFont systemFontOfSize:14];
    questionLabel.numberOfLines = 0;
    questionLabel.preferredMaxLayoutWidth = kScreenWidth - 40; // 多行时必须设置
    [self.view addSubview:questionLabel];
    questionLabel.sd_layout
    .topSpaceToView(self.view, NAVIGATION_BAR_HEIGHT + 20)
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .autoHeightRatio(0);
    [questionLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.questionLabel = questionLabel;
    NSString *questionText = self.pointArr[self.currentIndex];
    self.questionLabel.text = [NSString stringWithFormat:@"问题：\n\n%@", questionText];

    // 答案
    UILabel *answerLabel = [UILabel new];
    answerLabel.font = [UIFont systemFontOfSize:16];
    answerLabel.numberOfLines = 0;
    questionLabel.preferredMaxLayoutWidth = kScreenWidth - 40; // 多行时必须设置
    [self.view addSubview:answerLabel];
    answerLabel.sd_layout
    .topSpaceToView(questionLabel, 50)
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .autoHeightRatio(0);
    [answerLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.answerLabel = answerLabel;
    answerLabel.hidden = YES;

    // 记得按钮
    UIButton *rememberBtn = [UIButton new];
    [self.view addSubview:rememberBtn];
    [rememberBtn setTitle:@"记得" forState:UIControlStateNormal];
    [rememberBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rememberBtn addTarget:self action:@selector(rememberBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    rememberBtn.sd_layout
    .widthIs(50)
    .heightIs(30)
    .centerXIs(kScreenWidth / 4)
    .bottomSpaceToView(self.view, 80);
    self.rememberBtn = rememberBtn;

    // 忘记按钮
    UIButton *forgetBtn = [UIButton new];
    [self.view addSubview:forgetBtn];
    [forgetBtn setTitle:@"忘记" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.sd_layout
    .widthIs(50)
    .heightIs(30)
    .centerXIs(kScreenWidth / 4 * 3)
    .bottomEqualToView(rememberBtn);
    self.forgetBtn = forgetBtn;
    
    // 下一个按钮
    UIButton *nextBtn = [UIButton new];
    [self.view addSubview:nextBtn];
    [nextBtn setTitle:@"下一个" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.sd_layout
    .widthIs(80)
    .heightIs(30)
    .centerXIs(kScreenWidth / 2)
    .bottomEqualToView(rememberBtn);
    self.nextBtn = nextBtn;
    nextBtn.hidden = YES;
}


#pragma mark - 按钮点击
- (void)rememberBtnClicked {
    // 记得 点击之后显示答案，显示“下一个”按钮，并隐藏记得和忘记按钮
    self.rememberBtn.hidden = YES;
    self.forgetBtn.hidden = YES;
    self.nextBtn.hidden = NO;
    
    self.answerLabel.hidden = NO;
    self.answerLabel.text = [NSString stringWithFormat:@"答案：\n\n这是答案啊 —— %lu", self.currentIndex + 1];
}

- (void)forgetBtnClicked {
    // 忘记 点击之后显示答案，显示“下一个”按钮，并隐藏记得和忘记按钮
    self.rememberBtn.hidden = YES;
    self.forgetBtn.hidden = YES;
    self.nextBtn.hidden = NO;
    
    self.answerLabel.hidden = NO;
    self.answerLabel.text = [NSString stringWithFormat:@"答案：\n\n这是答案啊 —— %lu", self.currentIndex + 1];
}

- (void)nextBtnClicked {
    // 下一个 点击之后切换到下一个问题，隐藏“下一个”按钮，显示“记得”和“忘记”按钮
    self.nextBtn.hidden = YES;
    self.rememberBtn.hidden = NO;
    self.forgetBtn.hidden = NO;
    
    if (self.currentIndex == self.pointArr.count - 1) {
        [SVProgressHUD showErrorWithStatus:@"已经到最后一个问题了"];
    } else {
        NSString *questionText = self.pointArr[++self.currentIndex];
        self.questionLabel.text = [NSString stringWithFormat:@"问题：\n\n%@", questionText];
        self.answerLabel.hidden = YES;
    }
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
