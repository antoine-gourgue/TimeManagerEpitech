<script setup>
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import TeamTable from './TeamTable.vue';
import UserTableForTopManager from './UserTableForTopManager.vue';


</script>

<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <div class="bidule">
      <section class="half-container">
        <h2>Users</h2>
        <UserTableForTopManager />
      </section>
      <section class="half-container">
        <h2>Teams</h2>
        <TeamTable />
      </section>
    </div>
  </div>
</template>

<style>
.bidule {
  width: 100%;
  height: 80%;
  display: flex;
  flex-direction: column;
  overflow-y: scroll;
}
.half-container {
  width: 100%;
  padding-bottom: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  border: 1px solid rgba(0, 0, 0, 0.124);
}

.half-container h2 {
  margin-top: 25px;
  margin-bottom: 10px;
  font-weight:600 ;
  font-size: 30px;
}

.create-button {
  height: 35px;
  position: relative;
  top: 10px;
  left: 550px;
}

@media (max-width:940px) {

}
</style>