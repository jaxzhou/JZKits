//
//  UITextField_MaxLength.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/19.
//
//

#import "UITextField_MaxLength.h"
#import <objc/runtime.h>
#import "NSObject_Swizzling.h"

#define _UITextField_MaxLegnth @"_UITextField_MaxLegnth"
#define _UITextField_MaxLegnth_WrapDelegate @"_UITextField_MaxLegnth_WrapDelegate"

#pragma mark Wrap Delegate
@interface UITextFieldDelegateWrap : NSObject<UITextFieldDelegate>

@property (nonatomic,retain) id<UITextFieldDelegate> passthroughDelegate;

@end

@implementation UITextFieldDelegateWrap


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.passthroughDelegate) {
        if ([self.passthroughDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
            return [self.passthroughDelegate textFieldShouldBeginEditing:textField];
        }
    }
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.passthroughDelegate) {
        if ([self.passthroughDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
            [self.passthroughDelegate textFieldDidBeginEditing:textField];
        }
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (self.passthroughDelegate) {
        if ([self.passthroughDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
            return [self.passthroughDelegate textFieldShouldEndEditing:textField];
        }
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.passthroughDelegate) {
        if ([self.passthroughDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
            [self.passthroughDelegate textFieldDidEndEditing:textField];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.passthroughDelegate) {
        if ([self.passthroughDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            return [self.passthroughDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
        }
    }
    return true;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if (self.passthroughDelegate) {
        if ([self.passthroughDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
            return [self.passthroughDelegate textFieldShouldClear:textField];
        }
    }
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.passthroughDelegate) {
        if ([self.passthroughDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
            return [self.passthroughDelegate textFieldShouldReturn:textField];
        }
    }
    return true;
}

-(void)textFieldDidChanged:(UITextField*)textField{
    
}

@end

@interface UITextFieldLengthDelegateWrap : UITextFieldDelegateWrap

@property (nonatomic,assign) NSInteger maxLength;

@end

@implementation UITextFieldLengthDelegateWrap

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.markedTextRange) {
        return YES;
    }
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    BOOL backward = string.length == 0;
    
    BOOL canInput = newLength <= self.maxLength || returnKey || backward;
    if (canInput) {
        //Pass through if input length is safe
        return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return canInput;
}

-(void)textFieldDidChanged:(UITextField*)textField{
    if (!textField.markedTextRange) {
        if (textField.text.length > self.maxLength) {
            textField.text = [textField.text substringToIndex:self.maxLength];
        }
    }
}

@end


#pragma mark TextField Extension

@implementation UITextField (MaxLength)

+(void)load{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        [self siwzzlingSelector:@selector(setDelegate:) toSelector:@selector(pass_setDelegate:)];
        [self siwzzlingSelector:@selector(setText:) toSelector:@selector(wrap_setText:)];
    });
}

-(void)setMaxLength:(NSInteger)maxLength{
    objc_setAssociatedObject(self, _UITextField_MaxLegnth, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    
    UITextFieldLengthDelegateWrap *lengthDelegate = objc_getAssociatedObject(self, _UITextField_MaxLegnth_WrapDelegate);
    if (!lengthDelegate) {
        lengthDelegate = [[UITextFieldLengthDelegateWrap alloc] init];
        self.delegate = lengthDelegate;
        [self addTarget:lengthDelegate action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        objc_setAssociatedObject(self, _UITextField_MaxLegnth_WrapDelegate, lengthDelegate, OBJC_ASSOCIATION_RETAIN);
    }
    lengthDelegate.maxLength = maxLength;
}

-(NSInteger)maxLength{
    NSNumber *maxlength = objc_getAssociatedObject(self, _UITextField_MaxLegnth);
    if (maxlength) {
        return [maxlength integerValue];
    }
    return 0;
}

-(void)pass_setDelegate:(id<UITextFieldDelegate>)delegate{
    if (self.delegate && [self.delegate isKindOfClass:[UITextFieldDelegateWrap class]]) {
        [(UITextFieldDelegateWrap*)self.delegate setPassthroughDelegate:delegate];
    }else{
        [self pass_setDelegate:delegate];
    }
}

-(void)wrap_setText:(NSString*)text{
    if (self.maxLength > 0) {
        if (text.length > self.maxLength) {
            text = [text substringToIndex:self.maxLength];
        }
    }
    [self wrap_setText:text];
}

@end
