#import <Cocoa/Cocoa.h>

#import "CamView.h"
#import "DualCamViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
	CamView* cam1;
	CamView* cam2;
	DualCamViewController* dualCamViewController;
}

-(IBAction)toggleLevel:(id)sender;
-(void)windowDidResize:(NSNotification *)notification;

@end

