//
//  EMPointDetailViewController.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/27.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EMPointDetailViewController : UIViewController
- (instancetype)initWithPointArr:(NSArray *)pointArr currentIndex:(NSUInteger)currentIndex;

@end

NS_ASSUME_NONNULL_END
