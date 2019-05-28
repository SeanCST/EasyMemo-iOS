//
//  UIView+Response.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/28.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Response)
/* 获取当前 View 所处的控制器 **/
- (UIViewController *)parentViewController;
@end

NS_ASSUME_NONNULL_END
