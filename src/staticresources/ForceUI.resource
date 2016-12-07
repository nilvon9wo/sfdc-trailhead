(function(vfContext){
	vfContext.ForceUI = vfContext.ForceUI || {};
	
	vfContext.ForceUI.isSalesforceClassic = function(){
		return (this.UserUITheme == 'Theme3');
	}

	vfContext.ForceUI.isLightningExperience = function(){
		return (this.UserUITheme == 'Theme4d');
	}

	vfContext.ForceUI.isSalesforce1 = function(){
		return (this.UserUITheme == 'Theme4t');
	}
})(this);
