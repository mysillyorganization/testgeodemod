#include <Geode/Geode.hpp>
#include <Geode/modify/FLAlertLayer.hpp>
#include <Geode/binding/FLAlertLayerProtocol.hpp>
#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
using namespace geode::prelude;

void showAlert(NSString* title, NSString* desc, NSString* btn1, bool isbtn2, NSString* btn2, FLAleetLayerProtocol* delegate) {
  UIViewController *view = [[[UIApplication sharedApplication] delegate] window].rootViewController;
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                              message:@"This is an alert."
                              preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {}];
  [alert addAction:action1];
  if (isbtn2) {
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {}];
    [alert addAction:action2];
  }

  
  [view presentViewController:alert animated:YES completion:nil];
}

class $modify(FLAlertLayer) {
  struct Fields {
    FLAlertLayerProtocol* delegate;
    char const* title;
    std::string desc;
    char const* btn1;
    char const* btn2;
    
  };
  bool init(FLAlertLayerProtocol *p0, char const *p1, gd::string p2, char const *p3, char const *p4, float p5, bool p6, float p7, float p8) {
    return init(p0, p1, p2, p3, p4, p5, p6, p7, p8);
  }
  void create(FLAlertLayerProtocol *delegate, char const *title, gd::string desc, char const *btn1, char const *btn2, float width, bool scroll, float height, float textscale) {
    m_fields->delegate = delegate;
    m_fields->title = title;
    m_fields->desc = desc;
    m_fields->btn1 = btn1;
    m_fields->btn2 = btn2;
    FLAlertLayer::create(delegate, title, desc, btn1, btn2, width, scroll, height, textscale);
    return;
  }
  void show() {
    bool isbtn2 = false;
    NSString* btn2;
    if (m_fields->title) {
      NSString* title = [NSString stringWithUTF8String:m_fields->title];
      NSString* desc = [NSString stringWithUTF8String:m_fields->desc.c_str()];
      NSString* btn1 = [NSString stringWithUTF8String:m_fields->btn1];
      if (m_fields->btn2) {
        isbtn2 = true;
        btn2 = [NSString stringWithUTF8String:m_fields->btn2];
      }
      showAlert(title, desc, btn1, isbtn2, btn2, m_fields->delegate);
      return;
    }
    FLAlertLayer::show();
    return
  }
};
