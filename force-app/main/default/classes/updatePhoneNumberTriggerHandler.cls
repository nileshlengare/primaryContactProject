public with sharing class updatePhoneNumberTriggerHandler {
    public static void preventCreatePrimaryContactOnAccout(List<Contact> contactList) {
       // List<Contact> contactList = new List<Contact>();
       //List<Account> acc = new List<Account>();
        Set<Id> accountIdSet = new Set<Id>();
        Map<Id, Contact> accountIdContactmap = new Map<Id, Contact>();
        for (Contact contactObject : contactList) {
            if(contactObject.isPrimary__c==true && contactObject.AccountId!=null){
                accountIdSet.add(contactObject.AccountId);
            }
            if(accountIdSet!=null && accountIdSet.size()>0){
                for (Contact contObj : [Select id,isPrimary__c,AccountId from Contact where AccountId in : accountIdSet and isPrimary__c=true]) {
                    accountIdContactmap.put(contObj.AccountId,contObj);
                }
                for (Contact contactObj : contactList) {
                    if(contactObj.isPrimary__c==true && contactObj.AccountId!=null && accountIdContactmap.get(contactObj.AccountId)!=null){
                        contactObj.addError('You cannot create more than one primary contact on same Account');
                    } 
                }
            }
        }
    }

    public static void preventCreatePrimaryContactOnAccoutUpdate(Map<Id, Contact> contactNewMap,Map<Id, Contact> contactOldMap){
        Set<Id> accountIdSet = new Set<Id>();
        Map<Id, Contact> accountIdContactmap = new Map<Id, Contact>();
        for (Contact contactObject : contactNewMap.values()) {
            if(contactNewMap.get(contactObject.Id).isPrimary__c!=contactOldMap.get(contactObject.Id).isPrimary__c &&   contactNewMap.get(contactObject.id).isPrimary__c==true && contactNewMap.get(contactObject.Id).AccountId!=null){
                accountIdSet.add(contactNewMap.get(contactObject.Id).AccountId);
            }
        }
        if(accountIdSet!=null && accountIdSet.size()>0){
            for (Contact contObj : [Select id,isPrimary__c,AccountId from Contact where AccountId in : accountIdSet and isPrimary__c=true]) {
                accountIdContactmap.put(contObj.AccountId,contObj);
            }
            for (Contact contactObject : contactNewMap.values()) {
                if(contactNewMap.get(contactObject.Id).isPrimary__c!=contactOldMap.get(contactObject.Id).isPrimary__c 
                    &&   contactNewMap.get(contactObject.id).isPrimary__c==true 
                    && contactNewMap.get(contactObject.Id).AccountId!=null 
                    && accountIdContactmap.get(contactNewMap.get(contactObject.id).AccountId)!=null){
                    contactObject.addError('You cannot create more than one primary contact on same Account');
                }
            }
        }
    }
}
