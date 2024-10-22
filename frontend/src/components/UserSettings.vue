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
    <h2 class="page-title">Account settings</h2>
    <p class="page-subtitle">Hello, {{ user.username }} !</p>
    <p class="page-subtitle">You can modify your account informations</p>
    <form action="">
      <label for="email">Email :</label>
      <input type="email" name="email" id="email">
      <label for="username">Username :</label>
      <input type="text" name="username" id="username">
      <label for="password">Password :</label>
      <input type="password" name="password" id="password">
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green">Confirm</button>
      <button class="custom-button form-button-small yellow">Cancel</button>
    </div>
  </div>
</template>

<style>
.page-title {
  font-size: 48px;
  margin: 15px;
}

.page-subtitle {
  font-size: 20px;
  font-weight: 300;
  word-wrap: break-word;
}

form {
  width: 450px;
  margin: 45px;
  display: flex;
  flex-direction: column;
}

label {
  margin-top: 20px;
  margin-bottom: 8px;
  font-weight: 500;
}

input {
  border: 1px solid rgba(0, 0, 0, 0.144);
  border-radius: 8px;
  height: 40px;
}

.yellow {
  background-color: rgb(216, 183, 18);
}

.form-button-big {
  justify-content:  center;
  transform: scale(0.8);
}

.form-button-small {
  justify-content:  center;
  transform: scale(0.6);
}

@media (max-width:940px) {
  .main-container {
    min-height: 100vh;
  }

  form {
    width: 90%;
  }

  
  input {
    align-self: center;
    width: 100%;
  }

  .page-title {
    font-size: 34px;
  }

  .page-subtitle {
    font-size: 16px;
  }
}
</style>