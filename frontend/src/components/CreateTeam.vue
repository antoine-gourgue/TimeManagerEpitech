<script setup>

import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';



</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Create a new team</h2>
    <form action="">
      <label for="name">Name :</label>
      <input type="text" name="name" id="name">
      <label for="manager">Username :</label>
      <input type="text" name="manager" id="manager">
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green">Confirm</button>
      <button class="custom-button form-button-small yellow">Cancel</button>
    </div>
  </div>
</template>

<style>
</style>