//
//  NSDate_Caculator.h
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/25.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Caculator)

-(NSInteger)year;

-(NSInteger)month;

-(NSInteger)day;

-(NSInteger)hour;

-(NSInteger)minutes;

-(NSInteger)seconds;

-(NSDateComponents*)componetsSince:(NSDate*)date;

@end
