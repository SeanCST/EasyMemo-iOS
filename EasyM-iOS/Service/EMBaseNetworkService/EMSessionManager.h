//
//  EMSessionManager.h
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/24.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^Success)(id _Nullable responseObject);
typedef void (^Fail)(NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface EMSessionManager : AFHTTPSessionManager

+ (instancetype)shareInstance;

- (void)getRequestWithURL:(NSString *)url parameters:(NSDictionary *)params success:(Success)success fail:(Fail)fail;

- (void)postRequestWithURL:(NSString *)url parameters:(NSDictionary *)params success:(Success)success fail:(Fail)fail;

//- (void)uploadImageWithURL:(NSString *)url image:(UIImage *)image success:(Success)success fail:(Fail)fail;
- (void)uploadImageWithURL:(NSString *)url image:(UIImage *)image fileName:(NSString *)fileName uploadToIdName:(NSString *)idName uploadToId:(NSString *)uploadToId success:(Success)success fail:(Fail)fail;

- (void)networkStatusChanged;

@end

NS_ASSUME_NONNULL_END
