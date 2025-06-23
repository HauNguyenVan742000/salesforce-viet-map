import { LightningElement, api, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';

import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import MASTER_OBJECT from '@salesforce/schema/Master_Data_Item__c';

import getListUserHierarchy from '@salesforce/apex/HierachyPlanningController.getListUserHierarchy';
import deleteUserHierachy from '@salesforce/apex/HierachyPlanningController.deleteUserHierachy';

import LABELS from 'c/sharedLabels';

export default class HierachyPlanning extends LightningElement {
    @api recordId;

    @track hierarchyData;
    @track isModalOpen = false;
    @track isAddEditModalOpen = false;
    @track modalTitle = '';
    @track selectedRow;
    userHierachyRecordTypeId;

    wireListUserHierarchy;
    label = LABELS;

    newSalesValue = null;
    newRoleValue = null;
    newManagerValue = null;
    // inputName = null;
    isModalEdit = false;
    @track recordIdEdit;
    isOpenDelete = false;
    rowIdDelete = null;
    isDisabled = false;

    // Func Close Dropdow khi click ở ngoài
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

    handleCloseDropdown(event) {
        if (!this.template.contains(event.target)) {
            this.hierarchyData = this.hierarchyData.map(item => this.closeDropdownRecursively(item));
        }
    }

    closeDropdownRecursively(item) {
        let newItem = { ...item, isOpen: false };
        if (item._children && item._children.length > 0) {
            newItem._children = item._children.map(child => this.closeDropdownRecursively(child));
        }
        return newItem;
    }
    // --------------------------------Func Get Record Type Id ------------------
    @wire(getObjectInfo, { objectApiName: MASTER_OBJECT })
    objectInfoHandler({ data, error }) {
        if (data) {
            debugger;
            const rtis = data.recordTypeInfos;
            for (const rtId in rtis) {
                if (rtis[rtId].name === 'User Hierachy') {
                    this.userHierachyRecordTypeId = rtId;
                    break;
                }
            }
        } else if (error) {
            console.error('Lỗi load RecordType:', error);
        }
    }
    // ------------------------- Func get data tree grid ---------------------------
    @wire(getListUserHierarchy, { recordId: '$recordId' })
    wireGetListUserHierarchy(result) {
        this.wireListUserHierarchy = result;
        const { error, data } = result;
        if (data) {
            this.hierarchyData = this.processData(JSON.parse(JSON.stringify(result.data)));
        } else if (error) {
            console.error('Error fetching users: ', error);
        }
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
    // -------------------------------------------------------
    // Func Close/Open ChevronClick
    handleChevronClick(event) {
        const itemId = event.currentTarget.dataset.id;
        this.toggleExpandState(this.hierarchyData, itemId);
    }

    toggleExpandState(hierarchyData, itemId) {
        for (let item of hierarchyData) {
            if (item.id == itemId) {
                item.expanded = !item.expanded;
                item.chevronIcon = item.expanded ? 'utility:chevrondown' : 'utility:chevronright';
            }
            if (item._children) {
                this.toggleExpandState(item._children, itemId);
            }
        }
        this.hierarchyData = [...this.hierarchyData];
    }
    // -------------------------------------------------------
    // Func Navigate to record
    handleNavigateToRecord(event) {
        event.preventDefault();
        const recordId = event.currentTarget.dataset.id;

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Master_Data_Item__c',
                actionName: 'view'
            },
        });
    }
    // -------------------------------------------------------
    // Func Close Dropdow 
    toggleDropdown(event) {
        event.stopPropagation();
        const clickedId = event.currentTarget.dataset.id;

        this.hierarchyData = this.hierarchyData.map(item => this.updateDropdownState(item, clickedId));
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
    // -------------------------------------------------------
    openAddModal() {
        this.modalTitle = 'Add Sales';
        this.isAddEditModalOpen = true;
    }

    handleEditOpenParent(event) {
        const rowId = event.detail;
        const row = this.findNode(this.treeData, rowId);
        if (row) {
            this.selectedRow = { ...row };
            this.modalTitle = 'Edit Role';
            this.isAddEditModalOpen = true;
        }
    }

    findNode(nodes, nodeId) {
        for (const node of nodes) {
            if (node.id === nodeId) {
                return node;
            }
            if (node._children) {
                const found = this.findNode(node._children, nodeId);
                if (found) {
                    return found;
                }
            }
        }
        return null;
    }

    handleDeleteOpenParent(event) {
        const rowId = event.detail;
        // Implement logic to delete the row
        console.log('Delete requested for ID:', rowId);
    }

    handleToggleDropdownParent(event) {
        const rowId = event.detail;
        this.toggleDropdownState(this.treeData, rowId);
        this.treeData = [...this.treeData];
    }

    toggleDropdownState(nodes, nodeId) {
        nodes.forEach(node => {
            if (node.id === nodeId) {
                node.isOpen = !node.isOpen;
            } else if (node._children && node._children.length) {
                this.toggleDropdownState(node._children, nodeId);
            }
        });
    }

    closeModal() {
        this.isAddEditModalOpen = false;
        this.isModalOpen = false;
        this.selectedRow = null;
        this.newSalesValue = null;
        this.newRoleValue = null;
        this.newManagerValue = null;
        this.isModalEdit = false;
    }

    handleUserSelection(event) {
        const val = event.detail.value;
        this.newSalesValue = val[0];
    }

    handleRole(event) {
        const val = event.detail.value;
        this.newRoleValue = val[0];
    }

    handleManager(event) {
        const val = event.detail.value;
        this.newManagerValue = val[0];
    }
    // --------------------------------- Func Add User Hierachy---------------------------
    handleAddRole() {
        this.isModalOpen = true;
    }

    // --------------------------------- Func Edit User Hierachy---------------------------
    handleEditOpen(event) {
        this.isModalEdit = true;
        const rowId = event.currentTarget.dataset.id;
        this.recordIdEdit = rowId;
    }
    // --------------------------------- Func Delete User Hierachy---------------------------
    handleCancelDelete() {
        this.isOpenDelete = false;
    }

    handleDeleteOpen(event) {
        this.isOpenDelete = true;
        const rowId = event.currentTarget.dataset.id;
        this.rowIdDelete = rowId;
    }

    handleConfirmDelete() {
        deleteUserHierachy({
            rowIdDelete: this.rowIdDelete
        })
            .then((data) => {
                this.showToast('success', 'Success Message', 'Delete userHierachy successfully');
                this.handleCancelDelete();
                refreshApex(this.wireListUserHierarchy);
            })
            .catch(error => {
                console.log(JSON.stringify(error));
                this.showToast('error', 'Error Message', error);
            });
    }
    // ------------------------------ THông báo lỗi --------------------------
    handleSuccess(event) {
        this.showToast('success', 'Thành công', 'Cập nhật thành công!');
        this.closeModal();
        refreshApex(this.wireListUserHierarchy);
    }

    handleError(event) {
        console.error(event.detail);
        this.showToast('error', 'Lỗi', 'Đã xảy ra lỗi khi lưu.');
    }

    handleAddSuccess(event) {
        this.showToast('success', 'Thành công', 'Thêm thành công!');
        this.closeModal();
        refreshApex(this.wireListUserHierarchy);
    }

    handleAddError(event) {
        console.error(event.detail);
        this.showToast('error', 'Lỗi', 'Đã xảy ra lỗi khi lưu.');
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