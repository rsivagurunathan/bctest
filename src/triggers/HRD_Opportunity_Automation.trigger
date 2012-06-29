trigger HRD_Opportunity_Automation on Opportunity (after update, after insert) {
    
    //Create New Contracts
    List<Contract> contracts = new List<Contract>();
    List<Opportunity> opps = new List<Opportunity>();
    for(Opportunity o : [SELECT Id, Name, Existing_Contract__c, StageName, Account.BillingStreet, Account.BillingCity, Account.BillingPostalCode, Account.BillingState, Account.BillingCountry, OwnerId, QuoteBeginDate__c, QuoteEndDate__c, AccountId FROM Opportunity WHERE Id IN :Trigger.New]){
        if(o.StageName == 'Contract Signed' && !o.Existing_Contract__c){
            
            Contract c =  new Contract();
            c.StartDate = o.QuoteBeginDate__c;
            //c.EndDate = o.QuoteEndDate__c;
            c.OwnerId = o.OwnerId;
            c.BillingStreet = o.Account.BillingStreet;
            c.BillingCity = o.Account.BillingCity;
            c.BillingPostalCode = o.Account.BillingPostalCode;
            c.BillingState = o.Account.BillingState;
            c.BillingCountry = o.Account.BillingCountry;
            c.ContractTerm = 12;
            c.AccountId = o.AccountId;
            
            contracts.add(c);
            o.Existing_Contract__c = true;
            opps.add(o);
        }
    }
    
    if(!contracts.isEmpty()){
        insert contracts;
    }
    if(!opps.isEmpty()){
        update opps;
    }
}