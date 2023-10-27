<script setup>
import WorkingTimeVue from "./WorkingTime.vue";
import { store } from "./store.js";
const createEvent = () => {
  store.toggleCreateModal();
};
</script>

<template>
  <section class="workingTimes">
    <div class="workingTimes-header">
      <!-- BUTTON TO ADD A NEW WORKING TIME -->
      <button @click="createEvent">Ajouter un temps de travail</button>
    </div>
    <div class="workingTimes-list">
      <!-- LIST OF WORKING TIMES -->
      <WorkingTimeVue
        v-for="item in store.workingTimes"
        :key="Math.random() + item.user"
        :data="item" />
    </div>
  </section>
</template>

<style scoped lang="scss">
.workingTimes {
  width: 100%;
  height: 100dvh;
  background: #2b2b2b;
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 10% 90%;
  //   HEADER
  &-header {
    width: 100%;
    height: 100%;
    // background: red;
    display: flex;
    justify-content: right;
    align-items: center;

    button {
      padding: 1rem;
      color: white;
      background-color: #0088ff;
      border-radius: 5px;
      margin: 0 2rem;
      border: 0;
    }
  }
  //   LIST
  &-list {
    width: 100%;
    height: 100%;
    display: grid;
    margin: 0 auto;
    grid-template-columns: 1fr;
    grid-template-rows: repeat(15, 1fr);
    grid-auto-rows: 1fr;
    overflow-y: visible;
    overflow-x: hidden;
    &::-webkit-scrollbar {
      width: 0.5rem;
    }
    &::-webkit-scrollbar-track {
      background: #f1f1f1;
    }
    &::-webkit-scrollbar-thumb {
      background: #888;
    }
    &::-webkit-scrollbar-thumb:hover {
      background: #555;
    }
  }
}
</style>
