public with sharing class TH_ForceUIVFExtension {

    public TH_ForceUIVFExtension(ApexPages.StandardController controller) {
    }
    
    public String getContextUserUiTheme(){
        return UserInfo.getUiTheme();
    }

    public String getContextUserUiThemeDisplayed(){
        return UserInfo.getUiThemeDisplayed();
    }
}