//
//  EMUserInfo.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/25.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMUserInfo.h"

@implementation EMUserInfo

+ (EMUserModel *)userModelWithDict:(NSDictionary *)dict {
    EMUserModel *model = [EMUserModel yy_modelWithDictionary:dict];
    
    return model;
}

+ (void)saveLocalUser:(EMUserModel *)user {
    NSString *data = [user yy_modelToJSONString];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"kLocalUser"];
    [defaults synchronize];
}

+ (EMUserModel *)getLocalUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *data = [defaults objectForKey:@"kLocalUser"];
    EMUserModel *user = [EMUserModel new];
    if(data != nil) {
        user = [EMUserModel yy_modelWithJSON:data];
    }
    return user;
}

@end
