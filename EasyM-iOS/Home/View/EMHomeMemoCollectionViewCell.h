//
//  EMHomeMemoCollectionViewCell.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/22.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMProjectModel.h"

//static NSString *kHomeMemoCollectionViewCell = @"EMHomeMemoCollectionViewCell";

@interface EMHomeMemoCollectionViewCell : UICollectionViewCell

//@property (nonatomic, copy) NSString *memoName;

- (void)setProjectModel:(EMProjectModel *)model;

@end
