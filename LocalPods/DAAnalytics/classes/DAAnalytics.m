//
//  DAAnalytics.m
//  analytics
//
//  Created by Alexander Desyatov on 05/04/16.
//  Copyright © 2016 desyatov. All rights reserved.
//

#import "DAAnalytics.h"
#import "DAModel.h"
#import "DAFields.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking-RACExtensions/AFHTTPSessionManager+RACSupport.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

static NSString * const kAnalyticsIOSURL = @"http://freetopay.ru/";

@interface DAAnalytics ()
@property (nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong, readonly) DAModel *model;
@property (nonatomic, strong, readonly) AFNetworkReachabilityManager *reachabilityManager;
@end

@implementation DAAnalytics

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kAnalyticsIOSURL] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
        _model = [[DAModel alloc] init];
        _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        @weakify(self);
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            @strongify(self);
            [self.model setParameter:[self p_statusStringWithReachabilityStatus:status] forKey:kDAConnectionTypeKey];
        }];
        [self.reachabilityManager startMonitoring];
    }
    return self;
}

- (RACSignal *)send
{
    return [[self.sessionManager rac_GET:@"mobileTest.php" parameters:[self.model buildParameters]] map:^id(RACTuple *value) {
        NSHTTPURLResponse *response = value.second;
        NSLog(@"Did ssend data: %@", [response.URL absoluteString]);
        return value.first;
    }];
}

- (NSString *)p_statusStringWithReachabilityStatus:(AFNetworkReachabilityStatus)status
{
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return @"WAN";
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return @"WiFi";
        default:
            return @"null";;
    }
}

@end
