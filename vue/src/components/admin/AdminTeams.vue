<script setup>
import { ref, watch, onMounted } from "vue";
import addTeamModal from "./adminTeamAdd.vue";
import { useToast } from "vue-toast-notification";
import axios from "axios";
import { defineProps, defineEmits } from "vue";

const teams = ref(null);
const toggleAdd = ref(false);

const fetchData = async () => {
  try {
    const token = localStorage.getItem("token");
    const resp = await axios.get(`https://epitechproject.com/api/teams`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    console.log;
    if (resp.data.teams) {
      teams.value = resp.data.teams;
    }
  } catch (error) {
    const $toast = useToast();
    $toast.error("Error fetching all teams!");
    console.error(error);
  }
};

const deleteTeam = async (id) => {
  try {
    const token = localStorage.getItem("token");
    const resp = await axios.delete(
      `https://epitechproject.com/api/teams/${id}`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
    const $toast = useToast();
    $toast.success("Team Deleted!");
    fetchData();
  } catch (error) {
    const $toast = useToast();
    $toast.error("Error deleting team!");
    console.error(error);
  }
};

const toggleAddModal = async () => {
  toggleAdd.value = !toggleAdd.value;
};

onMounted(() => {
  fetchData();
});
</script>

<template>
  <button @click="toggleAddModal" class="btn btn-success fixed top-4 right-32">
    Create Team
  </button>

  <div v-if="toggleAdd">
    <addTeamModal @close="toggleAddModal" @fetchData="fetchData" />
  </div>

  <div class="relative overflow-x-auto shadow-md sm:rounded-lg z-10 mt-12">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead
        class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"
      >
        <tr>
          <th scope="col" class="px-6 py-3">Manager</th>
          <th scope="col" class="px-6 py-3">Members</th>
          <th scope="col" class="px-6 py-3">Action</th>
        </tr>
      </thead>
      <tbody>
        <tr
          class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600"
          v-for="team in teams"
        >
          <td class="px-6 py-4">
            <span
              class="bg-yellow-100 text-yellow-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-yellow-900 dark:text-yellow-300"
              >{{ team.leader }}</span
            >
          </td>
          <td class="px-6 py-4">
            <span
              class="bg-blue-100 text-blue-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300"
              v-for="member in team.members"
              >{{ member.user }}</span
            >
          </td>
          <td class="px-6 py-4">
            <button @click="deleteTeam(team.id)" class="btn btn-xs btn-error">
              Delete
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
