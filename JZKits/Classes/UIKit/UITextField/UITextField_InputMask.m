//
//  UITextField_InputMask.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/19.
//
//

#import "UITextField_InputMask.h"
#import <objc/runtime.h>
#import "NSObject_Swizzling.h"

#define _TextField_InputMask @"_TextField_InputMask"

@implementation UITextField (InputMask)

+(void)load{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        [self siwzzlingSelector:@selector(resignFirstResponder) toSelector:@selector(swizzled_resignFirstResponder)];
        [self siwzzlingSelector:@selector(becomeFirstResponder) toSelector:@selector(swizzled_becomeFirstResponder)];
    });
}

-(BOOL)swizzled_resignFirstResponder{
    if (self.inputView) {
        UIView *mask = objc_getAssociatedObject(self, _TextField_InputMask);
        if (!mask) {
            mask = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            objc_setAssociatedObject(self, _TextField_InputMask, mask, OBJC_ASSOCIATION_RETAIN);
            [mask setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponder)];
            [mask addGestureRecognizer:tapGes];
        }
        [[UIApplication sharedApplication].keyWindow addSubview:mask];
        [mask setAlpha:0];
        [UIView animateWithDuration:0.25 animations:^{
            [mask setAlpha:1];
        }];
    }
    return [self swizzled_resignFirstResponder];
}

-(BOOL)swizzled_becomeFirstResponder{
    if (self.inputView) {
        UIView *mask = objc_getAssociatedObject(self, _TextField_InputMask);
        if (mask) {
            [UIView animateWithDuration:0.25 animations:^{
                [mask setAlpha:0];
            } completion:^(BOOL finished) {
                [mask removeFromSuperview];
            }];
        }
    }
    return [self swizzled_becomeFirstResponder];
}


@end
