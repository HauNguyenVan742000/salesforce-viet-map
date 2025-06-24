// Button Labels
import ADD_TERRITORY_LABEL from '@salesforce/label/c.Add_Territory';
import EDIT_TERRITORY_LABEL from '@salesforce/label/c.Edit_Territory';
import SAVE from '@salesforce/label/c.Save';
import CANCEL from '@salesforce/label/c.Cancel';
import EDIT from '@salesforce/label/c.Edit';
import ADD_PRODUCT from '@salesforce/label/c.Add_Product';
import DELETE from '@salesforce/label/c.Delete';
import ASSIGNMENT from '@salesforce/label/c.Assignment';
import IS_CUSTOMERS_MANUALLY from '@salesforce/label/c.Is_Customers_Manually';
import ADD_CONDITION from '@salesforce/label/c.Add_Condition';
import MARK_STATUS_COMPLETE from '@salesforce/label/c.Mark_Status_as_Complete';
import ADD_ACCOUNT from '@salesforce/label/c.Add_Account';

// Field Labels/tables
import TERRITORY_NAME from '@salesforce/label/c.Territory_Name';
import USER from '@salesforce/label/c.User';
import CHOOSE_USER from '@salesforce/label/c.Choose_User';
import SALES_PLAN from '@salesforce/label/c.Sales_Plan';
import REGION from '@salesforce/label/c.Region';
import TERRITORY from '@salesforce/label/c.Territory';
import COLOR from '@salesforce/label/c.Color';
import ADD_CUSTOMERS_MANUALLY from '@salesforce/label/c.Add_Customers_Manually';
import VEHICLE_COMPANY_PARTNER from '@salesforce/label/c.Vehicle_Company_Partner';
import DEALER from '@salesforce/label/c.Dealer';
import PROJECT_PARTNER from '@salesforce/label/c.Project_Partner';
import MIN_QUOTA from '@salesforce/label/c.Min_Quota';
import PRODUCT_NAME from '@salesforce/label/c.Product_Name';
import SEARCH_PRODUCT from '@salesforce/label/c.Search_Product';
import SHOW_PLAN from '@salesforce/label/c.Show_Plan';
import OWNER from '@salesforce/label/c.Owner';

import PRODUCT_FAMILY from '@salesforce/label/c.Product_Family';
import PRODUCT_PRICE from '@salesforce/label/c.Product_Price';
import PRODUCT_CODE from '@salesforce/label/c.Product_Code';

import ODOO_REF from '@salesforce/label/c.Odoo_Ref';
import PRIORITY from '@salesforce/label/c.Priority';
import STATUS from '@salesforce/label/c.Status';
import ACTIONS from '@salesforce/label/c.Actions';
import ALL from '@salesforce/label/c.All';

import ACCOUNT_NAME from '@salesforce/label/c.Account_Name';
import FY_TOTAL from '@salesforce/label/c.FY_Total';
import NOTE from '@salesforce/label/c.Note';
import DETAILS from '@salesforce/label/c.Details';

import DRAW from '@salesforce/label/c.Draw';
import DENY from '@salesforce/label/c.Deny';
import CLOSED from '@salesforce/label/c.Closed';
import WAITING_FOR_APPROVED from '@salesforce/label/c.Waiting_for_Approved';

// Placeholder / Choose Labels
import CHOOSE_SALES_PLAN from '@salesforce/label/c.Choose_Sales_Plan';
import CHOOSE_REGION from '@salesforce/label/c.Choose_Region';
import CHOOSE_TERRITORY from '@salesforce/label/c.Choose_Territory';
import ENTER_COLOR from '@salesforce/label/c.Enter_Color';
import FILTER_BY_CATEGORY from '@salesforce/label/c.Filter_by_Category';
import SEARCH from '@salesforce/label/c.Search';

