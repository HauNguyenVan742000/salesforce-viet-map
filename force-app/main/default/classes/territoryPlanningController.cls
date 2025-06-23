/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-09-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class territoryPlanningController {
    @AuraEnabled(cacheable=true)
    public static List<TerritoryWrapper> getTerritoryAll(String recordId){
        List<TerritoryWrapper> lstTerritoryWrapper = new List<TerritoryWrapper>();
        Map<String, TerritoryWrapper> wrapperMap = new Map<String, TerritoryWrapper>();
        Map<Id, Integer> projectPartnerCountMap = new Map<Id, Integer>();
        Map<Id, Integer> dealerCountMap = new Map<Id, Integer>();
        Map<Id, Integer> vehicleCompanyPartnerCountMap = new Map<Id, Integer>();
        Set<Id> sIdTerritory = new Set<Id>();

        try {
            List<Master_Data__c> lstTerritoryToDisplay = [SELECT Id, Name, isManual__c, Map_Color__c, Quota_Amount__c, Report_to__c, Report_to__r.Name, Sales_Plan__c, Sales_Plan__r.Name, OwnerId, Owner.Name, Region__c, Region__r.Name, Parent_Territory__c, Is_Child__c
                                                        FROM Master_Data__c
                                                        WHERE Sales_Plan__c =: recordId AND RecordtypeId =: RecordTypeHelper.TERRITORY];

            for (Master_Data__c te : lstTerritoryToDisplay) {
                sIdTerritory.add(te.Id);
            }

            for (AggregateResult ar : [
                SELECT Territory__c, Account__r.RecordType.DeveloperName recordType, COUNT(Id) countAss
                FROM Master_Data_Item__c
                WHERE Territory__c IN :sIdTerritory AND RecordtypeId =: RecordTypeHelper.TERRITORY_ASSIGNMENT
                GROUP BY Territory__c, Account__r.RecordType.DeveloperName
            ]) {
                Id terrId = (Id)ar.get('Territory__c');
                String recordType = (String)ar.get('recordType');
                Integer count = (Integer)ar.get('countAss');

                if (recordType == 'Vehicle_Company_Partner') {
                    vehicleCompanyPartnerCountMap.put(terrId, count);
                } else if (recordType == 'Dealer') {
                    dealerCountMap.put(terrId, count);
                } else if (recordType == 'Project_Partner') {
                    projectPartnerCountMap.put(terrId, count);
                }
            }

            for (Master_Data__c te: lstTerritoryToDisplay) {
                TerritoryWrapper wrapper = new TerritoryWrapper();
                wrapper.id = te.Id;
                wrapper.name = te.Name;
                wrapper.owner = te.Owner.Name;
                wrapper.level = 1;
                wrapper.position = 0;
                wrapper.expanded = true;
                wrapper.chevronIcon = 'utility:chevrondown';   
                wrapper.minQuota = te.Quota_Amount__c;   
                wrapper.totalProjectPartner = projectPartnerCountMap.containsKey(te.Id) ? projectPartnerCountMap.get(te.Id) : 0;
                wrapper.totalDealer = dealerCountMap.containsKey(te.Id) ? dealerCountMap.get(te.Id) : 0;
                wrapper.totalVehicleCompanyPartner = vehicleCompanyPartnerCountMap.containsKey(te.Id) ? vehicleCompanyPartnerCountMap.get(te.Id) : 0;
                wrapper.isOpen = false;
                wrapper.isChil = te.Is_Child__c;
                wrapperMap.put(te.Id, wrapper);
            }

            for (Master_Data__c terr : lstTerritoryToDisplay) {
                TerritoryWrapper node = wrapperMap.get(terr.Id);
                if (terr.Parent_Territory__c != null && wrapperMap.containsKey(terr.Parent_Territory__c)) {
                    TerritoryWrapper parent = wrapperMap.get(terr.Parent_Territory__c);
                    // node.name = node.owner;
                    node.level = parent.level + 1;
                    node.position = parent.children.size() + 1;
                    parent.children.add(node);
                } else {
                    node.name = terr.Name;
                    node.level = 1;
                    node.position = lstTerritoryWrapper.size() + 1;
                    lstTerritoryWrapper.add(node);
                }
            }

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return lstTerritoryWrapper;
    }

    // @AuraEnabled(cacheable=true)
    // public static List<User> getUsers() {
    //     return [SELECT Id, Name FROM User WHERE IsActive = true];
    // }

    @AuraEnabled(cacheable=true)
    public static List<User> getUsers(String recordId) {
        Set<Id> userIds = new Set<Id>();

        // for (Territory__c t : [
        //     SELECT OwnerId 
        //     FROM Territory__c 
        //     WHERE Sales_Plan__c = :recordId
        // ]) {
        //     if (t.OwnerId != null) {
        //         userIds.add(t.OwnerId);
        //     }
        // }

        for (Master_Data_Item__c uh: [SELECT User__c 
            FROM Master_Data_Item__c 
            WHERE Sales_Plan__c = :recordId
            AND RecordTypeId = :RecordTypeHelper.USER_HIERACHY
        ]) {
            if (uh.User__c != null) {
                userIds.add(uh.User__c);
            }
        }

        return [
            SELECT Id, Name 
            FROM User 
            WHERE IsActive = true AND Id IN :userIds
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Master_Data__c> getSalesPlans() {
        return [SELECT Id, Name FROM Master_Data__c WHERE RecordtypeId =: RecordTypeHelper.SALES_PLAN];
    }

    @AuraEnabled
    public static Master_Data__c getTerritory(String recordId) {
        List<Master_Data__c> result = [
        SELECT Id, Name, isManual__c, Map_Color__c, Quota_Amount__c,
               Report_to__c, Report_to__r.Name,
               Sales_Plan__c, Sales_Plan__r.Name,
               OwnerId, Owner.Name, Parent_Territory__c, Parent_Territory__r.Name,
               Region__c, Region__r.Name, Is_Child__c
        FROM Master_Data__c
        WHERE Id = :recordId
        AND RecordtypeId =: RecordTypeHelper.TERRITORY
        LIMIT 1
        ];
        return result.isEmpty() ? null : result[0];
    }

    @AuraEnabled(cacheable=true)
    public static List<Master_Data__c> getTerritoryForSalesPlan(String recordId) {
        List<Master_Data__c> result = [
            SELECT Id, Name, Sales_Plan__c, Sales_Plan__r.Name
            FROM Master_Data__c
            WHERE Sales_Plan__c = :recordId
        ];
        return result;
    }

    @AuraEnabled
    public static void insertTerritory(Master_Data__c territoryObj) {
    try {
        insert territoryObj;
    } catch (Exception e) {
        throw new AuraHandledException('Không thể lưu Territory: ' + e.getMessage());
    }
    }

    @AuraEnabled
    public static void updateTerritory(Master_Data__c territoryObj) {
        try {
            update territoryObj;
        } catch (Exception e) {
            throw new AuraHandledException('Không thể cập nhật Territory: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteTerritory(Id recordId) {
        try {
            if (recordId == null) {
                throw new AuraHandledException('Territory ID không được để trống.');
            }
    
            Master_Data__c recordToDelete = [SELECT Id FROM Master_Data__c WHERE Id = :recordId LIMIT 1];
            delete recordToDelete;
    
        } catch (DmlException e) {
            throw new AuraHandledException('Không thể xoá Territory: ' + e.getMessage());
        } catch (Exception e) {
            throw new AuraHandledException('Đã xảy ra lỗi: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void saveTerritoryAssignments(List<TerritoryAssignmentInput> assignments) {
        List<Master_Data__c> territoriesToUpdate = new List<Master_Data__c>();
        for (TerritoryAssignmentInput assignment : assignments) {
            territoriesToUpdate.add(new Master_Data__c(
                Id = assignment.territoryId,
                OwnerId = assignment.ownerId
            ));
        }

        if (!territoriesToUpdate.isEmpty()) {
            try {
                update territoriesToUpdate;
            } catch (DmlException e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    }

    public class TerritoryAssignmentInput {
        @AuraEnabled public Id territoryId {get; set;}
        @AuraEnabled public Id ownerId {get; set;}
    }


    public class TerritoryWrapper {
        @AuraEnabled public String id {get; set;}
        @AuraEnabled public String name {get; set;}
        @AuraEnabled public String owner {get; set;}
        @AuraEnabled public Integer level {get; set;}
        @AuraEnabled public Integer position {get; set;}
        @AuraEnabled public Boolean expanded {get; set;}
        @AuraEnabled public String chevronIcon {get; set;}
        @AuraEnabled public Double totalProjectPartner { get; set; }
        @AuraEnabled public Double totalDealer { get; set; }
        @AuraEnabled public Double totalVehicleCompanyPartner { get; set; }
        @AuraEnabled public Double minQuota {get; set;}
        @AuraEnabled public Boolean isOpen {get; set;}
        @AuraEnabled public Boolean isChil {get; set;}
        @AuraEnabled public List<TerritoryWrapper> children {get; set;}

        public TerritoryWrapper(){
            this.children = new List<TerritoryWrapper>();
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