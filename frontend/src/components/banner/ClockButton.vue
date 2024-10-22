<script setup>
import { ref } from 'vue'

let startTime = ref(null)
let endTime = ref(null)
let workedTime = ref(null)

function toggleTimer() {
  if (!clockHasStarted.value) {
    startTime.value = Date.now()
    console.log('start time : ' + startTime.value)
  } else {
    endTime.value = Date.now()
    console.log('end time : ' + endTime.value)
    workedTime.value = endTime.value - startTime.value
    console.log('You worked :' + workedTime.value)
  }

  toggleClock()
}

let clockHasStarted = ref(false)
function toggleClock() {
  clockHasStarted.value = !clockHasStarted.value
}
</script>

<template>
  <button v-if="!clockHasStarted" @click="toggleTimer" class="custom-button green">
    Clock in <img src="../../assets/play.svg" alt="" class="play-icon" />
  </button>
  <button v-if="clockHasStarted" @click="toggleTimer" class="custom-button">
    Clock out <img src="../../assets/stop.svg" alt="" class="play-icon" />
  </button>
</template>

<style>
.custom-button {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  width: 200px;
  height: 70px;
  margin-right: 25px;
  padding: 0 15px 0 15px;
  border: none;
  border-radius: 5px;
  background-color: rgb(152, 3, 3);
  color: var(--light);
  font-size: 30px;
  cursor: pointer;
  box-shadow: 4px 4px 9px 3px rgba(0, 0, 0, 0.315);
}

button:hover {
  transform: scale(110%);
}

.green {
  background-color: #108f10;
}

.play-icon {
  margin-left: 10px;
  width: 30px;
  height: 30px;
}

@media (max-width:940px) {
  button {
    width: 140px;
    height: 45px;
    font-size: 16px;
    margin: 0;
  }
  .play-icon {
    width: 24px;
  }
}
</style>
