//
//  networktool.m
//  Canbee
//
//  Created by Kluth on 2019/11/6.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import "networktool.h"

@implementation networktool
/*
 发送GET请求
 */
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure{
	//1.获得请求管理者
	AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
	
	//2.发送GET请求
	[mgr GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if(success){
			success(responseObject);
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		if(failure){
			failure(error);
		}
	}];
}

//有token的GET请求
+(void)get:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)headerStr success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure{
    //1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.发送GET请求
    [mgr GET:url parameters:params headers:headerStr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
}
////有返回值 的 token的GET请求
//+(NSString *)get:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)headerStr successforValue:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure{
//    //1.获得请求管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    
//    //2.发送GET请求
//    [mgr GET:url parameters:params headers:headerStr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if(success){
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if(failure){
//            failure(error);
//        }
//    }];
//    NSString *str;
//    return  str;
//}

/*
 发送POST请求
 */
+(NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure{
	//1.获得请求管理者
	AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
	
	NSURLSessionDataTask *dataTask = [mgr POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if(success){
			success(responseObject);
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		if(failure){
			failure(error);
		}
	}];
	
	return dataTask;
}

/*发送POST请求添加Token*/
+(NSURLSessionDataTask *)postTokenpost:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure{
    //1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *dataTask = [mgr POST:url parameters:params headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
    return dataTask;
}
+(void)post{
    NSURL *url = [NSURL URLWithString:@"https://www.jianshu.com/sign_in"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [@"username=3343&password=wujianhe&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.创建task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[NSThread currentThread]);
        //解析数据
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    //5.执行Task
    [dataTask resume];
}

@end
