public with sharing class ContactClass {

    // Rollup Contact count to Account on any add, delete or transfer of Contact
    // Meant to be called from a trigger.
    public static void rollupContactCount(List<Contact> contactsNew, Map<Id, Contact> contactsOld) {
        Set<Id> accountIds = new Set<Id>();

        for (Contact c : contactsNew) {
            if ((contactsOld != null) && contactsOld.containsKey(c.Id)) {
                if (c.AccountId != contactsOld.get(c.Id).AccountId) {
                    // Represents Updates
                    accountIds.add(c.AccountId);
                    accountIds.add(contactsOld.get(c.Id).AccountId);
                }
            } else {    
                // Represents Inserts, Deletes and Undeletes
                accountIds.add(c.AccountId);
            }
        }
        
        if (!accountIds.isEmpty()) {
            List<Account> accounts = new List<Account>();  
            for (Account a : [select Id, Contact_Count__c, 
                                     (select Id, AccountId 
                                        from Contacts) 
                                from Account 
                               where Id in :accountIds]) {

                Integer contactCount = 0;
                for (Contact c : a.Contacts) {
                    contactCount++;
                }
                accounts.add(new Account(Id = a.Id, Contact_Count__c = contactCount));
            }
            if (!accounts.isEmpty()) Database.update(accounts);
        }
    }

    // ************** Example Two **************
  
    // @TestVisible
    // private static List<Account> modifiedAccounts { 
    //     get {
    //         if (modifiedAccounts == null) modifiedAccounts = new List<Account>();
    //         return modifiedAccounts;
    //     }
    //     private set; 
    // }

    // // Rollup Contact count to Account on any add, delete or transfer of Contact
    // // Meant to be called from a trigger.
    // public static void rollupContactCount(List<Contact> contactsNew, Map<Id, Contact> contactsOld) {
    //     Set<Id> accountIds = getModifiedContacts(contactsNew, contactsOld);

    //     List<Account> modAccounts = getModifiedAccounts(accountIds);
        
    //     List<Account> updatedAccounts = doContactRollup(modAccounts);

    //     updateAccounts(updatedAccounts);

    //     modifiedAccounts = null;
    // }    

    // @TestVisible
    // private static Set<Id> getModifiedContacts(List<Contact> contactsNew, Map<Id, Contact> contactsOld) { 
    //     Set<Id> accountIds = new Set<Id>();

    //     for (Contact c : contactsNew) {
    //         if ((contactsOld != null) && contactsOld.containsKey(c.Id)) {
    //             if (c.AccountId != contactsOld.get(c.Id).AccountId) {
    //                 // Represents Updates
    //                 accountIds.add(c.AccountId);
    //                 accountIds.add(contactsOld.get(c.Id).AccountId);
    //             }
    //         } else {    
    //             // Represents Inserts, Deletes and Undeletes
    //             accountIds.add(c.AccountId);
    //         }
    //     }
    //     return accountIds;
    // }

    // @TestVisible
    // private static List<Account> getModifiedAccounts(Set<Id> accountIds) { 
    //     if (modifiedAccounts.isEmpty() && !accountIds.isEmpty()) {

    //         modifiedAccounts = [select Id, Contact_Count__c, 
    //                                  (select Id, AccountId 
    //                                     from Contacts) 
    //                             from Account 
    //                            where Id in :accountIds];
    //     }
    //     return modifiedAccounts;
    // }    

    // @TestVisible
    // private static List<Account> doContactRollup(List<Account> modifiedAccounts) { 
    //     List<Account> updAccounts = new List<Account>();
    //     for (Account a : modifiedAccounts) {
    //         Integer contactCount = 0;
    //         for (Contact c : a.Contacts) {
    //             contactCount++;
    //         }
    //         updAccounts.add(new Account(Id = a.Id, Contact_Count__c = contactCount));
    //     }
    //     return updAccounts;
    // }

    // private static void updateAccounts(List<Account> accounts) {       
    //     if (!accounts.isEmpty()) Database.update(accounts);
    // }

    // ************** Example Three **************
    
    // @TestVisible
    // private static List<Account> modifiedAccounts { 
    //     get {
    //         if (modifiedAccounts == null) modifiedAccounts = new List<Account>();
    //         return modifiedAccounts;
    //     }
    //     private set; 
    // }

    // // Rollup Contact count to Account on any add, delete or transfer of Contact
    // // Meant to be called from a trigger.
    // public static void rollupContactCount(List<Contact> contactsNew, Map<Id, Contact> contactsOld) {
    //     Set<Id> accountIds = getModifiedContacts(contactsNew, contactsOld);

    //     List<Account> modAccounts = getModifiedAccounts(accountIds);
        
    //     List<Account> updatedAccounts = doContactRollup(modAccounts);

    //     Boolean success = updateAccounts(updatedAccounts);

    //     modifiedAccounts = null;
    // }

    // @TestVisible
    // private static Set<Id> getModifiedContacts(List<Contact> contactsNew, Map<Id, Contact> contactsOld) { 
    //     Set<Id> accountIds = new Set<Id>();

    //     for (Contact c : contactsNew) {
    //         if ((contactsOld != null) && contactsOld.containsKey(c.Id)) {
    //             if (c.AccountId != contactsOld.get(c.Id).AccountId) {
    //                 // Represents Updates
    //                 accountIds.add(c.AccountId);
    //                 accountIds.add(contactsOld.get(c.Id).AccountId);
    //             }
    //         } else {    
    //             // Represents Inserts, Deletes and Undeletes
    //             accountIds.add(c.AccountId);
    //         }
    //     }
    //     return accountIds;
    // }

    // @TestVisible
    // private static List<Account> getModifiedAccounts(Set<Id> accountIds) { 
    //     if (modifiedAccounts.isEmpty() && !accountIds.isEmpty()) {

    //         modifiedAccounts = [select Id, Contact_Count__c, 
    //                                  (select Id, AccountId 
    //                                     from Contacts) 
    //                             from Account 
    //                            where Id in :accountIds];
    //     }
    //     return modifiedAccounts;
    // }

    // @TestVisible
    // private static List<Account> doContactRollup(List<Account> modifiedAccounts) { 
    //     List<Account> updAccounts = new List<Account>();
    //     for (Account a : modifiedAccounts) {
    //         Integer contactCount = 0;
    //         for (Contact c : a.Contacts) {
    //             contactCount++;
    //         }
    //         updAccounts.add(new Account(Id = a.Id, Contact_Count__c = contactCount));
    //     }
    //     return updAccounts;
    // }

    // @TestVisible
    // private static DmlInterface dmlTool {
    //     get {
    //         if (dmlTool == null) dmlTool = new DmlClass();
    //         return dmlTool;
    //     }
    //     private set;
    // }

    // @TestVisible
    // private static Boolean updateAccounts(List<Account> accounts) {       
    //     if (!accounts.isEmpty()) {
    //         return dmlTool.updateSObj(accounts);
    //     }
    //     return false;
    // }
}