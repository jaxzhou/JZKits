//
//  UIImage_Resize.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/25.
//
//

#import "UIImage_Resize.h"

@implementation UIImage (Resize)

-(UIImage*)cropImage:(CGRect)rect{
    CGSize orignSize = self.size;
    CGSize desSize = rect.size;
    desSize.width = orignSize.width * rect.size.width;
    desSize.height = orignSize.height * rect.size.height;
    
    CGPoint desOrigin = CGPointZero;
    desOrigin.x = -orignSize.width * rect.origin.x;
    desOrigin.y = -orignSize.height * rect.origin.y;
    UIGraphicsBeginImageContextWithOptions(desSize, false, [UIScreen mainScreen].scale);
    [self drawAtPoint:desOrigin];
    UIImage* desImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return desImage;
}

-(UIImage*)resizeImage:(CGFloat)scale{
    CGSize orignSize = self.size;
    CGSize desSzie = orignSize;
    desSzie.width = desSzie.width *scale;
    desSzie.height = desSzie.height*scale;
    
    UIGraphicsBeginImageContextWithOptions(desSzie, false, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, desSzie.width, desSzie.height)];
    UIImage *desImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return desImage;
}

@end
