var $ul = $('#accountList');
var account = new SObjectModel.Account();
account.retrieve(
    {
        orderby: [{LastModifiedDate: 'DESC'}], 
        limit: 10
    }, 
    handleResponse
);
$ul.on('click', navigate);
    
function handleResponse (error, records) {
    if (error) {
        alert(error.message);
    } else {
        var html = '';
        records.forEach(function(record) {
            html = html + "<li><a data-id=" + record.get("Id") + ">" + 
                record.get("Name") + "</a></li>";
        });
        $ul.html(html);
	}
}

function navigate(event){
	var id = event.target.getAttribute('data-id');
	sforce.one.navigateToSObject(id);
}