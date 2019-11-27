//
//  networktool.h
//  Canbee
//
//  Created by Kluth on 2019/11/6.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN

@interface networktool : NSObject
/*
 发送GET请求
 */
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

/*有token的GET请求**/
+(void)get:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)headerStr success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
/*
 发送POST请求
 */
+(NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;


/*POST Token*/
+(NSURLSessionDataTask *)postTokenpost:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
+(NSString *)get:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)headerStr successforValue:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
+(void)post;
@end

NS_ASSUME_NONNULL_END
