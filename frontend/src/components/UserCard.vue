<script setup>
import Knob from 'primevue/knob';
import { computed, ref } from 'vue';

let value = ref(60)

const blobColor = computed(() => {
  if (value.value > 100) {
    return '#d20d0d';
  } else if (value.value >= 75) {
    return '#0e9604';
  } else {
    return '#dfc51c';
  }
});

</script>

<template>
<article class="card-user">
  <img src="../assets/images/user_avatar.png" alt="">
  <div class="card-user-info">
    <h2>Petit Pote</h2>
    <h3>Unlimited gold summoner</h3>
    <p>Worked time score :</p>
  </div>
  <Knob v-model="value" valueTemplate="{value}%" :valueColor="blobColor" />
  <img src="../assets/trash1.svg" class="bin-icon" alt="">
</article>
</template>

<style>
.card-user {
  padding: 5px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  width: 170px;
  height: 250px;
  border: 2px solid rgba(0, 0, 0, 0.287);
  margin: 0 15px 15px 15px;
  /* color: #dfc51c; */
}

.card-user h2 {
  text-align: center;
  font-size: 18px;
  font-weight: 600;
}

.card-user h3 {
  text-align: center;
  font-size: 14px;
  font-weight: 300;
  font-style: italic;
}

.card-user p {
  text-align: center;
  font-size: 12px;
}

.bin-icon {
  position: relative;
  top: -245px;
  left: 62px
}

@media (max-width:940px) {
  .card-user{
    width: 90%;
    max-width: 520px;
    height: fit-content;
    flex-direction: row;
    padding: 10px;
  }
  .bin-icon {
    position:relative;
    top: 0;
    left: 0;
  }
  .card-user h2{
    font-size: 16px;
    text-align: start;
    margin-bottom: 10px;
  }
  .card-user h3{
    font-size: 12px;
    text-align: start;
    margin-bottom: 10px;
  }
  .card-user p{
    font-size: 10px;
    text-align: end;
  }
  .card-user-info {
    padding-left: 4px;
  }
}
</style>