//
//  EMDiscoverySearchTableViewCell.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/29.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *kDiscoverySearchTableViewCell = @"EMDiscoverySearchTableViewCell";

@interface EMDiscoverySearchTableViewCell : UITableViewCell

- (void)setupData:(EMProjectModel *)dataModel;
@end

NS_ASSUME_NONNULL_END
