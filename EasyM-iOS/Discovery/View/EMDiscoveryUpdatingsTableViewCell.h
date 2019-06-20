//
//  EMDiscoveryUpdatingsTableViewCell.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/23.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EMUpdatingModel;
static NSString *kDiscoveryUpdatingsTableViewCell = @"EMiscoveryUpdatingsTableViewCell";

@interface EMDiscoveryUpdatingsTableViewCell : UITableViewCell
- (void)setDataModel:(EMUpdatingModel *)model;
@end

NS_ASSUME_NONNULL_END
