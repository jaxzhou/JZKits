//
//  NSDate_ChineseLunar.h
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/25.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (ChineseLunar)

-(NSString*)lunarDate;

-(NSString*)lunarHoliday;

-(NSString*)lunarSpecialDay;

+(NSDate*)dateOfLunar:(NSString*)lunar atYear:(int)year;

+(NSString*)nextLunar:(NSString*)lunar;

@end
