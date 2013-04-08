//
//  ADSummary.h
//  MPGTracker
//
//  Created by Alex Dong on 2/3/13.
//  Copyright (c) 2013 Alex Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CoreLocationController.h"

@interface ADSummary : UIViewController<UIAccelerometerDelegate, MFMailComposeViewControllerDelegate,
    CoreLocationControllerDelegate>{
    UIAccelerometer* accel;
    NSTimer* timer;
    double cTime;
    
    NSCoder* data;
    
    NSMutableArray* x_values;
    NSMutableArray* y_values;
    NSMutableArray* z_values;
    NSMutableArray* times;
    
    NSMutableArray* GPSLocation;
    NSMutableArray* GPSSpeed;
        
    bool startPressed;
    bool paused;
        
    CoreLocationController* CLController;
    IBOutlet UILabel *latitude;
    IBOutlet UILabel *longitude;
    IBOutlet UILabel *speed;
}

@property (nonatomic, retain) CoreLocationController* CLController;

@end


