//
//  EMHomeMemoCollectionViewCell.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/22.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMHomeMemoCollectionViewCell.h"

@interface EMHomeMemoCollectionViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation EMHomeMemoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.backgroundColor = kRandomColor;
    }
    return self;
}


- (void)setupUI {
    UILabel *nameLabel = [UILabel new];
    nameLabel.numberOfLines = 0;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:nameLabel];
    CGFloat width = 80;
    CGFloat height = 100;
    nameLabel.left = 0;
    nameLabel.top = 0;
    nameLabel.width = width;
    nameLabel.height = height;

    self.nameLabel = nameLabel;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//}

- (void)setMemoName:(NSString *)memoName {
    _memoName = memoName;
    self.nameLabel.text = memoName;
}

/**
 重用前清空 cell 内数据的方法
 */
- (void)prepareForReuse {
    [super prepareForReuse];
    
}

@end
