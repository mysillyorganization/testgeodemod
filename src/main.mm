#include <Geode/Geode.hpp>
#include <Geode/modify/FLAlertLayer.hpp>
#include <Geode/modify/FLAlertLayerProtocol.hpp>
#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
using namespace geode::prelude;

void button1callback(FLAlertLayer* alert, FLAlertLayerProtocol* ok) {
  if (alert) {
    NSLog(@"silly");
  }
  if (ok) {
    NSLog(@"very silly");
  }
  //ok yeah both are defined but no callback
  //ok->FLAlert_Clicked(alert, false);
}

void button2callback(FLAlertLayer* alert, FLAlertLayerProtocol* ok) {
  alert->onBtn2(ok);
  //ok->FLAlert_Clicked(alert, true);
}

void showAlert(NSString* title, NSString* desc, NSString* btn1, bool isbtn2, NSString* btn2, FLAlertLayerProtocol* qhar, FLAlertLayer* fr, CCObject* button2) {
  dispatch_async(dispatch_get_main_queue(), ^{
  UIViewController *view = [UIApplication sharedApplication].keyWindow.rootViewController;
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                              message:desc
                              preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* action1 = [UIAlertAction actionWithTitle:btn1 style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction* action) {
                                button1callback(fr, qhar);
                              }];
  [alert addAction:action1];
  if (isbtn2) {
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:btn2 style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction* action) {
                                button2callback(fr, qhar);
                              }];
    [alert addAction:action2];
  }

  
  [view presentViewController:alert animated:YES completion:nil];
});}

class $modify(FLAlertLayerProtocol) {
  void FLAlert_Clicked(FLAlertLayer* flalert, bool btn2) {
    FLAlertLayerProtocol::FLAlert_Clicked(flalert, btn2);
    return;
  }
};

class $modify(FLAlertLayer) {
  
  struct Fields {
    FLAlertLayerProtocol* delegate;
    FLAlertLayer* fr;
    char const* title;
    std::string desc;
    char const* btn1;
    char const* btn2;
    CCObject* button2;
    
  };
  bool init(FLAlertLayerProtocol *p0, char const *p1, gd::string p2, char const *p3, char const *p4, float p5, bool p6, float p7, float p8) {
    p0 = new FLAlertLayerProtocol;
    m_fields->delegate = p0;
    
    m_fields->title = p1;
    m_fields->desc = p2;
    m_fields->btn1 = p3;
    m_fields->btn2 = p4;
    m_fields->button2 = this;
    return FLAlertLayer::init(p0, p1, p2, p3, p4, p5, p6, p7, p8);
  }
  
  void show() {
    FLAlertLayer::show();
    bool isbtn2 = false;
    NSString* btn2;
    if (m_fields->title) {
      auto alert = static_cast<FLAlertLayer*>(FLAlertLayer::create(m_fields->delegate, m_fields->title, m_fields->desc, m_fields->btn1, m_fields->btn2));
    //if ([NSString stringWithUTF8String:m_fields->title] != [NSNull null]) {
      NSString* title = [NSString stringWithUTF8String:m_fields->title];
      NSString* desc = [NSString stringWithUTF8String:m_fields->desc.c_str()];
      NSString* btn1 = [NSString stringWithUTF8String:m_fields->btn1];
      /*CCDirector* director = CCDirector::sharedDirector();
      auto scene = director->getRunningScene();
      auto FLAlert = scene->getChildByIDRecursive("FLAlertLayer");
      auto FLAlert1 = typeinfo_cast<FLAlertLayer*>(FLAlert);
      if (FLAlert1) {
        auto mainlayer = FLAlert->getChildByIDRecursive("main-layer");
        auto mainmenu = mainlayer->getChildByIDRecursive("main-menu");
        button2 = mainmenu->getChildByIDRecursive("button-2");
      }*/
      if (m_fields->btn2) {
        isbtn2 = true;
        btn2 = [NSString stringWithUTF8String:m_fields->btn2];
      }
      
      //NSLog(@"silly %s", m_fields->delegate);
      //NSLog(@"silly %s", m_fields->fr);
      showAlert(title, desc, btn1, isbtn2, btn2, m_fields->delegate, alert, m_fields->button2);
      return;
    }
    FLAlertLayer::show();
    return;
  }
};
