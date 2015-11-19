//
//  main.m
//  PropertyDemo
//
//  Created by Jone on 15/11/17.
//  Copyright © 2015年 Jone. All rights reserved.
//

/**
 *  main.h
 */
#import <Foundation/Foundation.h>
#import "ISTPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
     
        ISTPerson *person = [[ISTPerson alloc] init];
        
        person.name = @"iOSTalk";
        person.age  = 6;

        NSLog(@"name:%@, age:%ld", person.name, (long)person.age);
//        NSLog(@"name:%@", person.name); // 3.2节
        
    }
    return 0;
}
