//
//  DAModel.m
//  analytics
//
//  Created by Alexander Desyatov on 05/04/16.
//  Copyright © 2016 desyatov. All rights reserved.
//

#import "DAModel.h"
#import "DAFields.h"
#import "DADevice.h"

@interface DAModel ()
@property (nonatomic, strong, readonly) NSMutableDictionary *defaultParameters;
@property (nonatomic, strong, readonly) NSMutableDictionary *parameters;
@property (nonatomic, strong, readonly) DADevice *device;
@end

@implementation DAModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _device = [[DADevice alloc] init];
        _defaultParameters = [self p_builDefaultParameters];
        _parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSMutableDictionary *)p_builDefaultParameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[kDAIdfaKey] = self.device.IDFA;
    parameters[kDAIdfvKey] = self.device.IDFV;
    parameters[kDAScreenWidthKey] = self.device.screenWidth;
    parameters[kDAScreenHeightKey] = self.device.screenHeight;
    return parameters;
}

- (void)setParameter:(NSString *)value forKey:(NSString *)key
{
    self.parameters[key] = value;
}

- (NSDictionary *)buildParameters
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:self.defaultParameters];
    [result addEntriesFromDictionary:self.parameters];
    return [result copy];
}

@end
