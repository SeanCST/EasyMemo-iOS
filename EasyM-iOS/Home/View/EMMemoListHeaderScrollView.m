//
//  EMMemoListHeaderScrollView.m
//  HEYMEN
//
//  Created by SeanCST on 2019/2/20.
//  Copyright © 2019 HEYMEN. All rights reserved.
//

#import "EMMemoListHeaderScrollView.h"

@interface EMMemoListHeaderScrollView()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *titleBtnArr;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *selectedUnderline;

@end

@implementation EMMemoListHeaderScrollView

- (instancetype)initWithTitles:(NSArray *)titles size:(CGSize)size {
    self = [super init];
    if (self) {
        self.titles = titles;
        self.size = size;
        [self setupUI];
        self.showsHorizontalScrollIndicator = false;
        self.contentSize = CGSizeMake(size.width, size.height);
    }
    return self;
}

- (void)setupUI {
    // 添加标题按钮
    CGSize btnSize = CGSizeMake(self.width / 3, 30);
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *btn = [UIButton new];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [btn setTitleColor:EMBackgroundColor forState:UIControlStateSelected];
        btn.sd_layout
        .widthIs(btnSize.width)
        .heightIs(btnSize.height);
        btn.bottom = self.height - 7;
        btn.left = i * btnSize.width;
        
        if (i == 0) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
//        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.titleBtnArr addObject:btn];
    }
    
    // 添加选中按钮下面的黄线
    UIView *selectedUnderline = [UIView new];
    selectedUnderline.backgroundColor = EMBackgroundColor;
    selectedUnderline.width = 60;
    selectedUnderline.height = 4;
    selectedUnderline.bottom = self.height;
    selectedUnderline.sd_cornerRadius = @(2.0);
    selectedUnderline.clipsToBounds = YES;
    self.selectedUnderline = selectedUnderline;
    [self addSubview:selectedUnderline];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    CGSize btnSize = CGSizeMake(self.width / 3, 30);
//    CGSize selectedBtnSize = CGSizeMake(48, 33);
    UIButton *lastbtn;
    for (int i = 0; i < self.titleBtnArr.count; i++) {
        UIButton *btn = self.titleBtnArr[i];
        if (btn.selected) {
            [btn.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
            lastbtn = btn;
            self.selectedUnderline.centerX = btn.centerX;
        } else {
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
            lastbtn = btn;
        }
        
    }
}

- (void)btnClicked:(UIButton *)btn {
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [self setNeedsLayout];
}

- (NSMutableArray *)titleBtnArr {
    if (!_titleBtnArr) {
        _titleBtnArr = [NSMutableArray array];
    }
    return _titleBtnArr;
}

@end
