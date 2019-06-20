//
//  EMUpdatingModel.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/31.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EMUpdatingModel : NSObject<YYModel>
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *knowProjectID;
@property (nonatomic, copy) NSString *knowProjectName;
@property (nonatomic, copy) NSString *coverImg;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *updateCreateTime;
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, assign) NSUInteger knowPointCount;
@end

NS_ASSUME_NONNULL_END