// Labels
import SET_MIN_QUOTA from '@salesforce/label/c.Set_Min_Quota';
import ASSIGNMENT_RULES from '@salesforce/label/c.Assignment_Rules';
import QUOTA_ATTAINMENT_PLAN from '@salesforce/label/c.Quota_Attainment_Plan';
import Manager from '@salesforce/label/c.Manager';
import Year from '@salesforce/label/c.Year';
import QUOTA from '@salesforce/label/c.Quota';
import Confirmation from '@salesforce/label/c.Confirmation';
import PLANNED_ATTAINMENT from '@salesforce/label/c.Planned_Attainment';
import QUOTA_ATTAINMENT_PLAN_DETAIL from '@salesforce/label/c.Quota_Attainment_Plan_Detail'; 
import PLANNING_SCRATCHPAD from '@salesforce/label/c.Planning_Scratchpad';
import DETAIL_SUMMARY from '@salesforce/label/c.Detail_Summary';
import MY_TEAM_PLANS from '@salesforce/label/c.My_Team_s_Plans';
import REPS from '@salesforce/label/c.Reps';
import NAME from '@salesforce/label/c.Name';
import TOTAL from '@salesforce/label/c.Total';
import TERRITORY_LEVEL_STRATEGY from '@salesforce/label/c.Territory_Level_Strategy';
import INFORMATION_ACCOUNT from '@salesforce/label/c.Information_Account';
import PRODUCT from '@salesforce/label/c.Product';
import ADD_HIRERACHY from '@salesforce/label/c.Add_Hirerachy';
import SALES from '@salesforce/label/c.Sales';
import TOTAL_APPROVED_TARGET from '@salesforce/label/c.Total_Approved_Target';
import TOTAL_UNAPPROVED_TARGET from '@salesforce/label/c.Total_Unapproved_Target';

import LOCKED from '@salesforce/label/c.Locked';
import APPROVED from '@salesforce/label/c.Approved';
import PENDING_APPROVAL from '@salesforce/label/c.Pending_Approval';
import NEED_UPDATE from '@salesforce/label/c.Needs_Update';
import CUSOMER_NOT_PLANNED_PLANNED from '@salesforce/label/c.Customer_Not_Planned_Planned';

import ADD_ROLE from '@salesforce/label/c.Add_Role';
import DELETE_PRODUCT from '@salesforce/label/c.Delete_Product';
import ARE_YOU_SURE_DELETE from '@salesforce/label/c.Are_you_sure_you_want_to_delete_product';

import FIELD_NAME from '@salesforce/label/c.Field_Name';
import OPERATOR from '@salesforce/label/c.Operator';
import VALUE from '@salesforce/label/c.Value';

import RULES from '@salesforce/label/c.Rules';
import CUSTOM_LOGIC from '@salesforce/label/c.Custom_Logic';

import TAKE_ACTION_WHEN from '@salesforce/label/c.Take_Action_When';

import SUBMIT_FOR_APPROVE from '@salesforce/label/c.Submit_for_Approve';


// Month
import JANUARY from '@salesforce/label/c.January';
import FEBRUARY from '@salesforce/label/c.February';
import MARCH from '@salesforce/label/c.March';
import APRIL from '@salesforce/label/c.April';
import MAY from '@salesforce/label/c.May';
import JUNE from '@salesforce/label/c.June';
import JULY from '@salesforce/label/c.July';
import AUGUST from '@salesforce/label/c.August';
import SEPTEMBER from '@salesforce/label/c.September';
import OCTOBER from '@salesforce/label/c.October';
import NOVEMBER from '@salesforce/label/c.November';
import DECEMBER from '@salesforce/label/c.December';
import MONTH from '@salesforce/label/c.Month';

