var canPublish = this.ForceUI.UserUITheme === "Theme4t"; 
	 
if (canPublish) {
	Sfdc.canvas.publisher.subscribe({name: "publisher.showPanel",
        onData:function(e) {
            Sfdc.canvas.publisher.publish({name:"publisher.setValidForSubmit", payload:"true"});
    }});
    Sfdc.canvas.publisher.subscribe({ name: "publisher.post",
        onData: function(e) {
            createAccount();
            closePublisherPanel();
    	}
    }); 
} 

function createAccount() {
    new SObjectModel.Account().create({
    	Name: $('#accountName').val()}, 
    	responseHandler
    );

	function responseHandler(error, records){
	    if (error) {
	        alert(error.message);
	    }
	    else {
	    	if (!canPublish || !sforce) {
		        navigateToAccount(records[0]);
	    	}
        }
    }
	
	function navigateToAccount(id) {
        try {
            sforce.one.navigateToSObject(id);
    	}
        catch(e){
            window.location = '/' + id;
        }
	}
    
    function closePublisherPanel() {
    	Sfdc.canvas.publisher.publish({
    		name: 'publisher.close',
    		payload: {refresh: 'true'}
    	});
    }
}