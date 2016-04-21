//
//  NSDate_Stringify.h
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/19.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Stringify)

+(NSDate*)dateFromString:(NSString*)dateString withFormat:(NSString*)format;

-(NSString*)stringWithFormat:(NSString*)format;

@end
