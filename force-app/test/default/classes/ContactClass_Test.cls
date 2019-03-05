@isTest(SeeAllData = false)
public with sharing class ContactClass_Test {

    // Use with ContactClass00, 1, 2 
    @isTest(SeeAllData = false)
    static void testRollupContactCount() {
        Account a0 = new Account(Name = 'Test - 0');
        Database.insert(a0);

        Account a1 = new Account(Name = 'Test - 1');
        Database.insert(a1);

        Contact c0 = new Contact(
            FirstName = 'TestFirst',
            LastName = 'TestLast - 0',
            AccountId = a0.Id
        );
        Contact c1 = new Contact(
            FirstName = 'TestFirst',
            LastName = 'TestLast - 1',
            AccountId = a0.Id
        );        

        Test.startTest();
            System.assertEquals(0, [select Contact_Count__c from Account where Id = :a0.Id limit 1].Contact_Count__c);
            
            Database.insert(c0);
            System.assertEquals(1, [select Contact_Count__c from Account where Id = :a0.Id limit 1].Contact_Count__c);
            
            Database.insert(c1);
            System.assertEquals(2, [select Contact_Count__c from Account where Id = :a0.Id limit 1].Contact_Count__c);

            c1.AccountId = a1.Id;
            Database.update(c1);
            System.assertEquals(1, [select Contact_Count__c from Account where Id = :a0.Id limit 1].Contact_Count__c);
            System.assertEquals(1, [select Contact_Count__c from Account where Id = :a1.Id limit 1].Contact_Count__c);          

            Database.delete(c0);
            System.assertEquals(0, [select Contact_Count__c from Account where Id = :a0.Id limit 1].Contact_Count__c);

            Database.undelete(c0);
            System.assertEquals(1, [select Contact_Count__c from Account where Id = :a0.Id limit 1].Contact_Count__c);
        Test.stopTest();
    }

    /* ********************************* Example 2 ********************************* */
    
    // // Use with ContactClass01, 2
    // @isTest(SeeAllData = false)
    // static void testGetModifiedContacts() {
    //     Set<Id> acctIds = new Set<Id>();

    //     String jsonContStr = '[{"attributes":{"type":"Contact","url":"/services/data/v42.0/sobjects/Contact/003f400000LBeTz"},"Id":"003f400000LBeTzAAL","FirstName":"TestFirst","LastName":"TestLast - 0","AccountId":"001f400000NDHZZAA5"}]';
    //     List<Contact> contacts = (List<Contact>)JSON.deserialize(jsonContStr, List<Contact>.class);

    //     // New, Delete and Undelete Contact test
    //     acctIds = ContactClass.getModifiedContacts(contacts, null);
    //     System.assertEquals(1, acctIds.size());

    //     // Update Contact test
    //     Map<Id, Contact> oldContacts = new Map<Id, Contact>(contacts);

    //     List<Contact> contactsChg = (List<Contact>)JSON.deserialize(jsonContStr, List<Contact>.class);
    //     contactsChg[0].AccountId = '001f400000NDHZZ000';

    //     acctIds = ContactClass.getModifiedContacts(contactsChg, oldContacts);
    //     System.assertEquals(2, acctIds.size());
    //     System.assert(acctIds.contains('001f400000NDHZZ000'));
    // }

    // @isTest(SeeAllData = false)
    // static void testDoContactRollup() {

    //     String jsonAcctStr = '[{"attributes":{"type":"Account","url":"/services/data/v42.0/sobjects/Account/001f400000NDHZZAA5"},"Id":"001f400000NDHZZAA5","Contact_Count__c":2,"Contacts":{"totalSize":2,"done":true,"records":[{"attributes":{"type":"Contact","url":"/services/data/v42.0/sobjects/Contact/003f400000LBeTzAAL"},"AccountId":"001f400000NDHZZAA5","Id":"003f400000LBeTzAAL"},{"attributes":{"type":"Contact","url":"/services/data/v42.0/sobjects/Contact/003f400000LBeU0AAL"},"AccountId":"001f400000NDHZZAA5","Id":"003f400000LBeU0AAL"}]}}]';
    //     List<Account> accounts = (List<Account>)JSON.deserialize(jsonAcctStr, List<Account>.class);

    //     List<Account> updAccounts = ContactClass.DoContactRollup(accounts);
    //     System.assertEquals(2, updAccounts[0].Contact_Count__c);
    // }

    // @isTest(SeeAllData = false)
    // static void testModifiedAccounts() {

    //     String jsonAcctStr = '[{"attributes":{"type":"Account","url":"/services/data/v42.0/sobjects/Account/001f400000NDHZZAA5"},"Id":"001f400000NDHZZAA5","Contact_Count__c":2,"Contacts":{"totalSize":2,"done":true,"records":[{"attributes":{"type":"Contact","url":"/services/data/v42.0/sobjects/Contact/003f400000LBeTzAAL"},"AccountId":"001f400000NDHZZAA5","Id":"003f400000LBeTzAAL"},{"attributes":{"type":"Contact","url":"/services/data/v42.0/sobjects/Contact/003f400000LBeU0AAL"},"AccountId":"001f400000NDHZZAA5","Id":"003f400000LBeU0AAL"}]}}]';
    //     List<Account> accounts = (List<Account>)JSON.deserialize(jsonAcctStr, List<Account>.class);

    //     List<Account> modAccounts = ContactClass.modifiedAccounts = accounts;
    //     System.assertEquals(1, modAccounts.size());
    //     System.assertEquals(accounts[0].Id, modAccounts[0].Id);
    // }

    // /* ********************************* Example 3 ********************************* */
    // // Use with ContactClass02
    // @isTest(SeeAllData = false)
    // static void testUpdateAccounts() {
    //     System.assertEquals(false, ContactClass.UpdateAccounts(new List<Account>()));

    //     DmlClassMock dmlTool = new DmlClassMock();
        
    //     dmlTool.rtnVal = true;
    //     ContactClass.dmlTool = dmlTool;

    //     List<Account> accounts = new List<Account> { new Account(Id = '001000000000000', Contact_Count__c = 1) };
    //     System.assertEquals(true, ContactClass.UpdateAccounts(accounts));

    //     dmlTool.rtnVal = false;
    //     ContactClass.dmlTool = dmlTool;
    //     System.assertEquals(false, ContactClass.UpdateAccounts(accounts));
    // }

}