#include <Geode/Geode.hpp>
#include <Geode/modify/FLAlertLayer.hpp>
#include <Geode/binding/FLAlertLayerProtocol.hpp>
#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
using namespace geode::prelude;

void showAlert(NSString* title, NSString* desc, NSString* btn1, bool isbtn2, NSString* btn2, FLAlertLayerProtocol* delegate, FLAlertLayer* fr) {
  dispatch_async(dispatch_get_main_queue(), ^{
  UIViewController *view = [UIApplication sharedApplication].keyWindow.rootViewController;
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                              message:desc
                              preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* action1 = [UIAlertAction actionWithTitle:btn1 style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction* action) {
                                delegate->FLAlert_Clicked(fr, false);
                              }];
  [alert addAction:action1];
  if (isbtn2) {
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:btn2 style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction* action) {
                                delegate->FLAlert_Clicked(fr, true);
                              }];
    [alert addAction:action2];
  }

  
  [view presentViewController:alert animated:YES completion:nil];
});}

class $modify(FLAlertLayer) {
  FLAlertLayer* fr;
  struct Fields {
    FLAlertLayerProtocol* delegate;
    char const* title;
    std::string desc;
    char const* btn1;
    char const* btn2;
    
  };
  bool init(FLAlertLayerProtocol *p0, char const *p1, gd::string p2, char const *p3, char const *p4, float p5, bool p6, float p7, float p8) {
    m_fields->delegate = p0;
    m_fields->title = p1;
    m_fields->desc = p2;
    m_fields->btn1 = p3;
    m_fields->btn2 = p4;
    return FLAlertLayer::init(p0, p1, p2, p3, p4, p5, p6, p7, p8);
  }
  void create(FLAlertLayerProtocol *p0, char const *p1, gd::string p2, char const *p3, char const *p4, float p5, bool p6, float p7, float p8) {
    m_fields->delegate = p0;
    m_fields->title = p1;
    m_fields->desc = p2;
    m_fields->btn1 = p3;
    m_fields->btn2 = p4;
    FLAlertLayer::create(p0, p1, p2, p3, p4, p5, p6, p7, p8);
    return;
  }
  void show() {
    fr = static_cast<FLAlertLayer*>(this);
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
      showAlert(title, desc, btn1, isbtn2, btn2, m_fields->delegate, fr);
      return;
    }
    FLAlertLayer::show();
    return;
  }
};
