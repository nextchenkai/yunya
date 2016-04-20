/*
 *  pinyin.h
 *  EMINest
 *
 *  Created by WongSuechang on 4/21/10.
 *  Copyright 2010 emi365. All rights reserved.
 *
 */

/*
 * // Example
 *
 * #import "pinyin.h"
 *
 * NSString *hanyu = @"中国共产党万岁！";
 * for (int i = 0; i < [hanyu length]; i++)
 * {
 *     printf("%c", pinyinFirstLetter([hanyu characterAtIndex:i]));
 * }
 *
 */

char pinyinFirstLetter(unsigned short hanzi);