//
//  CoreLocationController.h
//  MPGTracker
//
//  Created by Alex Dong on 2/21/13.
//  Copyright (c) 2013 Alex Dong. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@protocol CoreLocationControllerDelegate
@required
- (void) locationUpdate:(CLLocation *) location;
- (void) locationError:(NSError *) error;	
@end

@interface CoreLocationController : NSObject <CLLocationManagerDelegate>{
    CLLocationManager* locMgr;
    id delegate;
}

@property (nonatomic, retain) CLLocationManager *locMgr;
@property (nonatomic, assign) id delegate;

@end
