//
//  EMProjectDetailViewController.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/6/17.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMUpdatingModel.h"
#import "EMProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMProjectDetailViewController : UIViewController
- (instancetype)initWithUpdatingModel:(EMUpdatingModel *)updatingModel;
- (instancetype)initWithProjectModel:(EMProjectModel *)projectModel;
@end

NS_ASSUME_NONNULL_END
