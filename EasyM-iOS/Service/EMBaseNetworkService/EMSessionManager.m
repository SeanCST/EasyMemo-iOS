//
//  EMSessionManager.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/24.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMSessionManager.h"

@implementation EMSessionManager

+ (instancetype)shareInstance {
    static EMSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EMSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    });
    
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL {
    self = [super initWithBaseURL:baseURL];
    if (self) {
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.removesKeysWithNullValues = YES;
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"multipart/form-data", nil];
    }
    return self;
}

- (void)getRequestWithURL:(NSString *)url parameters:(NSDictionary *)params success:(Success)success fail:(Fail)fail {
//    [parameter setValuesForKeysWithDictionary:[self returnBaseParameter]];
//    NSString *token = [HMUserInfo getTokenValue];
//    NSMutableString *sign = [NSMutableString stringWithFormat:@"%@%@", [self getSignString:parameter],HMApiSecret];
//    if (![NSString isNullOrEmptyString:token]) {
//        [sign appendString:@"&"];
//        [sign appendString:token];
//        [self.requestSerializer setValue:token forHTTPHeaderField:kToken];
//    }
//    [self.requestSerializer setValue:[MD5Util md5:sign] forHTTPHeaderField:@"sign"];
    
    [[[self class] shareInstance] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"URL:%@ JSON:%@", url, json);
        success(json);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err = [NSError errorWithDomain:error.domain code:error.code userInfo:@{NSLocalizedDescriptionKey : @""}];
        fail(err);
    }];
}

- (void)postRequestWithURL:(NSString *)url parameters:(NSDictionary *)params success:(Success)success fail:(Fail)fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:[kBaseURL stringByAppendingString:url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSString *key in params) {
            NSString *value = params[key];
            [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding] name:key];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"resDict:%@", resDict);
        success(resDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
        fail(error);
    }];
    
    

//    [[[[self class] shareInstance] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (error) {
//            if (fail) {
//                NSError *err = [NSError errorWithDomain:error.domain code:error.code userInfo:@{NSLocalizedDescriptionKey : @""}];
//                fail(err);
//            }
//        } else {
//            if (success) {
//                NSError *error;
//                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
//                NSLog(@"URL:%@ JSON:%@", url, json);
//                success(json);
//            }
//        }
//    }] resume];
}


- (void)networkStatusChanged {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"网络状态未知");
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

@end


//[[[self class] shareInstance] POST:[kBaseURL stringByAppendingString:url] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//
//} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//    NSError *error = nil;
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
//    NSLog(@"URL:%@ JSON:%@", url, json);
//    success(json);
//
//} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    NSError *err = [NSError errorWithDomain:error.domain code:error.code userInfo:@{NSLocalizedDescriptionKey : @""}];
//    fail(err);
//}];