const LABELS = {
    // Buttons
    addTerritory: ADD_TERRITORY_LABEL,
    editTerritory: EDIT_TERRITORY_LABEL,
    save: SAVE,
    cancel: CANCEL,
    edit: EDIT,
    addProduct: ADD_PRODUCT,
    delete: DELETE,
    assignment: ASSIGNMENT,
    isCustomersManually: IS_CUSTOMERS_MANUALLY,
    addCondition: ADD_CONDITION,
    markStatusComplete: MARK_STATUS_COMPLETE,
    addAccount: ADD_ACCOUNT,
    submitForApprove: SUBMIT_FOR_APPROVE,

    // Fields
    territoryName: TERRITORY_NAME,
    user: USER, 
    salesPlan: SALES_PLAN,
    region: REGION,
    territory: TERRITORY,
    color: COLOR,
    addCustomerManually: ADD_CUSTOMERS_MANUALLY,
    vehicleCompanyPartner: VEHICLE_COMPANY_PARTNER,
    dealer: DEALER,
    projectPartner: PROJECT_PARTNER,
    minQuota: MIN_QUOTA,
    searchProduct: SEARCH_PRODUCT,
    owner: OWNER,

    productFamily: PRODUCT_FAMILY,
    productPrice: PRODUCT_PRICE,
    productCode: PRODUCT_CODE,
    odooRef: ODOO_REF,
    priority: PRIORITY,
    status: STATUS,
    actions: ACTIONS,
    all: ALL,
    accountName: ACCOUNT_NAME,
    fyTotal: FY_TOTAL,
    note: NOTE,
    details: DETAILS,
    draw: DRAW,
    deny: DENY,
    closed: CLOSED,
    waitingForApproved: WAITING_FOR_APPROVED,

    // Placeholders
    chooseUser: CHOOSE_USER,
    chooseSalesPlan: CHOOSE_SALES_PLAN,
    chooseRegion: CHOOSE_REGION,
    chooseTerritory: CHOOSE_TERRITORY,
    enterColor: ENTER_COLOR,
    filterByCategory: FILTER_BY_CATEGORY,
    search: SEARCH,

    // Month
    january: JANUARY,
    february: FEBRUARY,
    march: MARCH,
    april: APRIL,
    may: MAY,
    june: JUNE,
    july: JULY,
    august: AUGUST,
    september: SEPTEMBER,
    october: OCTOBER,
    november: NOVEMBER,
    december: DECEMBER,
    month: MONTH,

    //Label
    setMinQuota: SET_MIN_QUOTA,
    assignmentRules:ASSIGNMENT_RULES,
    QuotaAttainmentPlan: QUOTA_ATTAINMENT_PLAN,
    Manager:Manager,
    Year: Year,
    Quota: QUOTA,
    Confirmation: Confirmation,
    plannedAttainment: PLANNED_ATTAINMENT,
    quotaAttainmentPlanDetail: QUOTA_ATTAINMENT_PLAN_DETAIL,
    planningScratchpad: PLANNING_SCRATCHPAD,
    detailSummary: DETAIL_SUMMARY,
    myTeamPlans: MY_TEAM_PLANS,
    showPlan: SHOW_PLAN,
    reps: REPS,
    name: NAME,
    total: TOTAL,
    territoryLevelStrategy: TERRITORY_LEVEL_STRATEGY,
    InformationAccount: INFORMATION_ACCOUNT,
    product: PRODUCT,
    productName: PRODUCT_NAME,
    add_Hirerachy: ADD_HIRERACHY,
    sales: SALES,
    totalApprovedTarget: TOTAL_APPROVED_TARGET,
    totalUnapprovedTarget: TOTAL_UNAPPROVED_TARGET,
    locked: LOCKED,
    approved: APPROVED,
    approvalPending: PENDING_APPROVAL,
    needUpdate: NEED_UPDATE,
    customerNotPlannedPlanned: CUSOMER_NOT_PLANNED_PLANNED,
    addRole: ADD_ROLE,
    deleteProduct: DELETE_PRODUCT,
    areYouSureDelete: ARE_YOU_SURE_DELETE,
    fieldName: FIELD_NAME,
    operator: OPERATOR,
    value: VALUE,
    rules: RULES,
    customLogic: CUSTOM_LOGIC,
    takeActionWhen: TAKE_ACTION_WHEN
    //{label.customLogic}

};

export default LABELS;