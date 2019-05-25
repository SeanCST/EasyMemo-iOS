//
//  EMBaseModel.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/24.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMBaseModel : NSObject

@property (nonatomic, copy) NSString *message; //操作结果
@property (nonatomic, assign) NSInteger resultCode; //状态码
@property (nonatomic, assign) BOOL success; //状态

- (NSString *)description;

@end

NS_ASSUME_NONNULL_END
