<script setup>

import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';

let paidOvertime = 80
let nightShifts = 20


let paidOvertimeRatio= `${paidOvertime}%`
let nightShiftsRatio= `${nightShifts}%`

</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <div class="graph-container">
      <div class="graph small-graph">
        <h2 class="roboto-bold">Today</h2>
        <p>lalal</p>
      </div>
      <div class="graph small-graph">
        <h2 class="roboto-bold">Details</h2>
        <p>Mandatory hours : 8:30 - 12:30 / 14:00 - 17:00</p>
        <p>Paid overtime available : 4 hours</p>
        <div class="progress-outside"><div class="progress-inside paid-overtime"></div></div>
        <p>Unpaid overtime done : 0 hours</p>
        <p>Night shifts worked this week : 1</p>
        <div class="progress-outside"><div class="progress-inside night-shifts"></div></div>
      </div>
    </div>
    <div class="graph big-graph">
      <h2 class="roboto-bold">The past 7 days</h2>
    </div>
  </div>
</template>

<style>


.main-container {
  width: 100%;
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: var(--light);
}

.graph-container {
  width: 95%;
  height: 40%;
  display: flex;
  justify-content: space-between;
  margin: 12px 0;
}

.graph {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0px 4px 9px 3px rgba(2,2,0,0.4);
  border-radius: 10px;
  background-color: white;
  padding: 15px 25px;
  min-width: 345px;
  min-height: 315px;
}

.big-graph {
  width: 95%;
  height: 45%;
  margin-bottom: 15px;
}

.small-graph{
  width: 48%;
  height: 100%;
}

.small-graph h2, .big-graph h2 {
  font-size: 36px;
}

.progress-outside{
  height: 25px;
  width: 300px;
  background-color: rgb(182, 181, 181);
  border-radius: 15px;
}

.progress-inside{
  height: 100%;
  border-radius: 15px;
}

.paid-overtime {
  background-color: #F2BC0F;
  width: v-bind('paidOvertimeRatio');
}

.night-shifts {
  background-color: #e80c13;
  width: v-bind('nightShiftsRatio');
}

.small-graph p {
align-self: flex-start;
}

@media (max-width:940px)  {
  .main-container {
  height: auto;
  min-height: 100%;
}
  .graph-container {
    flex-direction: column;
    align-items: center;
    width: 100%;
    height: auto;
  }
  
  .graph {
    margin-bottom: 15px;
    width: 100%;
  }
}

</style>