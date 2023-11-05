<script setup>
import { ref, onMounted } from "vue";
import { useRouter, useRoute } from "vue-router";
import { useToast } from "vue-toast-notification";
import axios from "axios";
import router from ".../router";
import deleteModal from "./adminDelete.vue";
import modifyModal from "./adminModify.vue";
import chartModal from "../ChartManager.vue";
import wtModal from "../workingTimes/wtRender.vue";
import VueCookies from "vue-cookies";

// Loading ref
const loading = ref(false);

// Data refs
const userData = ref(null);
const clocksData = ref(null);

// Toogle refs
const toggleDelete = ref(false);
const toggleModify = ref(false);
const toggleChart = ref(false);
const toggleWt = ref(false);

// Prop refs
const selectedID = ref(null);
const selectedUser = ref(null);

onMounted(() => {
  fetchData();
});

const fetchData = async () => {
  loading.value = true;
  try {
    const token = VueCookies.get("token");
    const userResponse = await axios.get(
      `http://44.207.191.254:4000/api/users`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
    if (userResponse.data.error) {
      router.replace("/error");
    }
    userData.value = userResponse.data.users;

    const clockResponse = await axios.get(
      `http://44.207.191.254:4000/api/clocks`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
    clocksData.value = clockResponse.data.clocks;

    userData.value = userData.value.map((user) => {
      const clock = clocksData.value.find((c) => c.user === user.id.toString());
      if (clock) {
        user.status = clock.status;
      } else {
        user.status = "False";
      }
      return user;
    });
  } catch (error) {
    const $toast = useToast();
    $toast.error("Error fetching data");
    console.error(error);
  }
};

const toggleDeleteModal = async (user) => {
  toggleDelete.value = !toggleDelete.value;
  selectedUser.value = user;
};

const toggleModifyModal = async (user) => {
  toggleModify.value = !toggleModify.value;
  selectedUser.value = user;
};

const toggleChartModal = async (user) => {
  toggleChart.value = !toggleChart.value;
  selectedUser.value = user;
};

const toggleWtModal = async (user) => {
  toggleWt.value = !toggleWt.value;
  console.log("Toogle Wt modal" + user);
  selectedUser.value = user;
};
</script>

<template>
  <!-- Delete toggle modal component -->
  <div v-if="toggleDelete">
    <deleteModal
      @close="toggleDeleteModal"
      :user="selectedUser"
      @fetchData="fetchData"
    />
  </div>

  <!-- Modify toggle modal component -->
  <div v-if="toggleModify">
    <modifyModal
      @close="toggleModifyModal"
      :user="selectedUser"
      @fetchData="fetchData"
    />
  </div>

  <!-- Chart toggle modal component -->
  <div v-if="toggleChart" class="fixed z-40 inset-0 overflow-y-auto">
    <button
      @click="toggleChartModal"
      class="absolute z-50 right-6 top-6 text-sm bg-red-500 hover:bg-red-600 text-white py-2 px-2 rounded-lg"
    >
      Close
    </button>
    <div
      class="md:mx-16 my-8 bg-white rounded-xl shadow-lg p-6 dark:bg-gray-800 max-h-screen overflow-y-auto relative"
    >
      <h2 class="font-extrabold text-xl">
        Charts for {{ selectedUser.username }}
      </h2>
      <div class="relative m-4">
        <chartModal
          :user="selectedUser"
          @fetchData="fetchData"
          class="items-center justify-center"
        />
      </div>
    </div>
  </div>

  <!-- WorkingTimes toggle modal component -->
  <div v-if="toggleWt" class="fixed z-40 inset-0 overflow-y-auto">
    <button
      @click="toggleWtModal"
      class="absolute z-50 right-6 top-6 text-sm bg-red-500 hover:bg-red-600 text-white py-2 px-2 rounded-lg"
    >
      Close
    </button>
    <div
      class="md:mx-16 my-8 bg-white rounded-xl shadow-lg p-6 dark:bg-gray-800 max-h-screen overflow-y-auto relative"
    >
      <h2 class="font-extrabold text-xl">
        WorkingTimes for {{ selectedUser.username }}
      </h2>
      <div class="relative m-4">
        <wtModal
          :user="selectedUser"
          @fetchData="fetchData"
          class="items-center justify-center"
        />
      </div>
    </div>
  </div>

  <!-- Admin users table -->
  <div class="relative overflow-x-auto shadow-md sm:rounded-lg z-10">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead
        class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"
      >
        <tr>
          <th scope="col" class="px-6 py-3">Presence</th>
          <th scope="col" class="px-6 py-3">Role</th>
          <th scope="col" class="px-6 py-3">Username</th>
          <th scope="col" class="px-6 py-3">Email</th>
          <th scope="col" class="px-6 py-3">Workingtime</th>
          <th scope="col" class="px-6 py-3">Stats</th>
          <th scope="col" class="px-6 py-3">
            <span class="sr-only">Edit</span>
          </th>
          <th scope="col" class="px-6 py-3">
            <span class="sr-only">Delete</span>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr
          class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600"
          v-for="user in userData"
        >
          <th
            scope="row"
            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white"
          >
            {{ user.status === true ? "True" : "False" }}
          </th>
          <td class="px-6 py-4">{{ user.role }}</td>
          <td class="px-6 py-4">{{ user.username }}</td>
          <td class="px-6 py-4">{{ user.email }}</td>
          <td class="px-6 py-4">
            <a
              @click="toggleWtModal(user)"
              class="font-medium text-blue-600 dark:text-blue-500 hover:underline"
              >View</a
            >
          </td>
          <td class="px-6 py-4">
            <a
              @click="toggleChartModal(user)"
              class="font-medium text-blue-600 dark:text-blue-500 hover:underline"
              >View
            </a>
          </td>
          <td class="px-6 py-4 text-right">
            <a
              @click="toggleModifyModal(user)"
              class="font-medium text-blue-600 dark:text-blue-500 hover:underline"
              >Edit</a
            >
          </td>
          <td class="px-6 py-4 text-right">
            <a
              @click="toggleDeleteModal(user)"
              class="font-medium text-blue-600 dark:text-blue-500 hover:underline"
              >Delete</a
            >
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
