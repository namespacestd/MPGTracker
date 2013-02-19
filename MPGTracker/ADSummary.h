//
//  ADSummary.h
//  MPGTracker
//
//  Created by Alex Dong on 2/3/13.
//  Copyright (c) 2013 Alex Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ADSummary : UIViewController<UIAccelerometerDelegate, MFMailComposeViewControllerDelegate>{
    UIAccelerometer* accel;
    NSTimer* timer;
    double cTime;
    
    NSCoder* data;
    
    NSMutableArray* x_values;
    NSMutableArray* y_values;
    NSMutableArray* z_values;
    NSMutableArray* times;
    bool startPressed;
}

@end


