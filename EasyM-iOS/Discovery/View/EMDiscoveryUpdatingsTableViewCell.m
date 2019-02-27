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
@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UILabel *contentLabel;
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
    [_avatarImageView setImage:[UIImage imageNamed:@"icon_memo_add_highlighted"]];
    [self.contentView addSubview:_avatarImageView];
    _avatarImageView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 5)
    .widthIs(50)
    .heightIs(50);
    
    // Title 
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.numberOfLines = 0;
    _titleLabel.preferredMaxLayoutWidth = kScreenWidth - 50 - 30; // 多行时必须设置，50 = avatar 宽度，30为 padding
    [self.contentView addSubview:_titleLabel];
    _titleLabel.sd_layout
    .topEqualToView(_avatarImageView)
    .leftSpaceToView(_avatarImageView, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_titleLabel setText:@"学霸啊啊 上传了 算法导论"];
    
    
    // 三个按钮
    UIButton *retweetBtn = [UIButton new];
    [self.contentView addSubview:retweetBtn];
    [retweetBtn setTitle:@"转发" forState:UIControlStateNormal];
    [retweetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    retweetBtn.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(_avatarImageView, 10)
    .widthIs(50)
    .heightIs(30);
    
    UIButton *commentBtn = [UIButton new];
    [self.contentView addSubview:commentBtn];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    commentBtn.sd_layout
    .widthRatioToView(retweetBtn, 1)
    .heightRatioToView(retweetBtn, 1)
    .bottomEqualToView(retweetBtn)
    .centerXEqualToView(self.contentView);
    
    UIButton *likeBtn = [UIButton new];
    [self.contentView addSubview:likeBtn];
    [likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
    [likeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    likeBtn.sd_layout
    .widthRatioToView(retweetBtn, 1)
    .heightRatioToView(retweetBtn, 1)
    .bottomEqualToView(retweetBtn)
    .rightSpaceToView(self.contentView, 20);

    
    [self setupAutoHeightWithBottomView:retweetBtn bottomMargin:5];
}
@end
