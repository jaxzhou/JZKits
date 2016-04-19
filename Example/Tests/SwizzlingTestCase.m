//
//  SwizzlingTestCase.m
//  JZKits
//
//  Created by Zhou Jinxiu on 16/4/19.
//  Copyright © 2016年 JaxZhou. All rights reserved.
//


#import "NSObject_Swizzling.h"

@interface SwizzlingTestObject : NSObject

-(NSInteger)MethodA;

-(NSInteger)MethodB;

@end

@implementation SwizzlingTestObject

-(NSInteger)MethodA{
    return 1;
}

-(NSInteger)MethodB{
    return 2;
}

@end

SPEC_BEGIN(SwizzlingTests)

describe(@"Swizzling Test", ^{
    
    context(@"before Swizzling", ^{
        SwizzlingTestObject *beforeObject = [SwizzlingTestObject new];
        it(@"MethodA return 1", ^{
            [[[NSNumber numberWithInteger:[beforeObject MethodA]] should] equal:@1];
        });
        
        it(@"MethodB return 2", ^{
            [[[NSNumber numberWithInteger:[beforeObject MethodB]] should] equal:@2];
        });
        
    });
    
    
    context(@"after Swizzling", ^{
        beforeAll(^{
            [SwizzlingTestObject siwzzlingSelector:@selector(MethodA) toSelector:@selector(MethodB)];
        });
        
        SwizzlingTestObject *afterObject = [SwizzlingTestObject new];
        it(@"MethodA return 2", ^{
            [[[NSNumber numberWithInteger:[afterObject MethodA]] should] equal:@2];
        });
        
        it(@"MethodB return 1", ^{
            [[[NSNumber numberWithInteger:[afterObject MethodB]] should] equal:@1];
        });
    });
    
});

SPEC_END
