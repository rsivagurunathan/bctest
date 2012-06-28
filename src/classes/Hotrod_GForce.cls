public class Hotrod_GForce{
    
    public Hotrod_GForce(){
    	
    }

    public void new_dealer(Id account_id){

    	//Get Account
        Account account = [SELECT Id, External_ID__c, Parent_Account_ID__c, Phone, Website, Email__c, Name, Account_ID__c, BillingCity, BillingState, BillingStreet ,BillingPostalCode, Status__c FROM Account WHERE Id = :account_id];

    	Messaging.reserveSingleEmailCapacity(2);
    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

    	String[] toAddresses = new String[] {'newsinternational@gforces.co.uk'}; 
		String[] ccAddresses = new String[] {'richard.ozols@makepositive.com'};

		mail.setToAddresses(toAddresses);
		mail.setCcAddresses(ccAddresses);
		mail.setReplyTo('hotrod@newsint.com');
		mail.setSenderDisplayName('Hotrod');
		mail.setSubject('Hotrod Dealer');
		mail.setHtmlBody(
			'Dealer name: ' + account.Name + '<br/>' +
			'External ID: ' + account.External_ID__c + '<br/>' +
			'Account Dealer ID: ' + account.Id + '<br/>' +
			'Parent Account ID: ' + account.Parent_Account_ID__c + '<br/><br/>' +
			'Children Accounts: ' + 'Related Account List' + '<br/><br/>' +
			'Dealer address details : ' + '<br/>' +
			account.BillingCity + '<br/>' +
			account.BillingPostalCode + '<br/>' +
			account.BillingState + '<br/>' +
			account.BillingCountry + '<br/><br/>' +
			'Phone: ' + account.Phone + '<br/><br/>' +
			'Technical Contact Name: ' + 'Rich' + '<br/>' +
			'Technical Contact Phone: ' + '1234567890' + '<br/>'

		);

     	//Send Email To GForce
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }

    public void update_dealer(Id account_id){



    }
}