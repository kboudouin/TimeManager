<script setup>
import { ref, onMounted } from "vue";
import { useToast } from "vue-toast-notification";
import axios from "axios";

const loading = ref(false);
const userData = ref(null);
const clocksData = ref(null);

onMounted(() => {
  const $toast = useToast();
  $toast.success("Welcome to the admin dashboard");
  fetchData();
});

const fetchData = async () => {
  loading.value = true;
  try {
    const userResponse = await axios.get(
      `http://44.207.191.254:4000/api/users`
    );
    userData.value = userResponse.data.users;

    const clockResponse = await axios.get(
      `http://44.207.191.254:4000/api/clocks`
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
</script>

<template>
  <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead
        class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"
      >
        <tr>
          <th scope="col" class="px-6 py-3">Presence</th>
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
          <td class="px-6 py-4">{{ user.username }}</td>
          <td class="px-6 py-4">{{ user.email }}</td>
          <td class="px-6 py-4">
            <a
              href="#"
              class="font-medium text-blue-600 dark:text-blue-500 hover:underline"
              ><router-link
                :to="{ name: 'workingtime', params: { id: user.id } }"
                >View</router-link
              ></a
            >
          </td>
          <td class="px-6 py-4">
            <a
              href="#"
              class="font-medium text-blue-600 dark:text-blue-500 hover:underline"
              ><router-link
                :to="{ name: 'chartManager', params: { id: user.id } }"
                >View</router-link
              ></a
            >
          </td>
          <td class="px-6 py-4 text-right">
            <a
              href="#"
              class="font-medium text-blue-600 dark:text-blue-500 hover:underline"
              >Edit</a
            >
          </td>
          <td class="px-6 py-4 text-right">
            <a
              href="#"
              class="font-medium text-blue-600 dark:text-blue-500 hover:underline"
              >Delete</a
            >
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
