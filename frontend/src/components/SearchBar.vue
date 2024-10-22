<script setup>
const props = defineProps({placeholder: String})

console.log(props.placeholder);

</script>

<template>
  <div class="searchbar-container">
    <input type="text" placeholder="Temporary placeholder" class="searchbar">
    <img src="../assets/search.svg" alt="" class="searchbar-icon">
  </div>

</template>

<style>
.searchbar-container {
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 15px;
}
.searchbar {
  width: 300px;
  height: 50px;
  border-radius: 25px;
  padding: 15px;
}

.searchbar-icon{
height: 25px;
position: relative;
left: -45px;
}

.searchbar-icon:hover{
  transform: scale(110%);
}

@media (max-width:380px) {
  .searchbar {
    width: 250px;
  }
}
</style>