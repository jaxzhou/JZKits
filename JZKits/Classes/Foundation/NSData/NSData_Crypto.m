//
//  NSData_Crypto.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/19.
//
//

#import "NSData_Crypto.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSData (Crypto)

-(NSData*)enryptWithDES:(NSString*)desKey{
    if (!desKey) {
        return nil;
    }
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [desKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *keyData = [desKey dataUsingEncoding:NSUTF8StringEncoding];
    Byte *iv = (Byte *)[keyData bytes];
    NSInteger length = self.length;
    size_t bufferSize = length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeDES,
                                          iv ,
                                          [self bytes], length,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    return nil;
}

-(NSData*)decryptWithDES:(NSString*)desKey{
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,kCCOptionPKCS7Padding,
                                          [desKey UTF8String], kCCKeySizeDES,
                                          (Byte *)[[desKey dataUsingEncoding:NSUTF8StringEncoding] bytes],
                                          [self bytes], [self length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        return [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
    }
    return nil;
}

-(NSString*)base64String{
    return [self base64EncodedStringWithOptions:0];
}

-(NSString*)md5String{
    NSString *result = nil;
    unsigned char digest[16];
    const char *cStr=[[[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding] UTF8String];
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
