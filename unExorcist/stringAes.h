//
//  stringAes.h
//  unExorcist
//
//  Created by Terry on 15/11/24.
//  Copyright © 2015年 Terry. All rights reserved.
//

#ifndef stringAes_h
#define stringAes_h
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

#import "AesEncode.h"

@interface NSString(AES256)

-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;

@end

#endif /* stringAes_h */
