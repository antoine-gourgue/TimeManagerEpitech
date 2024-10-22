<script setup>

import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import { mockTeams } from '../../public/mockData';
import { ref } from 'vue';

let team = ref(mockTeams[0])

</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Modify an existing team</h2>
    <form action="">
      <label for="name">Team name :</label>
      <input type="text" name="name" id="name" :value="team.name">
      <label for="manager">Team manager :</label>
      <input type="text" name="manager" id="manager" :value="team.teamManager">
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green">Confirm</button>
      <button class="custom-button form-button-small yellow">Cancel</button>
    </div>
  </div>
</template>

<style>
</style>