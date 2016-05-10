//
//  NSString_Chinese.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/5/10.
//
//

#import "NSString_Chinese.h"

@implementation NSString (Chinese)

-(NSString*)capitalStringOfPinYin{
    return [[[[self substringWithRange:NSMakeRange(0, 1)] pinYin] substringWithRange:NSMakeRange(0, 1)] uppercaseString];
}

-(NSString*)pinYin{
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, (__bridge CFStringRef)self);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    return (__bridge NSString*)string;
}

@end
