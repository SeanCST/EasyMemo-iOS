//
//  EMDiscoveySearchTableViewCell.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/29.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMDiscoverySearchTableViewCell.h"

@interface EMDiscoverySearchTableViewCell ()
@property (nonatomic, strong) UIImageView *memoIconView;
@property (nonatomic, strong) UILabel *memoNameLabel;
@property (nonatomic, strong) UILabel *memoDescLabel;

@end

@implementation EMDiscoverySearchTableViewCell

// 调用 UITableView 的 dequeueReusableCellWithIdentifier 方法时会通过这个方法初始化 Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}



- (void)initView {
    // memoIconView
    _memoIconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_memoIconView];
    _memoIconView.backgroundColor = EMBackgroundColor;
    _memoIconView.sd_layout
    .widthIs(100)
    .heightIs(130)
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10);
    
    // memoNameLabel
    _memoNameLabel = [UILabel new];
    _memoNameLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_memoNameLabel];
    _memoNameLabel.sd_layout
    .heightIs(20)
    .widthIs(kScreenWidth - 180)
    .topEqualToView(_memoIconView)
    .leftSpaceToView(_memoIconView, 20);
    [_memoNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_memoNameLabel setText:@"《软件体系结构》"];
    
    // memoDescLabel
    _memoDescLabel = [UILabel new];
    _memoDescLabel.font = [UIFont systemFontOfSize:14];
    _memoDescLabel.numberOfLines = 0;
    _memoDescLabel.preferredMaxLayoutWidth = kScreenWidth - 140;
    [self.contentView addSubview:_memoDescLabel];
    _memoDescLabel.sd_layout
    .topSpaceToView(_memoNameLabel, 10)
    .leftEqualToView(_memoNameLabel)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_memoDescLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_memoDescLabel setText:@"笔记描述笔记描述笔记描述笔记描述笔记描述笔记描述笔记描述笔记描述笔记描述笔记描述笔记描述"];
    
    [self setupAutoHeightWithBottomView:_memoIconView bottomMargin:5];
}

- (void)setupData:(EMProjectModel *)dataModel {
    _memoNameLabel.text = dataModel.knowProjectName;
    _memoDescLabel.text = dataModel.brief;
}


@end
