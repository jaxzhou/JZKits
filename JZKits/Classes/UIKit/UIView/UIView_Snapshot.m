//
//  UIView_Snapshot.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/25.
//
//

#import "UIView_Snapshot.h"

@implementation UIView (Snapshot)

-(UIImage*)snapshotImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[self layer] renderInContext:context];
    UIImage *contentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return contentImage;
}

@end
