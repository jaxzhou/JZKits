//
//  UIImage_Redraw.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/25.
//
//

#import "UIImage_Redraw.h"

@implementation UIImage (Redraw)

-(UIImage*)imageColored:(UIColor*)color{
    UIGraphicsBeginImageContextWithOptions(self.size,NO,[UIScreen mainScreen].scale);
    CGRect rect =  CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [color setFill];
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context, kCGPathFill);
    UIImage *newImg  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

@end
