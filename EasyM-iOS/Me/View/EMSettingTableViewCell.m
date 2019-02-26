//
//  EMSettingTableViewCell.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/26.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMSettingTableViewCell.h"

@interface EMSettingTableViewCell ()
@property (nonatomic, strong) UILabel *redLabel;

@end

@implementation EMSettingTableViewCell

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [self initView];
//    }
//    
//    return self;
//}

// 调用 UITableView的dequeueReusableCellWithIdentifier 方法时会通过这个方法初始化 Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    // titleLabel
    UILabel *redLabel = [UILabel new];
    redLabel.textColor = [UIColor redColor];
    redLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:redLabel];
//    redLabel.text = @"注销登陆";
    redLabel.sd_layout
    .widthIs(200)
    .heightIs(44)
    .centerXIs(kScreenWidth / 2)
    .centerYIs(44 / 2);

    self.redLabel = redLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.redLabel.text = title;
}


@end
