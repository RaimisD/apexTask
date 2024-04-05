trigger addPrimaryContact on Contact (after insert) {
    for(Contact addedContact : Trigger.new){
        if(addedContact.Level__c == 'Primary'){
            List<Case> relatedCases = new List<Case>();
            relatedCases = [SELECT Id, AccountId, ContactId FROM Case WHERE AccountId =: addedContact.AccountId AND ContactId = NULL];
            for(Case emptyCont : relatedCases){
                emptyCont.ContactId = addedContact.Id;
                update emptyCont;
            }
        }
    }
}