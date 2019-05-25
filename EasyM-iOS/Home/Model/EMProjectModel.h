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
@property (nonatomic, copy) NSString *know_project_id;
@property (nonatomic, copy) NSString *know_project_name;

@end

@interface EMKnowPointModel : NSObject <YYModel>
@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *hint;

@end

NS_ASSUME_NONNULL_END
