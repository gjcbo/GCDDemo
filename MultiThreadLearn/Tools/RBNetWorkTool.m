//
//  RBNetWorkTool.m
//  MultiThreadLearn
//
//  Created by RaoBo on 2018/7/13.
//  Copyright © 2018年 关键词. All rights reserved.
// iOS 原生网络请求: https://www.jianshu.com/p/366f41a34218


#import "RBNetWorkTool.h"

@implementation RBNetWorkTool

#pragma mark - 一 原生GET、POST
/**GET请求*/
+ (void)rb_getWithUrl:(NSString *)url parDic:(NSDictionary *)dic successH:(RBSuccessBlock)success failH:(RBFailureBlock)fail {
    NSString *resultUrl = [self assembleGETUrlWithUrl:url parDic:dic];
    
    //创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:resultUrl]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { //将错误回调出去
            fail(error);
        }else { //将请求结果回调出去
            
            NSDictionary *responseDic = [self dicFromResponseData:data];
            
            success(responseDic);
        }
    }];
    
    //启动任务
    [task resume];
}

+ (void)rb_postWithUlr:(NSString *)urlStr parDic:(NSDictionary *)dic successH:(RBSuccessBlock)success failH:(RBFailureBlock)fail {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    //一 创建请求对象
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURl];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:5.0]; //设置请求超时 5秒
    
    //1-1 设置请求方法
    requestM.HTTPMethod = @"POST";
    
    //1-2 设置请求头
    [requestM setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [requestM setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [requestM setValue:@"" forHTTPHeaderField:@"Authorization"]; //Authorization.有点Java后台把这个作为token。如果这个没串会返回 401 。误状态码:401 Authorization这个没有填. 没登录。
    //1-3 设置请求体 (有的Java后台要求所有的GET、POST都必须设置请求头、请求头体。不然一律返回500,有时候还用原始的AFN提供的POST、GET就无效了。)
    NSString *parStr = [self jsonFromDic:dic];
    requestM.HTTPBody = [parStr dataUsingEncoding:NSUTF8StringEncoding];

    //二 创建任务
    NSURLSession *sesson = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sesson dataTaskWithRequest:requestM completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { //请求失败
            fail(error);
        }else {
            NSDictionary *responseDic = [self dicFromResponseData:data];
            success(responseDic);
        }
    }];
    
    //三: 开启任务
    [dataTask resume];
}


#pragma mark - 二 Private mehtod
/**组装GET请求的请求url*/
+ (NSString *)assembleGETUrlWithUrl:(NSString *)url parDic:(NSDictionary *)dic {
    //一:拼接请求参数
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendFormat:@"%@",url];
    
    if ([dic allKeys]) { //如果参数字典不为空:拼接请求参数
        [mStr appendString:@"?"];
        
        for (id key in dic) { //key 可能为NSString、NSNumber
            NSString *v = dic[key];
            [mStr appendFormat:@"%@=%@&",key,v];
        }
        mStr = [[mStr substringToIndex:mStr.length - 1] mutableCopy]; //去掉最后一个&
    }
    
//    NSLog(@"最终的url是:%@",mStr);
    return [mStr copy];
}
/**将dic转化为JSONStr*/
+ (NSString *)jsonFromDic:(NSDictionary *)dic {
    if(dic == nil) return nil;
    
    NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&err];
    
    if (err) {
        NSLog(@"%s--%d---转JSON失败:%@",__FUNCTION__,__LINE__,err);
        return nil;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonStr;
}

/**将服务器返回的NSData 转 Dic*/
+ (NSDictionary *)dicFromResponseData:(NSData *)data {
    NSError *err = nil;
   NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    
    
    if (err) {
        NSLog(@"%s--%d 转换失败:%@",__FUNCTION__,__LINE__,err);
        return nil;
    }
    
    return dic;
}

#pragma mark - 三 接口

+ (void)firstRequestSuccessH:(RBSuccessBlock)success failH:(RBFailureBlock)fail {
   
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSDictionary *dic = @{@"a":@"newlist",
                          @"c":@"data",
                          @"31":@"type"
                          };
    [self rb_getWithUrl:url parDic:dic successH:^(NSDictionary *responObjc) {
        success(responObjc);
    } failH:^(NSError *error) {
        fail(error);
    }];
}

+ (void)secondRequestSuccessH:(RBSuccessBlock)success failH:(RBFailureBlock)fail {
    
    NSString *postUrl = @"http://xinjiangapi.zertone1.com/api/v1/customer/login_passwd";
    NSDictionary *postDic = @{@"customer_name":@"15837694444",
                              @"password":@"e10adc3949ba59abbe56e057f20f883e"
                              };
    
    [self rb_postWithUlr:postUrl parDic:postDic successH:^(NSDictionary *responObjc) {
        success(responObjc);
    } failH:^(NSError *error) {
        fail(error);
    }];
    
}
+ (void)thirdRequestSuccessH:(RBSuccessBlock)success failH:(RBFailureBlock)fail {
    NSString *url = @"http://xinjiangapi.zertone1.com/api/v1/oss/token";
    
    [self rb_getWithUrl:url parDic:nil successH:^(NSDictionary *responObjc) {
        success(responObjc);
    } failH:^(NSError *error) {
        fail(error);
    }];
}


@end
