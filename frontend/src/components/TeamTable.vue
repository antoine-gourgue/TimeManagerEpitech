<script setup>
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import InputText from 'primevue/inputtext';
import { ref, computed } from 'vue';
import { mockTeams } from '../../public/mockData'; // Assume mockTeams contains your teams data
import Button from 'primevue/button';

const searchTerm = ref('');

const filteredTeams = computed(() => {
    return mockTeams.filter(team => {
        return (
            team.name.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
            team.teamManager.toLowerCase().includes(searchTerm.value.toLowerCase())
        );
    });
});
</script>

<template>
    <div>
        <InputText 
            v-model="searchTerm" 
            placeholder="Search by team name or manager" 
            style="margin-bottom: 1rem;"
        />
        <RouterLink to="/team/create"><img src="../assets/add-green.svg" alt="" class="create-button"></RouterLink>

        <DataTable 
            :value="filteredTeams" 
            tableStyle="min-width: 50rem" 
            scrollable 
            scrollHeight="350px" 
            paginator 
            :rows="5" 
            :rowsPerPageOptions="[5, 10, 20, 50]"
        >
            <Column field="id" header="Team ID" sortable style="width: 15%"></Column>
            <Column field="name" header="Name" sortable style="width: 25%"></Column>
            <Column field="teamManager" header="Team Manager" sortable style="width: 30%"></Column>
            <Column field="numberOfEmployees" header="Number of Employees" sortable style="width: 20%"></Column>
            <Column header="Actions" style="width: 10%">
              <template #body="slotProps">
                <RouterLink to="/team/modify"><img src="../assets/pencil_1.png" class="table-button" alt=""></RouterLink>
                <img src="../assets/trash_2.png" class="table-button" alt="">
              </template>
            </Column>
        </DataTable>
    </div>
</template>

<style></style>
