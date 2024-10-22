<script setup>
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import InputText from 'primevue/inputtext';
import { RouterLink } from 'vue-router';
import { ref, computed } from 'vue';
import { mockUsers } from '../../public/mockData';

const searchTerm = ref('');

const filteredUsers = computed(() => {
    return mockUsers.filter(user => {
        return (
            user.username.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
            user.email.toLowerCase().includes(searchTerm.value.toLowerCase())
        );
    });
});

// Sample methods for modify and delete actions
const modifyUser = (user) => {
    // Logic for modifying the user
    console.log("Modify user:", user);
};

const deleteUser = (userId) => {
    // Logic for deleting the user
    console.log("Delete user with ID:", userId);
};
</script>

<template>
    <div>
        <InputText 
            v-model="searchTerm" 
            placeholder="Search by username or email" 
            style="margin-bottom: 1rem;"
        />
        <RouterLink to="/user/create"><img src="../assets/add-green.svg" alt="" class="create-button"></RouterLink>

        <DataTable 
            :value="filteredUsers" 
            tableStyle="min-width: 50rem" 
            scrollable 
            scrollHeight="350px" 
            paginator 
            :rows="5" 
            :rowsPerPageOptions="[5, 10, 20, 50]"
        >
            <Column field="id" header="ID" sortable style="width: 10%"></Column>
            <Column field="username" header="Username" sortable style="width: 25%"></Column>
            <Column field="email" header="Email" sortable style="width: 30%"></Column>
            <Column field="teams_id" header="Teams ID" sortable style="width: 15%"></Column>
            <Column field="role" header="Role" sortable style="width: 15%"></Column>
            <Column header="Actions" style="width: 10%">
              <template #body="slotProps">
                <RouterLink to="/user/modifyAnotherUser"><img src="../assets/pencil_1.png" class="table-button" alt=""></RouterLink>
                
                <img src="../assets/trash_2.png" class="table-button" alt="">
              </template>
            </Column>
        </DataTable>
    </div>
</template>

<style>
.table-button {
  margin-right: 5px;
  height: 20px;
  cursor: pointer;
}
</style>
