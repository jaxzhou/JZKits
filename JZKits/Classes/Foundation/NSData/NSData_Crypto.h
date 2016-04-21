//
//  NSData_Crypto.h
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/19.
//
//

#import <Foundation/Foundation.h>

@interface NSData (Crypto)

-(NSData*)enryptWithDES:(NSString*)desKey;

-(NSData*)decryptWithDES:(NSString*)desKey;

-(NSString*)base64String;

-(NSString*)md5String;

@end
