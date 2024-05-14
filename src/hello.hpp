using namespace geode::prelude;
class testAlertProtocol : public FLAlertLayerProtocol {

public:

	void FLAlert_Clicked(FLAlertLayer* ok, bool btn2) {
		if (btn2) {
			FLAlertLayerProtocol::FLAlert_Clicked(ok, btn2);
		}
	};

};

#endif
