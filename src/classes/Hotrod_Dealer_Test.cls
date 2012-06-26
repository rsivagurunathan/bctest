@isTest(seeAllData=false)
public class Hotrod_Dealer_Test{
    @isTest(seeAllData=false)
    public static void new_contact_test() {
    	Account a = new Account(Name = 'TEST', Asset_Generated__c = true, SAP_ID__c = '9232323', External_Id__c = '1234567890', Phone = '01329874953', BillingCity = 'BillingCity', BillingStreet = 'BillingStreet', BillingPostalCode = 'BillingPostalCode');
        Database.insert(a);
        Contact c = new Contact(FirstName = 'FirstName', Phone = '01329874953', LastName = 'LastName', AccountID = a.Id, email = 'test@test.com', primary_contact__c = true);
        Database.insert(c);

        c.email = 'test2@test.com';
        Database.update(c);

        c.FirstName = 'test2';
        Database.update(c);
    }
}