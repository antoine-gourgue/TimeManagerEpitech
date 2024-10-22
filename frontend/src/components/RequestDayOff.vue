<script setup>

import { mockUsers } from '../../public/mockData';
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';

let user = mockUsers[0]

</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Manage your time</h2>
    <p class="page-subtitle">Hello, {{ user.username }} !</p>
    <p class="page-subtitle">Please, fill this form to be allowed to take a day off</p>
    <form action="">
      <label for="email">Reason :</label>
      <select name="reason" id="reason">
        <option value="dayOff">Day off</option>
        <option value="sickLeave">Sick leave</option>
      </select>
      <div class="form-section">
        <div class="date-input">
          <label for="start_time">Start time :</label>
          <input type="datetime" name="start_time" id="start_time">
        </div>
        <div class="date-input">
          <label for="end_time">End time :</label>
          <input type="datetime" name="" id="">
        </div>

      </div>
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green">Confirm</button>
      <button class="custom-button form-button-small yellow">Cancel</button>
    </div>
  </div>
</template>

<style>

select {
  border: 1px solid rgba(0, 0, 0, 0.144);
  border-radius: 8px;
  height: 40px;
  padding: 5px;
}

.form-section {
  margin-top: 15px;
  width: 100%;
  
  display: flex;
  justify-content: space-between;
}
.date-input{
  width: 45%;
}

.date-input input {
  width: 100%;
  margin-top: 8px;
}

</style>