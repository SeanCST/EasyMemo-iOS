//
//  EMProjectModel.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/25.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EMProjectModel : NSObject <YYModel>
@property (nonatomic, copy) NSString *knowProjectID;
@property (nonatomic, copy) NSString *knowProjectName;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, copy) NSString *coverImg;
@property (nonatomic, copy) NSString *updateCreateTime;
@property (nonatomic, assign) NSInteger knowPointCount;
@property (nonatomic, strong) NSArray *knowPoints;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *userImg;

@end

@interface EMKnowPointModel : NSObject <YYModel>
@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *hint;

@end

NS_ASSUME_NONNULL_END
