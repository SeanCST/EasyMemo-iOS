//
//  EMUserModel.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/25.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EMUserModel : NSObject<YYModel>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, copy) NSString *registerTime;
@property (nonatomic, assign) BOOL gender;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *lastLoginTime;
@property (nonatomic, copy) NSString *uID;
@property (nonatomic, copy) NSString *img;


@property (nonatomic, assign) NSInteger projectNumber;
@property (nonatomic, assign) NSInteger focusNumber;
@property (nonatomic, assign) NSInteger fansNumber;


/* 标记是自己还是他人 */
@property (nonatomic, assign, getter=isOther) BOOL other;

@end


NS_ASSUME_NONNULL_END

