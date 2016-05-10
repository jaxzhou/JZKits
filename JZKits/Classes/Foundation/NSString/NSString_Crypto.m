//
//  NSString_Crypto.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/5/10.
//
//

#import "NSString_Crypto.h"
#import "NSData_Crypto.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Crypto)

-(NSString*)enryptWithDES:(NSString*)desKey{
    return [[[self dataUsingEncoding:NSUTF8StringEncoding] enryptWithDES:desKey] base64String];
}

-(NSString*)decryptWithDES:(NSString*)desKey{
    NSData *decrypted = [[[NSData alloc] initWithBase64EncodedString:self options:0] decryptWithDES:desKey];
    return [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
}

-(NSString*)md5String{
    NSString *result = nil;
    unsigned char digest[16];
    const char *cStr=[self UTF8String];
    CC_MD5(cStr, strlen(cStr), digest);
    result = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
              digest[0], digest[1],
              digest[2], digest[3],
              digest[4], digest[5],
              digest[6], digest[7],
              digest[8], digest[9],
              digest[10], digest[11],
              digest[12], digest[13],
              digest[14], digest[15]];
    result = [result uppercaseString];
    return result;
}

@end
