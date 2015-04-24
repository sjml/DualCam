#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	dualCamViewController = [[DualCamViewController alloc] init];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResize:) name:NSWindowDidEndLiveResizeNotification object:self.window];
	
	cam1 = [[CamView alloc] init];
	[self.window.contentView addSubview:cam1];
	NSRect cam1Bounds = [self.window.contentView bounds];
	cam1Bounds.size.height /= 2;
	cam1.frame = cam1Bounds;
	[cam1 setup];
	
	cam2 = [[CamView alloc] init];
	[self.window.contentView addSubview:cam2];
	NSRect cam2Bounds = [self.window.contentView bounds];
	cam2Bounds.size.height /= 2;
	cam2Bounds.origin.y = cam1Bounds.size.height;
	cam2.frame = cam2Bounds;
	[cam2 setup];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	[cam1->captureSession stopRunning];
	[cam2->captureSession stopRunning];
}


- (IBAction)toggleLevel:(id)sender {
	if (self.window.level == 0) {
		self.window.level = kCGFloatingWindowLevelKey;
	}
	else {
		self.window.level = 0;
	}
}

- (void)windowDidResize:(NSNotification *)notification {
	NSRect cam1Bounds = [self.window.contentView bounds];
	cam1Bounds.size.height /= 2;
	cam1.frame = cam1Bounds;
	[cam1 setup];
	
	NSRect cam2Bounds = [self.window.contentView bounds];
	cam2Bounds.size.height /= 2;
	cam2Bounds.origin.y = cam1Bounds.size.height;
	cam2.frame = cam2Bounds;
	[cam2 setup];
	
	[cam1->previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
	[cam2->previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
}

@end
