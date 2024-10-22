<script setup>

import AppBanner from './banner/AppBanner.vue';
import SearchBar from './SearchBar.vue';
import SideBar from './sidebar/SideBar.vue';


import UserTable from './UserTable.vue';


</script>

<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <div class="team-container">
        <div class="team-card">
          <h3>Team Patapon</h3>
          <!-- <img src="../assets/night-shift-warning.png" alt="" class="nightshift-warning"> -->
        </div>
      <RouterLink to="/team/manage" class="team-card">Team Patapon</RouterLink>
      <div class="team-card">Team Patapon</div>
      <div class="team-card">Team Patapon</div>
    </div>
    <!-- <SearchBar placeholder="Tibidi" /> -->
    <div class="table-container">
      <UserTable />
    </div>


  </div>
</template>

<style>

.team-container {
  width: 100%;
  height: 225px;
  border-bottom: 2px solid rgba(0, 0, 0, 0.239);
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  overflow-x:auto;
  white-space: nowrap;
  flex-wrap: nowrap;
}

.table-container {
  width: 90%;
  height: auto;
  margin-top: 15px;
}


.team-card {
  text-decoration: none;
  color: black;
  width: 200px;
  height: 200px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border: 2px solid rgba(0, 0, 0, 0.301);
  background-color: white;
  border-radius: 8px;
  font-weight: 600;
  font-size: 24px;
  margin: 15px;
  /* padding-top: 26px; */
} 

/* .nightshift-warning{
  position: relative;
  top: 85px;
  left: ;
} */

</style>