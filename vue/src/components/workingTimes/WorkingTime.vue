<script setup>
import { store } from "./store.js";
defineProps({
  data: Object,
});

const heure = (date) => {
  const dateObj = new Date(date);
  const day =
    dateObj.getDate() < 10 ? `0${dateObj.getDate()}` : dateObj.getDate();
  const month =
    dateObj.getMonth() + 1 < 10
      ? `0${dateObj.getMonth() + 1}`
      : dateObj.getMonth() + 1;
  const year = dateObj.getFullYear();
  const hour =
    dateObj.getHours() < 10 ? `0${dateObj.getHours()}` : dateObj.getHours();
  const minutes =
    dateObj.getMinutes() < 10
      ? `0${dateObj.getMinutes()}`
      : dateObj.getMinutes();
  return `${day}/${month}/${year} ${hour}:${minutes}`;
};

const editModal = (data) => {
  store.toggleEditModal();
  store.workingTimeData(data);
};
const deleteModal = (data) => {
  store.toggleDeleteModal();
  store.workingTimeData(data);
};
</script>

<template>
  <div class="workingTime">
    <div class="workingTime-1 p-6">
      <p>{{ data.id }}</p>
      <p>{{ heure(data.start) }}</p>
      <p>{{ heure(data.end) }}</p>
    </div>
    <div class="workingTime-2">
      <button @click="editModal(data)">Modifier</button>
      <button @click="deleteModal(data)">Supprimer</button>
    </div>
  </div>
</template>

<style scoped lang="scss">
.workingTime {
  background: #2b2b2b;
  border-radius: 5px;
  // border: 1px solid black;
  box-shadow: 0px 0px 2px 0px rgba(133, 133, 133, 0.75);
  width: 100%;
  height: 100%;
  display: grid;
  grid-template-columns: 80% 20%;
  grid-template-rows: 1fr;
  //   PART 1 FOR DATA
  &-1 {
    display: flex;
    justify-content: space-around;
    align-items: center;
  }
  &-2 {
    display: flex;
    justify-content: space-around;
    align-items: center;
  }
  p {
    color: white;
  }
  // BUTTON STYLISATION
  button {
    color: white;
    &:first-child {
      background: orange;
    }
    &:last-child {
      background: red;
    }
  }
}
</style>
