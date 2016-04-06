//
//  DADevice.m
//  analytics
//
//  Created by Alexander Desyatov on 05/04/16.
//  Copyright © 2016 desyatov. All rights reserved.
//

#import "DADevice.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>
//@import AdSupport;

@implementation DADevice

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat scaleFactor = [UIScreen mainScreen].scale;
        CGFloat screenWidth = screenRect.size.width * scaleFactor;
        CGFloat screenHeight = screenRect.size.height * scaleFactor;
        
        _model = [UIDevice currentDevice].model;
        _machine = [self p_machine];
        _screenWidth = [@(screenWidth) stringValue];
        _screenHeight = [@(screenHeight) stringValue];
        _language = [[NSLocale preferredLanguages] objectAtIndex:0];
        
        _systemName = [UIDevice currentDevice].systemName;
        _systemVersion = [UIDevice currentDevice].systemVersion;
        
        _IDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        _IDFV = [[[UIDevice currentDevice].identifierForVendor UUIDString] uppercaseString];
        
    }
    return self;
}

- (NSString *)p_machine;
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

@end
