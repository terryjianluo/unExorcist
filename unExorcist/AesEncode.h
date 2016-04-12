//
//  AesEncode.h
//  unExorcist
//
//  Created by Terry on 15/11/24.
//  Copyright © 2015年 Terry. All rights reserved.
//

#ifndef AesEncode_h
#define AesEncode_h
#import <Foundation/Foundation.h>

@interface NSData(AES256)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end

#endif /* AesEncode_h */
