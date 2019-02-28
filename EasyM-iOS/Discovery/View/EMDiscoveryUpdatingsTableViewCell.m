//
//  EMDiscoveryUpdatingsTableViewCell.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/23.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMDiscoveryUpdatingsTableViewCell.h"

@interface EMDiscoveryUpdatingsTableViewCell ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *memoView;
@end

@implementation EMDiscoveryUpdatingsTableViewCell

// 调用UITableView的dequeueReusableCellWithIdentifier方法时会通过这个方法初始化Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

//- (void)setupData:(Case4DataEntity *)dataEntity {
//    _dataEntity = dataEntity;
//
//    _avatarImageView.image = dataEntity.avatar;
//    _titleLabel.text = dataEntity.title;
//    _contentLabel.text = dataEntity.content;
//}


- (void)initView {
    
    // Avatar头像
    _avatarImageView = [UIImageView new];
    [_avatarImageView setImage:[UIImage imageNamed:@"icon_avatar_default"]];
    [self.contentView addSubview:_avatarImageView];
    _avatarImageView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(32)
    .heightIs(32);
    
    // nickNameLabel
    _nickNameLabel = [UILabel new];
    _nickNameLabel.font = [UIFont systemFontOfSize:16];
//    _nickNameLabel.numberOfLines = 0;
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
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor lightGrayColor];
//    _timeLabel.numberOfLines = 0;
    _timeLabel.preferredMaxLayoutWidth = kScreenWidth - 32 - 30; // 多行时必须设置，50 = avatar 宽度，30为 padding
    [self.contentView addSubview:_timeLabel];
    _timeLabel.sd_layout
    .topSpaceToView(_nickNameLabel, 0)
    .leftEqualToView(_nickNameLabel)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_timeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_timeLabel setText:@"12 分钟前"];
    
    // contentLabel
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = kScreenWidth - 32 - 30; // 多行时必须设置，50 = avatar 宽度，30为 padding
    [self.contentView addSubview:_contentLabel];
    _contentLabel.sd_layout
    .topSpaceToView(_timeLabel, 5)
    .leftEqualToView(_nickNameLabel)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_contentLabel setText:@"上传了一本新的笔记"];
    
    // memoView
    _memoView = [self getMemoView];
    
    // 三个按钮
    UIButton *retweetBtn = [UIButton new];
    [self.contentView addSubview:retweetBtn];
    [retweetBtn setTitle:@"转发" forState:UIControlStateNormal];
    [retweetBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [retweetBtn setImage:[UIImage imageNamed:@"btn_retweet"] forState:UIControlStateNormal];
    [retweetBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [retweetBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -15, 0.0, 0.0)];
    retweetBtn.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .topSpaceToView(_memoView, 5)
    .widthIs(kScreenWidth / 2 - 30)
    .heightIs(30);
    
    UIButton *commentBtn = [UIButton new];
    [self.contentView addSubview:commentBtn];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"btn_comment"] forState:UIControlStateNormal];
    [commentBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [commentBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -15, 0.0, 0.0)];
    commentBtn.sd_layout
    .widthRatioToView(retweetBtn, 1)
    .heightRatioToView(retweetBtn, 1)
    .bottomEqualToView(retweetBtn)
    .centerXEqualToView(self.contentView);
    
    UIButton *likeBtn = [UIButton new];
    [self.contentView addSubview:likeBtn];
    [likeBtn setTitle:@"赞" forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"btn_like"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"btn_like_fill"] forState:UIControlStateHighlighted];
    [likeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [likeBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [likeBtn setTitleColor:UIColorFromRGB(0xd81e06) forState:UIControlStateHighlighted];
    [likeBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -15, 0.0, 0.0)];
    likeBtn.sd_layout
    .widthRatioToView(retweetBtn, 1)
    .heightRatioToView(retweetBtn, 1)
    .bottomEqualToView(retweetBtn)
    .rightSpaceToView(self.contentView, 0);
    
    [self setupAutoHeightWithBottomView:retweetBtn bottomMargin:5];
}

- (UIView *)getMemoView {
    UIView *memoView = [UIView new];
    memoView.backgroundColor = [UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:0.2];
    [self.contentView addSubview:memoView];
    memoView.sd_layout
    .leftEqualToView(_nickNameLabel)
    .heightIs(40)
    .widthIs(kScreenWidth - 32 - 30)
    .topSpaceToView(_contentLabel, 5);
    
    UIImageView *memoIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_memo"]];
    [memoView addSubview:memoIconView];
    memoIconView.sd_layout
    .widthIs(40)
    .heightIs(40)
    .leftSpaceToView(memoView, 0)
    .centerYEqualToView(memoView);
    
    // memoNameLabel
    UILabel *memoNameLabel = [UILabel new];
    memoNameLabel.font = [UIFont systemFontOfSize:16];
//    memoNameLabel.preferredMaxLayoutWidth = kScreenWidth - 32 - 30 - 45;
    [memoView addSubview:memoNameLabel];
    memoNameLabel.sd_layout
    .heightIs(40)
    .widthIs(kScreenWidth - 32 - 30 - 45)
    .centerYEqualToView(memoView)
    .leftSpaceToView(memoIconView, 0);
    [memoNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [memoNameLabel setText:@"《软件体系结构笔记》"];
    
    return memoView;
}

@end
