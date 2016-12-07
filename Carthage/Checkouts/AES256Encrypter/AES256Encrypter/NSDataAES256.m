//
//  NSDataAES256.h
//  AES256Encrypter
//
//  Posted by @karl (www.mindsnacks.com)
//  This code was taken from the following message board thread:
//  http://www.cocos2d-iphone.org/forums/topic/saved-state-encryption/#post-286058
//

#import "NSDataAES256.h"

#import <CommonCrypto/CommonCryptor.h>

// Key size is 32 bytes for AES256
#define kKeySize kCCKeySizeAES256

@implementation NSData (AES256)

- (NSData*) makeCryptedVersionWithKeyData:(const void*) keyData ofLength:(int) keyLength decrypt:(bool) decrypt
{
    // Copy the key data, padding with zeroes if needed
    char key[kKeySize];
    bzero(key, sizeof(key));
    memcpy(key, keyData, keyLength > kKeySize ? kKeySize : keyLength);
    
    size_t bufferSize = [self length] + kCCBlockSizeAES128;
    void* buffer = malloc(bufferSize);
    
    size_t dataUsed;
    
    CCCryptorStatus status = CCCrypt(decrypt ? kCCDecrypt : kCCEncrypt,
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding | kCCOptionECBMode,
                                     key, kKeySize,
                                     NULL,
                                     [self bytes], [self length],
                                     buffer, bufferSize,
                                     &dataUsed);
    
    switch(status)
    {
        case kCCSuccess:
            return [NSData dataWithBytesNoCopy:buffer length:dataUsed];
        case kCCParamError:
            NSLog(@"Error: NSDataAES256: Could not %s data: Param error", decrypt ? "decrypt" : "encrypt");
            break;
        case kCCBufferTooSmall:
            NSLog(@"Error: NSDataAES256: Could not %s data: Buffer too small", decrypt ? "decrypt" : "encrypt");
            break;
        case kCCMemoryFailure:
            NSLog(@"Error: NSDataAES256: Could not %s data: Memory failure", decrypt ? "decrypt" : "encrypt");
            break;
        case kCCAlignmentError:
            NSLog(@"Error: NSDataAES256: Could not %s data: Alignment error", decrypt ? "decrypt" : "encrypt");
            break;
        case kCCDecodeError:
            NSLog(@"Error: NSDataAES256: Could not %s data: Decode error", decrypt ? "decrypt" : "encrypt");
            break;
        case kCCUnimplemented:
            NSLog(@"Error: NSDataAES256: Could not %s data: Unimplemented", decrypt ? "decrypt" : "encrypt");
            break;
        default:
            NSLog(@"Error: NSDataAES256: Could not %s data: Unknown error", decrypt ? "decrypt" : "encrypt");
    }
    
    free(buffer);
    return nil;
}

- (NSData*) encryptedWithKey:(NSData*) key
{
    return [self makeCryptedVersionWithKeyData:[key bytes] ofLength:(int)[key length] decrypt:NO];
}

- (NSData*) decryptedWithKey:(NSData*) key
{
    return [self makeCryptedVersionWithKeyData:[key bytes] ofLength:(int)[key length] decrypt:YES];
}

- (NSDictionary*) decryptDataWithKey:(NSString *)key{
    NSData *decriptedPlist = [self decryptedWithKey:[key dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    NSPropertyListFormat format;
    
    NSDictionary *dict = [NSPropertyListSerialization propertyListWithData:decriptedPlist options:NSPropertyListImmutable format:&format error:&error];
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        return dict;
        
    }else{
        
        NSLog(@"Error in decripting the data file. Returning nil.");
        return nil;
    }
    
    
}

@end
