//
//  UIDevice_Hardware.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/25.
//
//

#import "UIDevice_Hardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (Hardware)

-(NSString*)hardwareString{
    int name[] = {CTL_HW,HW_MACHINE};
    size_t size = 100;
    sysctl(name, 2, NULL, &size, NULL, 0); // getting size of answer
    char *hw_machine = malloc(size);
    
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

@end
