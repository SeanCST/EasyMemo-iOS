//
//  EMBaseModel.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/24.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMBaseModel.h"

@implementation EMBaseModel

- (NSString *)description {
    return [NSString stringWithFormat:@"resultCode:%ld msg:%@ success:%d", (long)_resultCode, _message, _success];
}

@end
