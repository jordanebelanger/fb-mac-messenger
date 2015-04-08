#import "AppDelegate.h"
#import <WebKit/WebKit.h>
#import <Sparkle/Sparkle.h>

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@end
@implementation AppDelegate {
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Configure main window
  self.window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
  self.window.titleVisibility = NSWindowTitleHidden;
  self.window.titlebarAppearsTransparent = YES;
  
  // Hack to hide "traffic lights" but still allowing window manipulation (which isn't the case if we use proper window flags)
  [[self.window standardWindowButton:NSWindowCloseButton] setFrame:NSZeroRect];
  [[self.window standardWindowButton:NSWindowMiniaturizeButton] setFrame:NSZeroRect];
  [[self.window standardWindowButton:NSWindowZoomButton] setFrame:NSZeroRect];

  // Web view in main window
  auto webView = [[WebView alloc] initWithFrame:{{0,0},{100,100}} frameName:@"main" groupName:@"main"];
  self.window.contentView = webView;
  auto req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.messenger.com/"]];
  [webView.mainFrame loadRequest:req];
  
  // Sparkle
  auto su = [SUUpdater sharedUpdater];
  su.automaticallyChecksForUpdates = YES;
  su.automaticallyDownloadsUpdates = YES;
  su.feedURL = [NSURL URLWithString:@"http://fbmacmessenger.rsms.me/changelog.xml"];
  [su checkForUpdatesInBackground];
}


- (IBAction)checkForUpdates:(id)sender {
  [[SUUpdater sharedUpdater] checkForUpdates:self];
}


@end
