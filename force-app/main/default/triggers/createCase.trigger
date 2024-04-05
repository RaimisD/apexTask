trigger createCase on Account (after insert) {
    for(Account accRecord : Trigger.new){
        Case newCase = new Case();
        newCase.AccountId = accRecord.Id;
        newCase.OwnerId = accRecord.OwnerId;
        newCase.Origin = 'System';
        newCase.Priority = accRecord.CustomerPriority__c;
        newCase.Subject = accRecord.Name + ' - Onboarding';
        insert newCase;
    }
}