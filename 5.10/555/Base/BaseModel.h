//
//  BaseModel.h
//  WeiBo
//
//  Created by wxhl on 15-9-6.
//  Copyright (c) 2015年 tfty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
- (id)initWithDataDic:(NSDictionary *)data;
- (NSDictionary *)attributeMapDictionary;
- (void)setAttributes:(NSDictionary *)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData *)getArchivedData;

- (NSString *)cleanString:(NSString *)str; //清除\n和\r的字符串


@end
