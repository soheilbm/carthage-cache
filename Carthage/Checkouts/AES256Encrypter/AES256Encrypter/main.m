//
//  main.m
//  AES256Encrypter
//
//  Utility created by David Hilowitz on 3/29/14.
//

#import <Foundation/Foundation.h>
#import "NSDataAES256.h"

void printUsage () {
    NSLog(@"Correct usage:\n\nAES256Encrypter.app [-d|-e] <key> <input file> <output file>\nOptions:\n\t-d = decrypt\n\t-e = encrypt\n");
}


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        if(argc != 5) {
            // insert code here...
            NSLog(@"\nMissing file name.\n");
            printUsage();
            return 1;
        } else {
            NSString *command = [NSString stringWithUTF8String:argv[1]];
            if(![command isEqualToString:@"-e"] && ![command isEqualToString:@"-d"]) {
                NSLog(@"\nInvalid command.");
                printUsage();
                return 1;
            }
                
            NSString *key = [NSString stringWithUTF8String:argv[2]];
            NSString *inputPath = [NSString stringWithUTF8String:argv[3]];
            NSString *outputPath = [NSString stringWithUTF8String:argv[4]];

            NSData* loadedData = [[NSData alloc] initWithContentsOfFile:inputPath];
            if(loadedData == nil) {
                NSLog(@"\nUnable to load input file.\n");
                return 1;
            }
            
            NSData* keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
            NSData *newData;
            if ([command isEqualToString:@"-e"]) {
                newData = [loadedData encryptedWithKey:keyData];
            } else {
                newData = [loadedData decryptedWithKey:keyData];
            }
            [newData writeToFile:outputPath atomically:YES];
        }
        
    }
    return 0;
}


