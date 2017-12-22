//
//  NetWorkManager.m
//  GCD
//
//  Created by RaoBo on 2017/12/22.
//  Copyright © 2017年 RaoBo. All rights reserved.
//

#import "NetWorkManager.h"
#import <AFNetworking.h>
@interface NetWorkManager()
@end

@implementation NetWorkManager

+ (void)firstRequestWithSucces:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"newlist";
    dic[@"c"] = @"data";
    dic[@"maxtime"] = @"0";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)secondRequestWithSucces:(SuccessBlock)success failure:(FailureBlock)failure{
    NSString *urlStr2 = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"tags_list";
    dic[@"c"] = @"subscribe";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr2 parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)thirdRequestWithSucces:(SuccessBlock)success failure:(FailureBlock)failure{
    NSString *urlStr3 = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"tag_recommend";
    dic[@"action"] = @"sub";
    dic[@"c"] = @"topic";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr3 parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
