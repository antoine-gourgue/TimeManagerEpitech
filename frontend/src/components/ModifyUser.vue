<script setup>

import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';

import { mockUsers } from '../../public/mockData';
import { ref } from 'vue';

let user = ref(mockUsers[0])

</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Modify another user</h2>
    <form action="">
      <label for="email">Email :</label>
      <input type="email" name="email" id="email" :value="user.email">
      <label for="username">Username :</label>
      <input type="text" name="username" id="username" :value="user.username">
      <label for="password">Password :</label>
      <input type="password" name="password" id="password">
      <label for="role">Role :</label>
      <select name="role" id="role">
        <option value="user">User</option>
        <option value="manager">Manager</option>
        <option value="top_manager">Top manager</option>
      </select>
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green">Confirm</button>
      <button class="custom-button form-button-small yellow">Cancel</button>
    </div>
  </div>
</template>

<style>
</style>