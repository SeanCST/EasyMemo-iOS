//
//  EMDiscoveryCollectionViewCell.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/23.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMDiscoveryCollectionViewCell.h"

@interface EMDiscoveryCollectionViewCell ()

@property (nonatomic, strong) UILabel *categoryLabel;

@end

@implementation EMDiscoveryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    self.backgroundColor = UIColorFromRGB(0xFBFFB9);

    UILabel *categoryLabel = [UILabel new];
    categoryLabel.numberOfLines = 0;
    categoryLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:categoryLabel];
    CGFloat width = 80;
    CGFloat height = 50;
    categoryLabel.left = 0;
    categoryLabel.top = 0;
    categoryLabel.width = width;
    categoryLabel.height = height;
    self.categoryLabel = categoryLabel;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//}

- (void)setCategoryName:(NSString *)categoryName {
    _categoryName = categoryName;
    self.categoryLabel.text = categoryName;
}

/**
 重用前清空 cell 内数据的方法
 */
- (void)prepareForReuse {
    [super prepareForReuse];
    
}
@end
