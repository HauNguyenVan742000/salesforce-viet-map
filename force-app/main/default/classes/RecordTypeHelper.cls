public class RecordTypeHelper {
    // Order
    public static final String ORDER_DELIVARY_ORDER = Schema.SObjectType.Order.getRecordTypeInfosByDeveloperName()
        .get('Delivery_Order')
        .getRecordTypeId();
        
    public static final String ORDER_TRANSFER_ORDER = Schema.SObjectType.Order.getRecordTypeInfosByDeveloperName()
        .get('Transfer_Order')
        .getRecordTypeId();
        
    public static final String ORDER_PURSCHASE_ORDER = Schema.SObjectType.Order.getRecordTypeInfosByDeveloperName()
        .get('Purschase_Order')
        .getRecordTypeId();
    
    public static final String ORDER_SALES_ORDER = Schema.SObjectType.Order.getRecordTypeInfosByDeveloperName()
        .get('Sales_Order')
        .getRecordTypeId();
    
    // Inventory Transaction Header
    public static final String TRANSACTION_HEADER_IMPORT = Schema.SObjectType.Inventory_Transaction__c.getRecordTypeInfosByDeveloperName()
        .get('Import')
        .getRecordTypeId();
    
    // Inventory Transaction Header
    public static final String TRANSACTION_HEADER_EXPORT = Schema.SObjectType.Inventory_Transaction__c.getRecordTypeInfosByDeveloperName()
        .get('Export')
        .getRecordTypeId();
    
    // Inventory Transaction Header
    public static final String TRANSACTION_HEADER_TRANSFER = Schema.SObjectType.Inventory_Transaction__c.getRecordTypeInfosByDeveloperName()
        .get('Transfer')
        .getRecordTypeId();
    
    // Acount
    public static final String ACOUNT_DOI_TAC_DAI_LY = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName()
        .get('Dealer')
        .getRecordTypeId();

    // Master Data
    public static final String DISTRICT = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Address_District')
        .getRecordTypeId();

    public static final String PROVINCE = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Address_Province')
        .getRecordTypeId();

    public static final String WARD = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Address_Ward')
        .getRecordTypeId();
        
    public static final String ASSET_GROUP = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Asset_Group')
        .getRecordTypeId();

    public static final String PRODUCT = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Product')
        .getRecordTypeId();

    public static final String PRODUCT_PRICE = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Product_Price')
        .getRecordTypeId();

    public static final String SALES_PLAN = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Sales_Plan')
        .getRecordTypeId();

    public static final String SALES_REP = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Sales_Rep')
        .getRecordTypeId();
    
    public static final String MASTER_DATA_WAREHOUSE = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Warehouse')
        .getRecordTypeId();

    public static final String REGION = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Region')
        .getRecordTypeId();
    
     public static final String MASTER_DATA_WAREHOUSE_LOCATION = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Warehouse_Location')
        .getRecordTypeId();
    
    public static final String MASTER_DATA_WAREHOUSE_INVENTORY = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Warehouse_Inventory')
        .getRecordTypeId();
    
    public static final String TERRITORY = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Territory')
        .getRecordTypeId();
    
    public static final String TERRITORY_SETUP = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Territory_Setup')
        .getRecordTypeId();
     
    public static final String PROMOTION = Schema.SObjectType.Master_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Promotion')
        .getRecordTypeId();
    
    // Master Data Item
    public static final String ACCOUNT_ADDRESS = Schema.SObjectType.Master_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Account_Address')
        .getRecordTypeId();

    public static final String DEFAULT_RECORD = Schema.SObjectType.Master_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('DefaultRecord')
        .getRecordTypeId();

    public static final String PRODUCT_PRICE_ITEM = Schema.SObjectType.Master_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Product_Price_Item')
        .getRecordTypeId();
    
    public static final String TERRITORY_ASSIGNMENT = Schema.SObjectType.Master_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Territory_Assignment')
        .getRecordTypeId();
    
    public static final String TERRITORY_RULE = Schema.SObjectType.Master_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Territory_Rule')
        .getRecordTypeId();
    
    public static final String USER_HIERACHY = Schema.SObjectType.Master_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('User_Hierachy')
        .getRecordTypeId();

    // Transaction Data
    public static final String DELIVERY_ORDER = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Delivery_Order')
        .getRecordTypeId();
    
    public static final String INVENTORY_TRANSACTION_HEADER = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Inventory_Transaction_Header')
        .getRecordTypeId();
    
    public static final String INVENTORY_TRANSACTION_HEADER_IMPORT = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Inventory_Transaction_Header_Import')
        .getRecordTypeId();
    
    public static final String INVENTORY_TRANSACTION_HEADER_EXPORT = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Inventory_Transaction_Header_Export')
        .getRecordTypeId();
    
    public static final String INVENTORY_TRANSACTION_HEADER_TRANSFER = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Inventory_Transaction_Header_Transfer')
        .getRecordTypeId();
    
    public static final String ORDER = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Order')
        .getRecordTypeId();
    
    public static final String PURCHASE_ORDER = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Purchase_Order')
        .getRecordTypeId();
    
    public static final String QUOTA_PLAN = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Quota_Plan')
        .getRecordTypeId();
    
    public static final String RETURN_ORDER = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Return_Order')
        .getRecordTypeId();
    
    public static final String SALES_ORDER = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Sales_Order')
        .getRecordTypeId();
    
    public static final String TRANSFER_ORDER = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Transfer_Order')
        .getRecordTypeId();

    public static final String LEAD = Schema.SObjectType.Transaction_Data__c.getRecordTypeInfosByDeveloperName()
        .get('Lead')
        .getRecordTypeId();
    
    // Transaction Data Item
    public static final String ORDER_ITEM = Schema.SObjectType.Transaction_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Order_Item')
        .getRecordTypeId();
    
    public static final String QUOTA_PLAN_ITEM = Schema.SObjectType.Transaction_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Quota_Plan_Item')
        .getRecordTypeId();
    
    public static final String QUOTA_PLAN_ITEM_MONTH = Schema.SObjectType.Transaction_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Quota_Plan_Item_Month')
        .getRecordTypeId();
    
    public static final String TRANSACTION_ITEM_LOCATION = Schema.SObjectType.Transaction_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Transaction_Item_Location')
        .getRecordTypeId();
    
    public static final String ASSET_TRANSACTION = Schema.SObjectType.Transaction_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Asset_Transaction')
        .getRecordTypeId();
    
    public static final String INVENTORY_TRANSACTION_ITEM = Schema.SObjectType.Transaction_Data_Item__c.getRecordTypeInfosByDeveloperName()
        .get('Inventory_Transaction_Item')
        .getRecordTypeId();
    
}