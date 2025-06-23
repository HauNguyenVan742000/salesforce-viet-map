import { LightningElement, track, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';

import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import MASSTER_DATA_OBJECT from '@salesforce/schema/Master_Data__c';

import addIcons from '@salesforce/resourceUrl/add_icon';
import minusIcons from '@salesforce/resourceUrl/minus_icon';
import LABELS from 'c/sharedLabels';

import getUsers from '@salesforce/apex/territoryPlanningController.getUsers';
import getSalesPlans from '@salesforce/apex/territoryPlanningController.getSalesPlans';
import insertTerritory from '@salesforce/apex/territoryPlanningController.insertTerritory';
import updateTerritory from '@salesforce/apex/territoryPlanningController.updateTerritory';
import deleteTerritory from '@salesforce/apex/territoryPlanningController.deleteTerritory';
import getTerritory from '@salesforce/apex/territoryPlanningController.getTerritory';
import getTerritoryAll from '@salesforce/apex/territoryPlanningController.getTerritoryAll';
import getTerritoryForSalesPlan from '@salesforce/apex/territoryPlanningController.getTerritoryForSalesPlan';
import saveTerritoryAssignments from '@salesforce/apex/territoryPlanningController.saveTerritoryAssignments';

export default class TerritoryPlanning extends NavigationMixin(LightningElement)  {
    @api recordId;
    @track isModalOpen = false;
    // addIcons = addIcons;
    // minusIcons = minusIcons;

    territoryName;
    mapColor;
    @track addProvince = false;
    @track isChil = false;
    @track selectedReportsTo;
    @track selectedSalesPlan;
    @track selectedRegion;
    @track selectedTerritory;
    @track selectedTerritoryId;
    @track territoryId;

    @track userOptions = [];
    @track territoryOptions = [];
    @track salesPlanOptions = [];
    @track lstTerritory = [];
    
    @track isOpen = false;
    @track isModalTerritoryAssignmentOpen = false;
    @track isModalRuleOpen = false;
    @track isModalProvinceCity = false;
    @track isModalSetMinQuota = false;
    @track isModalEdit = false;
    @track isModalDelete = false;
   
    lstsource;
    wiredTerritoryResult;
    label = LABELS;

    constructor() {
        super();
        this.boundCloseDropdown = this.handleCloseDropdown.bind(this);
    }
    
    connectedCallback() {
        document.addEventListener('click', this.boundCloseDropdown);
    }
    
    disconnectedCallback() {
        document.removeEventListener('click', this.boundCloseDropdown);
    }

    // ----------------------------Get record Type Id--------------------------------------------
    @wire(getObjectInfo, { objectApiName: MASSTER_DATA_OBJECT })
    objectInfo;

    getRecordTypeIdByDeveloperName(developerName) {
        if (this.objectInfo.data) {
            const rtInfos = this.objectInfo.data.recordTypeInfos;
            const rtId = Object.keys(rtInfos).find(id => rtInfos[id].name === developerName);
            return rtId;
        }
        return null;
    }

    // ------------------------------ Get Territory----------------------------------------------
    @wire(getTerritoryAll, {recordId : '$recordId'})
    wireGetTerritoryAll(result) {
        this.wiredTerritoryResult = result;
        const { error, data } = result;
        if (data) {
            this.lstTerritory = this.processData(JSON.parse(JSON.stringify(result.data)));
        } else if (error) {
            console.error('Error fetching users: ', error);
        }
    }

    @wire(getUsers, { recordId: '$recordId' })
    wireGetUsers({error, data}) {
        if (data) {
            // this.userOptions = data.map(item => ({ label: item.Name, value: item.Id }));
            this.userOptions = data;
        } else if (error) {
            console.error('Error fetching users: ', error);
        }
    }

    @wire(getTerritoryForSalesPlan, { recordId: '$recordId' })
    wireGetTerritoryForSalesPlan({error, data}) {
        if (data) {
            // this.userOptions = data.map(item => ({ label: item.Name, value: item.Id }));
            this.territoryOptions = data;
        } else if (error) {
            console.error('Error fetching users: ', error);
        }
    }

    @wire(getSalesPlans)
    wireGetSalesPlans({error, data}) {
        if (data) {
            this.salesPlanOptions = data.map(item => ({ label: item.Name, value: item.Id }));
        } else if (error) {
            console.error('Error fetching sales plans: ', error);
        }
    }

    handleAddTerritory(event) {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
        this.isModalEdit = false;
    }

    handleInputChange(event){
        const { label, value } = event.target;
        if (label === 'Tên vùng quản lý' || label === 'Territory Name' ) this.territoryName = value;
        if (label === 'Mã màu hiển thị'|| label === 'Color') this.mapColor = value;
    }

    handleCheckboxChange(event) {
        this.addProvince = event.target.checked; 
    }

    handleReportsToChange(event) {
        this.selectedReportsTo = event.detail.selectedRecord;
    }
    
    handleSalesPlanChange(event) {
        this.selectedSalesPlan = event.detail.selectedRecord;
    }  
    
    handleRegionChange(event) {
        this.selectedRegion = event.detail.selectedRecord;
    } 
 
    handleTerritoryChange(event) {
        this.selectedTerritory = event.detail.selectedRecord;
    }  

    handleSaveOrUpdateTerritory() {
        const recordTypeId = this.getRecordTypeIdByDeveloperName('Territory');

        const territory = {
            Id: this.territoryId || null, 
            Name: this.territoryName,
            Map_Color__c: this.mapColor,
            Sales_Plan__c: this.selectedSalesPlan ? this.selectedSalesPlan.Id : null,
            OwnerId: this.selectedReportsTo ? this.selectedReportsTo.Id : null,
            Report_to__c: this.selectedReportsTo ? this.selectedReportsTo.Id : null,
            Region__c: this.selectedRegion ? this.selectedRegion.Id : null,
            Parent_Territory__c: this.selectedTerritory ? this.selectedTerritory.Id : null,
            isManual__c: this.addProvince,
            Is_Child__c: true,
            RecordTypeId: recordTypeId,
        };
    
        if (this.territoryId) {
            updateTerritory({ territoryObj: territory })
                .then(() => {
                    this.showToast('Success', 'Vùng lãnh thổ đã cập nhật thành công!', 'success');
                    refreshApex(this.wiredTerritoryResult);
                    this.closeModal();
                })
                .catch(error => {
                    this.showToast('Error', error.body.message, 'error');
                });
        } else {
            insertTerritory({ territoryObj: territory })
                .then(() => {
                    this.showToast('Success', 'Vùng lãnh thổ đã thêm thành công!', 'success');
                    refreshApex(this.wiredTerritoryResult);
                    this.closeModal();
                })
                .catch(error => {
                    this.showToast('Error', error.body.message, 'error');
                });
        }
    }    

    handleOpenRules(event){
        event.preventDefault();
        const territoryId = event.currentTarget.dataset.id;
        this.selectedTerritoryId = territoryId;
        this.isModalRuleOpen = true;
    }

    closeRuleModal() {
        this.isModalRuleOpen = false;
    }

    handleOpenTerritoryAssignment(event){
        event.preventDefault();
        const territoryId = event.currentTarget.dataset.id;
        this.selectedTerritoryId = territoryId;
        this.isModalTerritoryAssignmentOpen = true;
    }

    closeModalTerritoryAssignment() {
        this.isModalTerritoryAssignmentOpen = false;
    }

    handleOpenProvince(event){
        event.preventDefault();
        this.isModalProvinceCity = true;    
    }

    closeProvinceCity() {
        this.isModalProvinceCity = false;
    }

    handleSetMinQuota(event){
        event.preventDefault();
        const territoryId = event.currentTarget.dataset.id;
        this.selectedTerritoryId = territoryId;
        this.isModalSetMinQuota = true;
    }

    closeSetMinQuota(){
        this.isModalSetMinQuota = false;
    }

    handleEditOpen(event) {
        event.preventDefault();
        const territoryId = event.currentTarget.dataset.id;
        this.territoryId = territoryId;
    
        getTerritory({ recordId: territoryId })
            .then(selected => {
                if (selected) {
                    this.recordId = selected.Sales_Plan__c; 

                    this.territoryName = selected.Name;
                    this.mapColor = selected.Map_Color__c;
                    this.addProvince = selected.isManual__c;
    
                    this.selectedReportsTo = selected.Report_to__c
                        ? { Id: selected.Report_to__c, Name: selected.Report_to__r.Name }
                        : null;
    
                    this.selectedSalesPlan = selected.Sales_Plan__c 
                        ? { Id: selected.Sales_Plan__c, Name: selected.Sales_Plan__r.Name }
                        : null;
    
                    this.selectedRegion = selected.Region__c
                        ? { Id: selected.Region__c, Name: selected.Region__r.Name }
                        : null;

                    this.selectedTerritory = selected.Parent_Territory__c
                    ? { Id: selected.Parent_Territory__c, Name: selected.Parent_Territory__r.Name }
                    : null;

                    this.isChil = selected.Is_Child__c;
                    getUsers({ recordId: selected.Sales_Plan__c })
                        .then(users => {
                            this.userOptions = users;
                        })
                        .catch(error => {
                            console.error('Error fetching users manually: ', error);
                        });
                    this.isModalEdit = true;

                }
            })
            .catch(error => {
                console.error('Error loading default record:', error);
            });
    }

    handleDeleteOpen(event) {
        event.preventDefault();
        const territoryId = event.currentTarget.dataset.id;
        this.selectedTerritoryId = territoryId;
        this.isModalDelete = true;
    }

    confirmDeleteAddress() {
        deleteTerritory({ recordId: this.selectedTerritoryId })
        .then(() => {
            this.showToast('Success', 'Vùng lãnh thổ đã xóa thành công!', 'success');
            refreshApex(this.wiredTerritoryResult);
            this.closeDelete()
        })
        .catch(error => {
            this.showToast('Error', error.body.message, 'error');
        });
    }

    closeDelete() {
        this.isModalDelete = false;
    }

    // Func của nút dropdown
    toggleDropdown(event) {
        event.stopPropagation();
        const clickedId = event.currentTarget.dataset.id;
        
        this.lstTerritory = this.lstTerritory.map(item => this.updateDropdownState(item, clickedId));
    }
    
    updateDropdownState(item, clickedId) {
        if (item.id === clickedId) {
            return { ...item, isOpen: !item.isOpen };
        } 
        if (item._children && item._children.length > 0) {
            return { 
                ...item, 
                _children: item._children.map(child => this.updateDropdownState(child, clickedId)) 
            };
        }
        return item;
    }

    handleAction(event) {
        event.stopPropagation();
        const clickedId = event.currentTarget.dataset.id;
        this.lstTerritory = this.lstTerritory.map(item => ({
            ...item,
            isOpen: item.id === clickedId ? !item.isOpen : item.isOpen
        }));
    }

    handleCloseDropdown(event) {
        if (!this.template.contains(event.target)) {
            this.lstTerritory = this.lstTerritory.map(item => this.closeDropdownRecursively(item));
        }
    }

    handleRefresh() {
        this.isModalSetMinQuota = false;
        this.isModalRuleOpen = false;
        this.isModalTerritoryAssignmentOpen = false;
        refreshApex(this.wiredTerritoryResult);     
    }
    
    closeDropdownRecursively(item) {
        let newItem = { ...item, isOpen: false };
        if (item._children && item._children.length > 0) {
            newItem._children = item._children.map(child => this.closeDropdownRecursively(child));
        }
        return newItem;
    }
    
    handleChevronClick(event) {
        const itemId = event.currentTarget.dataset.id;
        this.toggleExpandState(this.lstTerritory, itemId);
    }

    toggleExpandState(lstTerritory, itemId) {
        for (let item of lstTerritory) {
            if (item.id == itemId) {
                item.expanded = !item.expanded;
                item.chevronIcon = item.expanded ? 'utility:chevrondown' : 'utility:chevronright';
            }
            if (item._children) {
                this.toggleExpandState(item._children, itemId);
            }
        }
        this.lstTerritory = [...this.lstTerritory]; 
    }

    processData(data) {
        return data.map(item => this.renameChildren(item));
    }

    renameChildren(item) {
        item._children = Array.isArray(item.children) ? item.children : [];
        delete item.children;
        if (item._children.length > 0) {
            item._children = item._children.map(child => this.renameChildren(child));
            item.isChevronClick = true;
        } else {
            item.isChevronClick = false;
        }
        return item;
    }

    handleNavigateToRecord(event) {
        event.preventDefault();
        const recordId = event.currentTarget.dataset.id;

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Territory__c',
                actionName: 'view'
            },
        });

    }

    saveAssignmentModal(event) {
        const territoryAssignmentCmp = this.template.querySelector('c-lwc-territory-assignment');

        if (territoryAssignmentCmp) {
            const changedOwners = territoryAssignmentCmp.changedTerritoryOwners;

            const assignmentsToSave = Object.keys(changedOwners).map(territoryId => ({
                territoryId: territoryId,
                ownerId: changedOwners[territoryId]
            }));

            saveTerritoryAssignments({ assignments: assignmentsToSave })
                .then(result => {
                    console.log('Lưu thành công:', result);
                    this.showToast('Success', 'Territory updated owner successfully!', 'success');
                    this.handleRefresh();
                })
                .catch(error => {
                    console.error('Lỗi khi lưu:', error);
                    // Xử lý lỗi
                });
        } else {
            console.error('Không tìm thấy component c-lwc-territory-assignment.');
        }
    }

    showToast(type, title, massage) {
        const event = new ShowToastEvent({
                 title: title,
                 message: massage,
                 variant: type,
                 mode: 'dismissable'
       });
       this.dispatchEvent(event);
    }
}