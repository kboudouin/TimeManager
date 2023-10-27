<script setup>
import axios from "axios";
import WorkingTimes from "./WorkingTimes.vue";
import EditModal from "./Modal/edit-modal.vue";
import CreateModal from "./Modal/create-modal.vue";
import DeleteModal from "./Modal/delete-modal.vue";
import { store } from "./store.js";

// API CALL
const getWorkingTimes = async () => {
  try {
    const response = await axios.get(
      `http://localhost:4000/api/workingtimes/${localStorage.getItem(
        "userId"
      )}?start=2022-01-01T00:00:00Z&end=2023-12-30T00:00:00Z`
    );
    return store.setWorkingTimes(response.data.workingtimes.reverse());
  } catch (error) {
    store.setWorkingTimes([]);
    console.error(error);
  }
};
getWorkingTimes();
</script>

<template>
  <div>
    <WorkingTimes />
    <!-- MODAL -->
    <CreateModal v-if="store.createModal" />
    <DeleteModal v-if="store.deleteModal" />
    <EditModal v-if="store.editModal" />
  </div>
</template>

<style scoped></style>
