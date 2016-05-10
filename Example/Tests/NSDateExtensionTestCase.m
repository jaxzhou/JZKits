//
//  NSDateStringifyTestCase.m
//  JZKits
//
//  Created by Zhou Jinxiu on 16/5/10.
//  Copyright © 2016年 JaxZhou. All rights reserved.
//

#import "NSDate_Stringify.h"
#import "NSDate_Caculator.h"

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
});

SPEC_END