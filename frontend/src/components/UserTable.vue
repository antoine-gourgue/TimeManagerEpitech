<script setup>
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import InputText from 'primevue/inputtext';
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
</script>

<template>
    <div>
        <InputText 
            v-model="searchTerm" 
            placeholder="Search by username or email" 
            style="margin-bottom: 1rem;"
        />

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
            <Column field="email" header="Email" sortable style="width: 35%"></Column>
            <Column field="teams_id" header="Teams ID" sortable style="width: 25%"></Column>
        </DataTable>
    </div>
</template>

<style></style>
