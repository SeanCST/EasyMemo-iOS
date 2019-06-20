//
//  EMHomeMemoCollectionViewCell.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/22.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMHomeMemoCollectionViewCell.h"
#import "UIImage+GetImage.h"

@interface EMHomeMemoCollectionViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *coverImgView;

@end

@implementation EMHomeMemoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    UIImageView *coverImgView = [UIImageView new];
    CGFloat width = 80;
    CGFloat height = 100;
    coverImgView.left = 0;
    coverImgView.top = 0;
    coverImgView.width = width;
    coverImgView.height = height;
    [self.contentView addSubview:coverImgView];
    self.coverImgView = coverImgView;
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.numberOfLines = 0;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:nameLabel];
    nameLabel.left = 0;
    nameLabel.top = 100;
    nameLabel.width = width;
    nameLabel.height = 30;
    self.nameLabel = nameLabel;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//}

- (void)setProjectModel:(EMProjectModel *)model {
    self.nameLabel.text = model.knowProjectName;
    NSString *imgStr = [NSString stringWithFormat:@"%@%@", kBaseURL, model.coverImg];
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageWithColor:EMBackgroundColor]];
}


/**
 重用前清空 cell 内数据的方法
 */
- (void)prepareForReuse {
    [super prepareForReuse];
    
}

@end
