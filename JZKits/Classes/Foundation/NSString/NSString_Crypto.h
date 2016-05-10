//
//  NSString_Crypto.h
//  Pods
//
//  Created by Zhou Jinxiu on 16/5/10.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Crypto)

-(NSString*)enryptWithDES:(NSString*)desKey;

-(NSString*)decryptWithDES:(NSString*)desKey;

-(NSString*)md5String;

@end
