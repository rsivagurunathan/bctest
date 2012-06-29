public class Hotrod_GForce{
    
    public Hotrod_GForce(){
    	
    }

    public void new_dealer(Id account_id){

    	//Contact Details
    	String name = 'None';
    	String phone = 'None';

    	//Get Account
        Account account = [SELECT Id, External_ID__c, Parent_Account_ID__c, Status__c, Phone, Website, Email__c, Name, Account_ID__c, BillingCity, BillingState, BillingStreet ,BillingPostalCode, BillingCountry FROM Account WHERE Id = :account_id];
        try{
        	Contact_Function__c contact = [SELECT Id, Contact_Name__r.FirstName, Contact_Name__r.LastName, Contact_Name__r.Phone FROM Contact_Function__c WHERE Account_Name__c = :account_id AND Function__c = 'Technical Contact'];
    		name = contact.Contact_Name__r.FirstName + ' ' + contact.Contact_Name__r.LastName;
    		phone = contact.Contact_Name__r.Phone;
    	}catch(exception e){
    		system.debug(e);
    	}

    	Messaging.reserveSingleEmailCapacity(2);
    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

    	String[] toAddresses = new String[] {'newsinternational@gforces.co.uk'}; 
		String[] ccAddresses = new String[] {'newsinternational@gforces.co.uk'};

		mail.setToAddresses(toAddresses);
		mail.setCcAddresses(ccAddresses);
		mail.setReplyTo('hotrod@newsint.com');
		mail.setSenderDisplayName('Hotrod');
		mail.setSubject('Hotrod Dealer New');
		mail.setHtmlBody(
			'<b>Dealer Status: ' + account.Status__c + '</b><br/>' +
			'Dealer name: ' + account.Name + '<br/>' +
			'External ID: ' + account.External_ID__c + '<br/>' +
			'Account Dealer ID: ' + account.Id + '<br/>' +
			'Parent Account ID: ' + account.Parent_Account_ID__c + '<br/><br/>' +
			'Children Accounts: ' + 'Related Account List' + '<br/><br/>' +
			'Dealer address details : ' + '<br/>' +
			account.BillingStreet + '<br/>' +
			account.BillingCity + '<br/>' +
			account.BillingPostalCode + '<br/>' +
			account.BillingState + '<br/>' +
			account.BillingCountry + '<br/><br/>' +
			'Phone: ' + account.Phone + '<br/><br/>' +
			'Technical Contact Name: ' + name + '<br/>' +
			'Technical Contact Phone: ' + phone + '<br/>'

		);

     	//Send Email To GForce
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }

    public void update_dealer(Id account_id){

    	//Contact Details
    	String name = 'None';
    	String phone = 'None';

    	//Get Account
        Account account = [SELECT Id, External_ID__c, Parent_Account_ID__c, Status__c, Phone, Website, Email__c, Name, Account_ID__c, BillingCity, BillingState, BillingStreet ,BillingPostalCode, BillingCountry FROM Account WHERE Id = :account_id];
        try{
        	Contact_Function__c contact = [SELECT Id, Contact_Name__r.FirstName, Contact_Name__r.LastName, Contact_Name__r.Phone FROM Contact_Function__c WHERE Account_Name__c = :account_id AND Function__c = 'Technical Contact'];
    		name = contact.Contact_Name__r.FirstName + ' ' + contact.Contact_Name__r.LastName;
    		phone = contact.Contact_Name__r.Phone;
    	}catch(exception e){
    		system.debug(e);
    	}

    	Messaging.reserveSingleEmailCapacity(2);
    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

    	String[] toAddresses = new String[] {'newsinternational@gforces.co.uk'}; 
		String[] ccAddresses = new String[] {'richard.ozols@makepositive.com'};

		mail.setToAddresses(toAddresses);
		mail.setCcAddresses(ccAddresses);
		mail.setReplyTo('hotrod@newsint.com');
		mail.setSenderDisplayName('Hotrod');
		mail.setSubject('Hotrod Dealer Update');
		mail.setHtmlBody(
			'<b>Dealer Status: ' + account.Status__c + '</b><br/>' +
			'Dealer name: ' + account.Name + '<br/>' +
			'External ID: ' + account.External_ID__c + '<br/>' +
			'Account Dealer ID: ' + account.Id + '<br/>' +
			'Parent Account ID: ' + account.Parent_Account_ID__c + '<br/><br/>' +
			'Children Accounts: ' + 'Related Account List' + '<br/><br/>' +
			'Dealer address details : ' + '<br/>' +
			account.BillingStreet + '<br/>' +
			account.BillingCity + '<br/>' +
			account.BillingPostalCode + '<br/>' +
			account.BillingState + '<br/>' +
			account.BillingCountry + '<br/><br/>' +
			'Phone: ' + account.Phone + '<br/><br/>' +
			'Technical Contact Name: ' + name + '<br/>' +
			'Technical Contact Phone: ' + phone + '<br/>'

		);

     	//Send Email To GForce
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }
}