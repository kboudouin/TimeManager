<script setup>
import axios from "axios";
import WorkingTimes from "./WorkingTimes.vue";
import EditModal from "./Modal/edit-modal.vue";
import CreateModal from "./Modal/create-modal.vue";
import DeleteModal from "./Modal/delete-modal.vue";
import router from "../../router";
import VueCookies from "vue-cookies";
import { defineProps, onMounted, ref } from "vue";
import { useRoute } from "vue-router";
import { store } from "./store.js";

const { user } = defineProps(["user"]);
const selectedID = ref(null);

const route = useRoute();
const id = route.params.id;

// if (
//   localStorage.getItem("userId") !== id &&
//   localStorage.getItem("role") !== "admin"
// ) {
//   router.replace("/error");
// }

// API CALL
const getWorkingTimes = async () => {
  //get id from prop or url
  const route = useRoute();
  let id = route.params.id;
  if (id == null && user) {
    id = user.id;
  }
  if (!id && !user) {
    id = localStorage.getItem("userId");
  }
  selectedID.value = id;
  try {
    const token = localStorage.getItem("token");
    const response = await axios.get(
      `https://epitechproject.com/api/workingtimes/${id}?start=2022-01-01T00:00:00Z&end=2023-12-30T00:00:00Z`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
    if (response.data.error) {
      router.replace("/error");
    }
    return store.setWorkingTimes(response.data.workingtimes.reverse());
  } catch (error) {
    store.setWorkingTimes([]);
    console.error(error);
  }
};
onMounted(getWorkingTimes);
</script>

<template>
  <div class="h-screen">
    <WorkingTimes />
    <!-- MODAL -->
    <CreateModal :id="selectedID" v-if="store.createModal" />
    <DeleteModal :id="selectedID" v-if="store.deleteModal" />
    <EditModal :id="selectedID" v-if="store.editModal" />
  </div>
</template>

<style scoped></style>
