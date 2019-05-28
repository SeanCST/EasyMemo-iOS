//
//  EMProjectModel.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/25.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMProjectModel.h"

@implementation EMProjectModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"knowPoints" : [EMKnowPointModel class]
             };
}

@end

@implementation EMKnowPointModel 

@end
