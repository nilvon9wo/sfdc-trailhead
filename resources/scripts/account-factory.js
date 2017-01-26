function createAccount() {
    new SObjectModel.Account().create(
            {Name: $('#accountName').val()},
        responseHandler
    );

function responseHandler(error, records){
    if (error) {
        alert(error.message);
    }
    else {
        var id = records[0];
        try {
            sforce.one.navigateToSObject(id);
        }
        catch(e){
            window.location = '/' + id;
            }
        }
    }
}