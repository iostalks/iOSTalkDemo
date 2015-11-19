//
//  ISTPerson.h
//  PropertyDemo
//
//  Created by Jone on 15/11/17.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISTPerson : NSObject
{
    NSString *name;
    NSInteger age;
}
// 第1节
- (NSString *)name;

- (void)setName:(NSString *)newName;


- (NSInteger)age;

- (void)setAge:(NSInteger)newAge;

// 第2、3、4节
//@property (nonatomic, strong) NSString  *name;
//@property (nonatomic, assign) NSInteger age;

@end
