//
//  CoreLocationController.m
//  MPGTracker
//
//  Created by Alex Dong on 2/21/13.
//  Copyright (c) 2013 Alex Dong. All rights reserved.
//

#import "CoreLocationController.h"

@implementation CoreLocationController

- (id) init{
    self = [super init];
    if(self != nil) {
        self.locMgr 	= [[CLLocationManager alloc] init];
        self.locMgr.delegate = self;
    }
    return self;
}

- (void) locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    if([self.delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]){
        [self.delegate locationUpdate:newLocation];
    }
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if([self.delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]){
        [self.delegate locationError:error];
    }
}

@end
	