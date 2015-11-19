//
//  ISTPerson.m
//  PropertyDemo
//
//  Created by Jone on 15/11/17.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import "ISTPerson.h"

// 第3.2节
//#import <objc/runtime.h>
//static char * const kPersonNameKey = "kPersonNameKey";


@implementation ISTPerson

// 第3.1节
//@synthesize name;
//@synthesize age;

// 第3.2节
//@dynamic name;
//@dynamic age;

// 第1、3.1节
- (NSString *)name
{
    return name;
}

- (void)setName:(NSString *)newName
{
    name = newName;
}

- (NSInteger)age
{
    return age;
}

- (void)setAge:(NSInteger)newAge
{
    age = newAge;
}

// 第3.2节
//- (NSString *)name
//{
//    return objc_getAssociatedObject(self, kPersonNameKey);
//    
//}
//
//- (void)setName:(NSString *)name
//{
//    objc_setAssociatedObject(self, kPersonNameKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

@end
