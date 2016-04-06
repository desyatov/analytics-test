//
//  DADevice.h
//  analytics
//
//  Created by Alexander Desyatov on 05/04/16.
//  Copyright © 2016 desyatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DADevice : NSObject

@property (nonatomic, copy, readonly) NSString *machine; /* Hardware type */
@property (nonatomic, copy, readonly) NSString *model;
@property (nonatomic, copy, readonly) NSString *screenHeight;
@property (nonatomic, copy, readonly) NSString *screenWidth;
@property (nonatomic, copy, readonly) NSString *language;
@property (nonatomic, copy, readonly) NSString *systemName;
@property (nonatomic, copy, readonly) NSString *systemVersion;

@property (nonatomic, copy, readonly) NSString *IDFA;
@property (nonatomic, copy, readonly) NSString *IDFV;

@end
