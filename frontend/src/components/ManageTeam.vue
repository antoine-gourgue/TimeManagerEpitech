<script setup>
import Splitter from 'primevue/splitter';
import AppBanner from './banner/AppBanner.vue';
import SearchBar from './SearchBar.vue';
import SideBar from './sidebar/SideBar.vue';
import SplitterPanel from 'primevue/splitterpanel';
import UserCard from './UserCard.vue';

let blob = 7
</script>

<template>
  <SideBar />
    <div class="main-container">
    <AppBanner />
    <div class="blob-container">
      <div class="small-container">
        <h2>Team Patapon</h2>
        <div class="team-info">
          <p><span>Manager :</span> Petitponey <br> petitponey@gothamcity.com</p>
          <p><span>Night shifts :</span> 2 employees have been working too many night shifts this week</p>
        </div>

      </div>
      <div class="small-container">
        <h3>Average working time per team member : {{ blob }} hours</h3>
      </div>
    </div>
    <div class="team-members-container">
      <div class="search-area">
        <SearchBar />
        <RouterLink to="/team/addUser"><img src="../assets/add-green.svg" alt="" class="add-button"></RouterLink>
        
      </div>
      <div class="card-container">
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
        <UserCard />
      </div>

    </div>


  </div>
</template>

<style>
.blob-container {
  width: 100%;
  height: 45%;
  display: flex;
  justify-content: space-between;
  margin-bottom: 12px;
}

.small-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  background-color: white;
  border: 1px solid rgba(0, 0, 0, 0.216);
  padding: 15px 25px;
  width: 49%;
  height: 100%;
  min-width: 345px;
  min-height: 310px;
}

.add-button{
  height: 50px;
  margin-right: 15px;
  cursor: pointer;
}

.add-button:hover {
  transform: scale(110%);
}

.team-members-container {
  width: 100%;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.search-area {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.card-container {
  max-height: 500px;
  display: flex;
  flex-wrap: wrap;
  overflow-y: scroll;
  justify-content: center;
}

@media (max-width:940px) {
  .blob-container {
    flex-direction: column;
  }

  .small-container {
    width: 100%;
  }

  .add-button {
    position: relative;
left: -25px;
  }
}
</style>