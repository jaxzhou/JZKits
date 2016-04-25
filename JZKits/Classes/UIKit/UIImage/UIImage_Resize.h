//
//  UIImage_Resize.h
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/25.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

// Relatvie rect. Full rect as {0,0,1,1}
-(UIImage*)cropImage:(CGRect)rect;

-(UIImage*)resizeImage:(CGFloat)scale;

@end
