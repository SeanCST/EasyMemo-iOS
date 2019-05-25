//
//  EMUserInfo.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/25.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMUserInfo : NSObject

+ (EMUserModel *)userModelWithDict:(NSDictionary *)dict;

+ (void)saveLocalUser:(EMUserModel *)user;

+ (EMUserModel *)getLocalUser;

@end

NS_ASSUME_NONNULL_END
