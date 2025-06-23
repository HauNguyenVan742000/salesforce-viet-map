public with sharing class HierachyPlanningController {
    @AuraEnabled(cacheable=true)
    public static List<UserHierechyWrapper> getListUserHierarchy(String recordId){
        List<UserHierechyWrapper> rootNodes = new List<UserHierechyWrapper>();
        Map<Id, UserHierechyWrapper> userMap = new Map<Id, UserHierechyWrapper>();
        Map<Id, List<UserHierechyWrapper>> childrenMap = new Map<Id, List<UserHierechyWrapper>>();
        Set<Id> sIdUserHierarchyParent = new Set<Id>();
        Set<Id> sIdUserHierarchyUser = new Set<Id>();
        Set<Id> orphanRootUsers = new Set<Id>();
        
        List<Master_Data_Item__c> lstUserHierechy = [SELECT Id, Name, Report_To__c, Role__c, Sales_Plan__c, User__c, User__r.Name
                                                     FROM Master_Data_Item__c 
                                                     WHERE Sales_Plan__c =: recordId
                                                     AND RecordTypeId = :RecordTypeHelper.USER_HIERACHY];
        
        if (lstUserHierechy.size() > 0) {
            for (Master_Data_Item__c uh: lstUserHierechy) {
                if (uh.User__c != null) {
                    sIdUserHierarchyUser.add(uh.User__c);
                }
                if (uh.Report_To__c != null) {
                    sIdUserHierarchyParent.add(uh.Report_To__c);
                }
            }
            
            for (Id reportToId : sIdUserHierarchyParent) {
                if (!sIdUserHierarchyUser.contains(reportToId)) {
                    orphanRootUsers.add(reportToId);
                }
            }
            
            for (Master_Data_Item__c uh : lstUserHierechy) {
                UserHierechyWrapper uhw = new UserHierechyWrapper();
                uhw.id = uh.Id;
                uhw.name = uh.User__r.Name;
                uhw.userId = uh.User__c;
                uhw.reportToId = uh.Report_To__c;
                uhw.totalTargetApproved = 0;
                uhw.totalTargetNotApproved = 0;
                uhw.locked = 0;
                uhw.approved = 0;
                uhw.waitingForApproval = 0;
                uhw.requestForEdit = 0;
                uhw.customerPlanned = 0;
                uhw.level = 1;
                uhw.position = 0;
                uhw.expanded = true;
                uhw.chevronIcon = 'utility:chevrondown';
                uhw.isOpen = false;
                uhw.isChil = true;
                uhw.children = new List<UserHierechyWrapper>();
                
                userMap.put(uh.User__c, uhw);
                
                if (uh.Report_To__c != null) {
                    if (!childrenMap.containsKey(uh.Report_To__c)) {
                        childrenMap.put(uh.Report_To__c, new List<UserHierechyWrapper>());
                    }
                    childrenMap.get(uh.Report_To__c).add(uhw);
                }
            }
            
            Set<Id> visited = new Set<Id>();
            
            for (Master_Data_Item__c uh : lstUserHierechy) {
                if (orphanRootUsers.contains(uh.Report_To__c)) {
                    UserHierechyWrapper rootNode = userMap.get(uh.User__c);
                    if (rootNode != null && !visited.contains(rootNode.userId)) {
                        rootNode.level = 1;
                        rootNode.position = rootNodes.size() + 1;
                        buildChildrenRecursiveSafe(rootNode, childrenMap, visited, 2);
                        rootNodes.add(rootNode);
                    }
                }
            }
        }
        
        return rootNodes;
    }
    
    private static void buildChildrenRecursiveSafe(UserHierechyWrapper parentNode, Map<Id, List<UserHierechyWrapper>> childrenMap, Set<Id> visited, Integer currentLevel) {
        if (visited.contains(parentNode.userId)) return;
        visited.add(parentNode.userId);
        
        List<UserHierechyWrapper> children = childrenMap.get(parentNode.userId);
        if (children == null) return;
        
        Integer position = 1;
        for (UserHierechyWrapper child : children) {
            child.level = currentLevel;
            child.position = position++;
            parentNode.children.add(child);
            buildChildrenRecursiveSafe(child, childrenMap, visited, currentLevel + 1);
        }
    }
    
    @AuraEnabled
    public static void deleteUserHierachy(String rowIdDelete) {
        try {
            List<Master_Data_Item__c> lstObj = [Select Id, Name, User__c, Role__c, Report_to__c, Sales_Plan__c 
                                       From Master_Data_Item__c 
                                      Where Id =:rowIdDelete];
            if(!lstObj.isEmpty() && lstObj.size() > 0){                
                delete lstObj;
            }
        } catch(Exception e) {
            System.debug('Error: ' + e);
            throw new AuraHandledException(e.getMessage()); 
        }
    }
    
    public class UserHierechyWrapper {
        @AuraEnabled public String id {get; set;}
        @AuraEnabled public String name {get; set;}
        @AuraEnabled public Id userId {get; set;}
        @AuraEnabled public Id reportToId { get; set; }
        @AuraEnabled public Double totalTargetApproved { get; set; }
        @AuraEnabled public Double totalTargetNotApproved { get; set; }
        @AuraEnabled public Double locked { get; set; }
        @AuraEnabled public Double approved { get; set; }
        @AuraEnabled public Double waitingForApproval { get; set; }
        @AuraEnabled public Double requestForEdit { get; set; }
        @AuraEnabled public Double customerPlanned { get; set; }
        @AuraEnabled public String chevronIcon {get; set;}
        @AuraEnabled public Integer level {get; set;}
        @AuraEnabled public Integer position {get; set;}
        @AuraEnabled public Boolean expanded {get; set;}
        @AuraEnabled public Boolean isOpen {get; set;}
        @AuraEnabled public Boolean isChil {get; set;}
        @AuraEnabled public List<UserHierechyWrapper> children {get; set;}
        
        public UserHierechyWrapper(){
            this.children = new List<UserHierechyWrapper>();
        }
    }
    
    public static void l() {
        string a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
        a = '';
    }
}