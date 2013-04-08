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
    if(!paused)
        self.currentTime.text=[NSString stringWithFormat:@"%g", cTime+=1];
}
- (IBAction)reset:(UIButton *)sender {
    accel = [UIAccelerometer sharedAccelerometer];
    x_values = [[NSMutableArray alloc] init];
    y_values = [[NSMutableArray alloc] init];
    z_values = [[NSMutableArray alloc] init];
    times = [[NSMutableArray alloc] init];
    GPSSpeed = [[NSMutableArray alloc] init];
    GPSLocation = [[NSMutableArray alloc] init];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseTime) userInfo:nil repeats:YES];
    
    self.x_value.text = @"0.0";
    self.y_value.text = @"0.0";
    self.z_value.text = @"0.0";
    self.currentTime.text = @"0.0";
    cTime = 0.0;
}

- (IBAction)stopRecording:(UIButton *)sender {
    paused = true;
}
- (IBAction)startRecording:(UIButton *)sender {
    if(paused)
        paused =false;
    else{
        startPressed = true;
        accel = [UIAccelerometer sharedAccelerometer];
        x_values = [[NSMutableArray alloc] init];
        y_values = [[NSMutableArray alloc] init];
        z_values = [[NSMutableArray alloc] init];
        times = [[NSMutableArray alloc] init];
        GPSSpeed = [[NSMutableArray alloc] init];
        GPSLocation = [[NSMutableArray alloc] init];
    
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseTime) userInfo:nil repeats:YES];
    }
}




- (IBAction)saveData:(id)sender {    
    [self showEmailModalView];
}

-(void) showEmailModalView {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker setSubject:@"Data"];
    
    
    NSMutableArray* attachment = [[NSMutableArray alloc] initWithCapacity:[x_values count]];
    
    for(int i=0; i<[x_values count]; i++){
        NSString* temp = [NSString stringWithFormat:@"Time:%@, X:%@, Y:%@, Z:%@, GPSLocation:%@, GPSSpeed:%@", times[i], x_values[i], y_values[i], z_values[i], GPSLocation[i], GPSSpeed[i]];
        [attachment addObject:temp];
    }
    NSString* combined = [attachment componentsJoinedByString:@"\n"];
    NSData *data = [combined dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = [paths objectAtIndex:0];
    
    NSString *finalPath = [path stringByAppendingPathComponent:@"myfile.txt"];
    
    [data writeToFile:finalPath atomically:YES];
    
    [picker addAttachmentData:data mimeType:path fileName:@"myfile.txt"];
    
    
    NSString *emailBody = @"Data";
    
    [picker setMessageBody:emailBody isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
    
    picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, T	ranslucent colors behave quirky.
    
    [self presentModalViewController:picker animated:YES];
    picker.mailComposeDelegate=self;
    
}
- (void)mailComposeController:(MFMailComposeViewController *)controller
		  didFinishWithResult:(MFMailComposeResult)result
						error:(NSError *)error {

    [self dismissModalViewControllerAnimated:YES];	
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        cTime = 0.0;
        startPressed = false;
        paused = false;
    }
    return self;
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    if(!paused && startPressed){
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
    if(GPSSpeed==nil)
        GPSSpeed = [[NSMutableArray alloc] initWithCapacity:10];
    if(GPSLocation==nil)
        GPSLocation=[[NSMutableArray alloc] initWithCapacity:10];
    
    [x_values addObject:[NSNumber numberWithDouble:acceleration.x]];
    [y_values addObject:[NSNumber numberWithDouble:acceleration.y]];
    [z_values addObject:[NSNumber numberWithDouble:acceleration.z]];
    [times addObject: self.currentTime.text];
        [GPSLocation addObject:[NSString stringWithFormat:@"%@,  %@",latitude.text, longitude.text]];
    [GPSSpeed addObject:speed.text];
    }
}

- (void)viewDidLoad
{
    accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/60.0f;
    
    [super viewDidLoad];
    
    CLController = [[CoreLocationController alloc] init];
    CLController.delegate = self;
    [CLController.locMgr startUpdatingLocation];
}

- (void) locationUpdate:(CLLocation *)location{
    NSMutableArray* parsedData = [self GPSDataParse:[location description]];
    		
    latitude.text = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    longitude.text = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    speed.text = parsedData[1];	
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *loc = [locations lastObject];
       NSMutableArray* parsedData = [self GPSDataParse:[loc description]];
    latitude.text = [NSString stringWithFormat:@"%f", loc.coordinate.latitude];
    longitude.text = [NSString stringWithFormat:@"%f", loc.coordinate.longitude];
    speed.text = parsedData[1];
}

- (void) locationError:(NSError *)error{
    latitude.text = [error description];
    longitude.text = [error description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray*) GPSDataParse:(NSString*) data{
    NSMutableArray* values = [[NSMutableArray alloc] initWithCapacity:2];
    int temp=0;
    
    for(int i=0; i<data.length; i++){
        if([data characterAtIndex:i]=='('){
            [values addObject:[data substringToIndex:i]];
            temp = i;
        }
        else if([data characterAtIndex:i]==')')
            [values addObject:[[data substringToIndex:i] substringFromIndex:temp+1]];
    }
    return values;
}

@end
