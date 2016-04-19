//
//  UITextFieldExtensionTestCase.m
//  JZKits
//
//  Created by Zhou Jinxiu on 16/4/19.
//  Copyright © 2016年 JaxZhou. All rights reserved.
//
#import "UITextField_MaxLength.h"

SPEC_BEGIN(UITextFieldTests)

describe(@"UITextField Test", ^{
    UITextField *textField = [UITextField new];
    context(@"UITextField MaxLength", ^{
        beforeAll(^{
            [textField setMaxLength:10];
        });
        it(@"TextFiled set text length", ^{
            [textField setText:@"12345"];
            [[[NSNumber numberWithInteger:[textField.text length]] should] equal:@5];
            
            [textField setText:@" 12345"];
            [[[NSNumber numberWithInteger:[textField.text length]] should] equal:@6];
            
            [textField setText:@" 12345 "];
            [[[NSNumber numberWithInteger:[textField.text length]] should] equal:@7];
            
            [textField setText:@"1234567890"];
            [[[NSNumber numberWithInteger:[textField.text length]] should] equal:@10];
            
            [textField setText:@"123456789012"];
            [[[NSNumber numberWithInteger:[textField.text length]] should] equal:@10];
            [[[textField text] should] equal:@"1234567890"];
        });
        
        it(@"TextField Delegate", ^{
            id<UITextFieldDelegate> delegate = textField.delegate;
        });
    });
    
    
    
});

SPEC_END