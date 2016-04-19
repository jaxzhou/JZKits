//
//  NSObject_Swizzling.h
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/19.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+(void)siwzzlingSelector:(SEL)selector toSelector:(SEL)toSelector;

@end
