//
//  DAModel.h
//  analytics
//
//  Created by Alexander Desyatov on 05/04/16.
//  Copyright © 2016 desyatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAModel : NSObject

- (void)setParameter:(NSString *)value forKey:(NSString *)key;

- (NSDictionary *)buildParameters;

@end
