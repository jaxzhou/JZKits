//
//  NSDateStringifyTestCase.m
//  JZKits
//
//  Created by Zhou Jinxiu on 16/5/10.
//  Copyright © 2016年 JaxZhou. All rights reserved.
//

#import "NSDate_Stringify.h"
#import "NSDate_Caculator.h"
#import "NSDate_ChineseLunar.h"

SPEC_BEGIN(NSDateExtensionTests)

describe(@"NSDate Extension Test", ^{
    beforeAll(^{
        [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    });
    context(@"stringify", ^{
        it(@"Date to String", ^{
            NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1462882704];
            [[[testDate stringWithFormat:@"yyyyMMddHHmmss"] should] equal:@"20160510201824"];
        });
        
        it(@"String to Date", ^{
            NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1462882704];
            [[[NSDate dateFromString:@"20160510201824" withFormat:@"yyyyMMddHHmmss"] should] equal:testDate];
        });
    });
    context(@"caculator", ^{
        it(@"year", ^{
            NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1462882704];
            [[theValue([testDate year]) should] equal:theValue(2016)];
        });
        it(@"month", ^{
            NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1462882704];
            [[theValue([testDate month]) should] equal:theValue(5)];
        });
        it(@"day", ^{
            NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1462882704];
            [[theValue([testDate day]) should] equal:theValue(10)];
        });
        it(@"hour", ^{
            NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1462882704];
            [[theValue([testDate hour]) should] equal:theValue(20)];
        });
        it(@"minutes", ^{
            NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1462882704];
            [[theValue([testDate minutes]) should] equal:theValue(18)];
        });
        it(@"seconds", ^{
            NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1462882704];
            [[theValue([testDate seconds]) should] equal:theValue(24)];
        });
        it(@"wrapper", ^{
            NSDate *testDate  = [NSDate dateFromString:@"20160510201824" withFormat:@"yyyyMMddHHmmss"];
            NSDate *testDate2 = [NSDate dateFromString:@"20160509190024" withFormat:@"yyyyMMddHHmmss"];
            NSDateComponents *components = [testDate componetsSince:testDate2];
            [[theValue(components.year) should] equal:theValue(0)];
            [[theValue(components.month) should] equal:theValue(0)];
            [[theValue(components.day) should] equal:theValue(1)];
            [[theValue(components.hour) should] equal:theValue(1)];
            [[theValue(components.minute) should] equal:theValue(18)];
            [[theValue(components.second) should] equal:theValue(0)];
        });
    });
    context(@"chinese lunar", ^{
        it(@"spring festeval", ^{
            NSDate *testDate = [NSDate dateFromString:@"20160207100000" withFormat:@"yyyyMMddHHmmss"];
            [[[testDate lunarHoliday] should] equal:@"除夕"];
            testDate = [NSDate dateFromString:@"20160208100000" withFormat:@"yyyyMMddHHmmss"];
            [[[testDate lunarHoliday] should] equal:@"春节"];
        });
        it(@"Holidays", ^{
            NSDate *testDate = [NSDate dateFromString:@"20160222100000" withFormat:@"yyyyMMddHHmmss"];
            [[[testDate lunarHoliday] should] equal:@"元宵"];
            testDate = [NSDate dateFromString:@"20160609100000" withFormat:@"yyyyMMddHHmmss"];
            [[[testDate lunarHoliday] should] equal:@"端午"];
        });
        it(@"lunar date", ^{
            NSDate *testDate = [NSDate dateFromString:@"20160208100000" withFormat:@"yyyyMMddHHmmss"];
            [[[testDate lunarDate] should] equal:@"正月初一"];
            testDate = [NSDate dateFromString:@"20160511100000" withFormat:@"yyyyMMddHHmmss"];
            [[[testDate lunarDate] should] equal:@"四月初五"];
            testDate = [NSDate dateFromString:@"20160527100000" withFormat:@"yyyyMMddHHmmss"];
            [[[testDate lunarDate] should] equal:@"四月廿一"];
        });
        it(@"lunar special day", ^{
            NSDate *testDate = [NSDate dateFromString:@"20160505100000" withFormat:@"yyyyMMddHHmmss"];
            [[[testDate lunarSpecialDay] should] equal:@"立夏"];
        });
    });
});

SPEC_END