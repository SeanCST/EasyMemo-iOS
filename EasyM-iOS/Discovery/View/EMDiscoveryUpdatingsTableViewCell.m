//
//  EMDiscoveryUpdatingsTableViewCell.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/23.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMDiscoveryUpdatingsTableViewCell.h"
#import "EMUpdatingModel.h"

@interface EMDiscoveryUpdatingsTableViewCell ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
//@property (nonatomic, strong) UIView *memoView;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIImageView *memoIconView;
@property (nonatomic, strong) UILabel *memoNameLabel;
@property (nonatomic, strong) UILabel *memoDescLabel;

@end

@implementation EMDiscoveryUpdatingsTableViewCell

// 调用 UITableView 的 dequeueReusableCellWithIdentifier 方法时会通过这个方法初始化 Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    // Avatar头像
    _avatarImageView = [UIImageView new];
//    [_avatarImageView setImage:[UIImage imageNamed:@"icon_avatar_default"]];
    [self.contentView addSubview:_avatarImageView];
    _avatarImageView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(32)
    .heightIs(32);
    _avatarImageView.sd_cornerRadius = @(16.0);
    _avatarImageView.clipsToBounds = YES;
    
    // nickNameLabel
    _nickNameLabel = [UILabel new];
    _nickNameLabel.font = [UIFont systemFontOfSize:16];
    _nickNameLabel.preferredMaxLayoutWidth = kScreenWidth - 32 - 30; // 多行时必须设置，50 = avatar 宽度，30为 padding
    [self.contentView addSubview:_nickNameLabel];
    _nickNameLabel.sd_layout
    .topEqualToView(_avatarImageView)
    .leftSpaceToView(_avatarImageView, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_nickNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_nickNameLabel setText:@"学霸啊啊"];

    // timeLabel
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.preferredMaxLayoutWidth = kScreenWidth - 32 - 30; // 多行时必须设置，50 = avatar 宽度，30为 padding
    [self.contentView addSubview:_timeLabel];
    _timeLabel.sd_layout
    .topSpaceToView(_nickNameLabel, 0)
    .leftEqualToView(_nickNameLabel)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_timeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_timeLabel setText:@"12 分钟前 发布了笔记"];
    
    _memoIconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_memoIconView];
    _memoIconView.sd_layout
    .widthIs(100)
    .heightIs(130)
    .leftEqualToView(_avatarImageView)
    .topSpaceToView(_avatarImageView, 20);
    
    // memoNameLabel
    _memoNameLabel = [UILabel new];
    _memoNameLabel.font = [UIFont systemFontOfSize:18];
    //    memoNameLabel.preferredMaxLayoutWidth = kScreenWidth - 32 - 30 - 45;
    [self.contentView addSubview:_memoNameLabel];
    _memoNameLabel.sd_layout
    .heightIs(20)
    .widthIs(kScreenWidth - 180)
    .topEqualToView(_memoIconView)
    .leftSpaceToView(_memoIconView, 20);
    [_memoNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_memoNameLabel setText:@"《软件体系结构笔记》"];
    
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

- (void)setDataModel:(EMUpdatingModel *)model {
    NSString *avatarImgStr = [NSString stringWithFormat:@"%@%@", kBaseURL, model.headImg];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarImgStr] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    self.nickNameLabel.text = model.username;
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 发布了笔记", model.updateCreateTime];
    NSString *coverImgStr = [NSString stringWithFormat:@"%@%@", kBaseURL, model.coverImg];
    [self.memoIconView sd_setImageWithURL:[NSURL URLWithString:coverImgStr] placeholderImage:[UIImage imageWithColor:EMBackgroundColor]];
    self.memoNameLabel.text = model.knowProjectName;
    self.memoDescLabel.text = model.brief;
}

@end

