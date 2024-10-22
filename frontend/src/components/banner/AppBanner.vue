<script setup>
import ClockButton from './ClockButton.vue'
</script>

<template>
  <div class="banner-container">
    <div class="logo-container">
      <img src="../../assets/pending.svg" class="logo" />
      <h1 class="title">Time Manager</h1>
    </div>
    <div class="button-container">
      <ClockButton />
      <img src="../../assets/menu-burger.svg" alt="" class="logo burger-menu">
    </div>
    
  </div>
</template>

<style>
.banner-container {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 200px;
  padding: 10px 30px;
  background-image: url('../../assets/images/gotham.JPG');
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  color: var(--light);
}

.logo-container {
  min-width: 45%;
  height: 100%;
  display: flex;
  flex-direction: row;
  align-items: center;
}

.logo {
  width: auto;
  height: 70px;
}

.title {
  font-size: 64px;
  font-weight: 500;
  margin-left: 10px;
}

.burger-menu {
    display: none;
  }

@media (max-width:940px) {
  .banner-container {
    flex-direction: column;
  }
  .logo-container {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .logo {
    height: 40px;
  }
  .title {
    font-size: 36px;
  }
  .button-container {
    margin-top: 10px;
    width: 100%;
    align-items: center;
    justify-content: space-between;
    display: flex;
    flex-direction: row;
  }
  .burger-menu {
    display: inline;
  }
}
</style>
