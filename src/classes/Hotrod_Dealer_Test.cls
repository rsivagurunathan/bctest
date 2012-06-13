@isTest(seeAllData=false)
public class Hotrod_Dealer_Test{
    @isTest(seeAllData=false)
    public static void new_contact_test() {
    	Account a = new Account(Name = 'TEST', BillingCity = 'BillingCity', BillingStreet = 'BillingStreet', BillingPostalCode = 'BillingPostalCode');
        Database.insert(a);
        Contact c = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountID = a.Id, email = 'test@test.com', primary_contact__c = true);
        Database.insert(c);
    }
}