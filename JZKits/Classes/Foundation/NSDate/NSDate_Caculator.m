//
//  NSDate_Caculator.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/25.
//
//

#import "NSDate_Caculator.h"

@implementation NSDate (Caculator)

-(NSInteger)year{
    time_t rawtime = [self timeIntervalSince1970];
    struct tm *ti = localtime(&rawtime);
    int year = (*ti).tm_year + 1900;
    return year;
}

-(NSInteger)month{
    time_t rawtime = [self timeIntervalSince1970];
    struct tm *ti = localtime(&rawtime);
    int month = (*ti).tm_mon+1;
    return month;
}

-(NSInteger)day{
    time_t rawtime = [self timeIntervalSince1970];
    struct tm *ti = localtime(&rawtime);
    int day = (*ti).tm_mday;
    return day;
}

-(NSInteger)hour{
    time_t rawtime = [self timeIntervalSince1970] ;
    struct tm *ti = localtime(&rawtime);
    int hour = (*ti).tm_hour;
    return hour;
}

-(NSInteger)minutes{
    time_t rawtime = [self timeIntervalSince1970] ;
    struct tm *ti = localtime(&rawtime);
    int min = (*ti).tm_min;
    return min;
}

-(NSInteger)seconds{
    time_t rawtime = [self timeIntervalSince1970] ;
    struct tm *ti = localtime(&rawtime);
    int sec = (*ti).tm_sec;
    return sec;
}

-(NSDateComponents*)componetsSince:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar  currentCalendar];
    return [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date toDate:self options:NSCalendarWrapComponents];
}
@end
