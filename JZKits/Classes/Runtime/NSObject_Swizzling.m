//
//  NSObject_Swizzling.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/19.
//
//

#import "NSObject_Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+(void)siwzzlingSelector:(SEL)selector toSelector:(SEL)toSelector{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, selector);
    Method swizzledMethod = class_getInstanceMethod(class, toSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        selector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            toSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
