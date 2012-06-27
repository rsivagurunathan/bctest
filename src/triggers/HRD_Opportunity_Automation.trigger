trigger HRD_Opportunity_Automation on Opportunity (after update, after insert) {
    
    //Create New Contracts
    List<Contract> contracts = new List<Contract>();
    List<Opportunity> opps = new List<Opportunity>();
    for(Opportunity o : [SELECT Id, Name, Existing_Contract__c, StageName, Account.BillingCity, OwnerId, QuoteBeginDate__c, QuoteEndDate__c, AccountId FROM Opportunity WHERE Id IN :Trigger.New]){
        if(o.StageName == 'Contract Signed' && !o.Existing_Contract__c){
            
            Contract c =  new Contract();
            c.StartDate = o.QuoteBeginDate__c;
            //c.EndDate = o.QuoteEndDate__c;
            c.OwnerId = o.OwnerId;
            c.BillingCity = o.Account.BillingCity;
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