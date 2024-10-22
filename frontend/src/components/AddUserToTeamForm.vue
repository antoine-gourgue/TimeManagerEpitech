<script setup>

import { mockUsers } from '../../public/mockData';
import AppBanner from './banner/AppBanner.vue';
import SearchBar from './SearchBar.vue';
import SideBar from './sidebar/SideBar.vue';
import UserTable from './UserTable.vue';

let user = mockUsers[0]

</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Add a new team member</h2>
    <p class="page-subtitle">Team Patapon :</p>

    <UserTable />
    <form action="">
      <div class="form-section">
        <div class="date-input">
          <label for="selectedUser">Selected user :</label>
          <input type="text" name="selectedUser" id="selectedUser">
        </div>
        <div class="date-input">
          <label for="selectedUserRole">Role :</label>
          <input type="text" name="selectedUserRole" id="selectedUserRole">
        </div>

      </div>
    </form>
    <div class="buttons-container-row">
      <button class="custom-button form-button-big green">Confirm</button>
      <button class="custom-button form-button-small yellow">Cancel</button>
    </div>
  </div>
</template>

<style>
.buttons-container-row {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  margin-bottom: 25px;
  width: 100%;
}
</style>