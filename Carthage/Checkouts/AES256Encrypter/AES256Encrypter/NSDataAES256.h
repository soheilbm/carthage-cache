//
//  NSDataAES256.h
//  AES256Encrypter
//
//  Posted by @karl (www.mindsnacks.com)
//  This code was taken from the following message board thread:
//  http://www.cocos2d-iphone.org/forums/topic/saved-state-encryption/#post-286058
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

- (NSData*) encryptedWithKey:(NSData*) key;
- (NSData*) decryptedWithKey:(NSData*) key;
- (NSDictionary*) decryptDataWithKey:(NSString *)key;
@end
