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
    dateObj.getHours() < 10
      ? `0${dateObj.getHours() - 1}`
      : dateObj.getHours() - 1;
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
  <tr
    class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
    <td class="px-6 py-4">
      <span
        class="bg-yellow-100 text-yellow-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-yellow-900 dark:text-yellow-300"
        >{{ heure(data.start) }}</span
      >
    </td>
    <td class="px-6 py-4">
      <span
        class="bg-yellow-100 text-yellow-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-yellow-900 dark:text-yellow-300"
        >{{ heure(data.end) }}</span
      >
    </td>
    <td class="px-6 py-4">
      <button
        style="background: #008cff; color: white; border: 0"
        @click="editModal(data)"
        class="btn btn-xs btn-error">
        Edit
      </button>
    </td>
    <td class="px-6 py-4">
      <button
        style="background: #f52525; color: white; border: 0"
        @click="deleteModal(data)"
        class="btn btn-xs btn-error">
        Delete
      </button>
    </td>
  </tr>
</template>

<style scoped lang="scss">
._workingTime {
  background: #2b2b2b;
  border-radius: 5px;
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
