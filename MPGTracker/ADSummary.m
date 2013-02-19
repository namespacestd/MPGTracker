//
//  ADSummary.m
//  MPGTracker
//
//  Created by Alex Dong on 2/3/13.
//  Copyright (c) 2013 Alex Dong. All rights reserved.
//

#import "ADSummary.h"
#import "ADControl.h"
#import "ADTable.h"
#import <MessageUI/MessageUI.h>

@interface ADSummary ()
@property (weak, nonatomic) IBOutlet UILabel *x_value;
@property (weak, nonatomic) IBOutlet UILabel *y_value;
@property (weak, nonatomic) IBOutlet UILabel *z_value;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;




@end

@implementation ADSummary

- (IBAction)logOut:(UIButton *)sender {
    ADControl *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:controller animated:YES];
    [controller.navigationController setNavigationBarHidden:NO];
    controller.navigationItem.hidesBackButton=YES;
}

- (void) increaseTime {
    self.currentTime.text=[NSString stringWithFormat:@"%g", cTime+=.1];
}
- (IBAction)startRecording:(UIButton *)sender {
    startPressed = true;
    accel = [UIAccelerometer sharedAccelerometer];
    x_values = [[NSMutableArray alloc] init];
    y_values = [[NSMutableArray alloc] init];
    z_values = [[NSMutableArray alloc] init];
    times = [[NSMutableArray alloc] init];
    timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(increaseTime) userInfo:nil repeats:YES];
}
- (IBAction)saveData:(id)sender {
    //NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString* path = [paths objectAtIndex:0];
    
    //NSString *finalPath = [path stringByAppendingPathComponent:@"myfile.txt"];
    
  //  NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
//[data writeToFile:finalPath atomically:YES];
    
    [self showEmailModalView];
}

-(void) showEmailModalView {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker setSubject:@"Data"];
    
    
    NSMutableArray* attachment = [[NSMutableArray alloc] initWithCapacity:[x_values count]];
    
    for(int i=0; i<[x_values count]; i++){
        NSString* temp = [NSString stringWithFormat:@"Time:%@, X:%@, Y:%@, Z:%@", times[i], x_values[i], y_values[i], z_values[i]];
        [attachment addObject:temp];
    }
    NSString* combined = [attachment componentsJoinedByString:@"\n"];
    NSData *data = [combined dataUsingEncoding:NSUTF8StringEncoding];
    
    [picker addAttachmentData:data mimeType:@"application/data" fileName:@"data.csv"];
    
    NSString *emailBody = @"Data";
    
    [picker setMessageBody:emailBody isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
    
    picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
    
    [self presentModalViewController:picker animated:YES];
    picker.mailComposeDelegate=self;
    
}
- (void)mailComposeController:(MFMailComposeViewController *)controller
		  didFinishWithResult:(MFMailComposeResult)result
						error:(NSError *)error {
    NSLog(@"RAWR");
    [self dismissModalViewControllerAnimated:YES];	
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        cTime = 0.0;
        startPressed = false;
    }
    return self;
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    if(startPressed){
    self.x_value.text = [NSString stringWithFormat:@"%g", acceleration.x];
    self.y_value.text = [NSString stringWithFormat:@"%g", acceleration.y];
    self.z_value.text = [NSString stringWithFormat:@"%g", acceleration.z];
    
    if(x_values==nil)
        x_values = [[NSMutableArray alloc] initWithCapacity:10];
    if(y_values==nil)
        y_values = [[NSMutableArray alloc] initWithCapacity:10];
    if(z_values==nil)
        z_values = [[NSMutableArray alloc] initWithCapacity:10];
    if(times==nil)
        times = [[NSMutableArray alloc] initWithCapacity:10];
    
    [x_values addObject:[NSNumber numberWithDouble:acceleration.x]];
    [y_values addObject:[NSNumber numberWithDouble:acceleration.y]];
    [z_values addObject:[NSNumber numberWithDouble:acceleration.z]];
    [times addObject: self.currentTime.text];
    }
}

- (void)viewDidLoad
{
    accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/60.0f;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
