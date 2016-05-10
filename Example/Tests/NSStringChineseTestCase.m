//
//  NSStringChineseTestCase.m
//  JZKits
//
//  Created by Zhou Jinxiu on 16/5/10.
//  Copyright © 2016年 JaxZhou. All rights reserved.
//

#import "NSString_Chinese.h"

SPEC_BEGIN(ChineseStringTests)

describe(@"NSString Chinese Test", ^{
    context(@"Convert PinYin", ^{
        it(@"Capital", ^{
            NSString *testString = @"中文";
            NSString *cap = [testString capitalStringOfPinYin];
            [[cap should] equal:@"Z"];
        });
        it(@"Pinyin", ^{
            NSString *testString = @"中文";
            NSString *pinyin = [testString pinYin];
            [[pinyin should] equal:@"zhong wen"];
        });
    });
    
    context(@"Mix Charactor", ^{
        it(@"Capital", ^{
            NSString *testString = @"a中文";
            NSString *cap = [testString capitalStringOfPinYin];
            [[cap should] equal:@"A"];
        });
        it(@"Capital 2", ^{
            NSString *testString = @"中a文";
            NSString *cap = [testString capitalStringOfPinYin];
            [[cap should] equal:@"Z"];
        });
        it(@"Pinyin", ^{
            NSString *testString = @"a中文";
            NSString *pinyin = [testString pinYin];
            [[pinyin should] equal:@"a zhong wen"];
        });
        it(@"Pinyin 2", ^{
            NSString *testString = @"中a文";
            NSString *pinyin = [testString pinYin];
            [[pinyin should] equal:@"zhong a wen"];
        });
    });
    context(@"Mix symbol", ^{
        it(@"Capital", ^{
            NSString *testString = @"-中文";
            NSString *cap = [testString capitalStringOfPinYin];
            [[cap should] equal:@"-"];
        });
        it(@"Capital 2", ^{
            NSString *testString = @"中-文";
            NSString *cap = [testString capitalStringOfPinYin];
            [[cap should] equal:@"Z"];
        });
        it(@"Pinyin", ^{
            NSString *testString = @"-中文";
            NSString *pinyin = [testString pinYin];
            [[pinyin should] equal:@"-zhong wen"];
        });
        it(@"Pinyin 2", ^{
            NSString *testString = @"中-文";
            NSString *pinyin = [testString pinYin];
            [[pinyin should] equal:@"zhong-wen"];
        });
    });
    context(@"Without Chinese", ^{
        it(@"Capital", ^{
            NSString *testString = @"english";
            NSString *cap = [testString capitalStringOfPinYin];
            [[cap should] equal:@"E"];
        });
        it(@"Pinyin", ^{
            NSString *testString = @"english";
            NSString *pinyin = [testString pinYin];
            [[pinyin should] equal:@"english"];
        });
    });
});

SPEC_END
