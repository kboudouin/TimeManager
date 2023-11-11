<template>
  <div>
    <h1>TEAM</h1>
    <h1 class="text-3xl font-semibold mb-4">Team Management</h1>

    <!-- Section "Mes équipes" -->
    <h2 class="text-xl font-semibold mb-4">My teams (snap to see more)</h2>

    <div class="carousel rounded-box">
      <div class="carousel-item" v-for="team in teams" :key="team.id">
        <div class="flex flex-col w-full lg:flex-row">
          <div v-for="index in 3" :key="index" class="relative group grid flex-grow h-80 card bg-base-300 rounded-box place-items-center">
            <div class="absolute top-2 left-2 cursor-pointer text-red-500 opacity-0 group-hover:opacity-100 transition-opacity">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
              </svg>
            </div>
            <template v-if="team.members">
              <h1>Equipe ID: {{ team.id }}</h1>
              <h2>Leader: {{ team.leader }}</h2>
              <h2>Membres: {{ team.members }}</h2>
            </template>
          </div>
          <div v-if="index !== 1" class="divider lg:divider-horizontal"></div>
        </div>
      </div>
    </div>
    
    <button @click="toggleAddModal" class="btn btn-success fixed top-4 right-32">
      Create Team
    </button>

    <div v-if="toggleAdd">
      <addTeamModal @close="toggleAddModal" @fetchData="fetchData" />
    </div>

    <div class="relative overflow-x-auto shadow-md sm:rounded-lg z-10 mt-12">
      <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead
          class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th scope="col" class="px-6 py-3">Manager</th>
            <th scope="col" class="px-6 py-3">Members</th>
            <th scope="col" class="px-6 py-3">Action</th>
          </tr>
        </thead>
        <tbody>
          <tr
            class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600"
            v-for="team in teams">
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
                >{{ member }}</span
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
  </div>
</template>

<script>
import { ref, watch, onMounted } from "vue";
import addTeamModal from "./adminTeamAdd.vue";
import { useToast } from "vue-toast-notification";
import axios from "axios";

export default {
  data() {
    return {
      userUsername: null,
      id: null,
      EMAIL: null,
      selectedMembers: [],
      LIST: [],
      toggleAdd: false,
      teams: [
        { id: 1, leader: 'John Doe', members: ['member1', 'member2'] },
        { id: 2, leader: 'Jane Doe', members: ['member3', 'member4'] },
        // Add more teams as needed
      ],
    };
  },
  methods: {
    fetchData: async function () {
      try {
        const token = localStorage.getItem("token");
        const resp = await axios.get(`https://epitechproject.com/api/teams`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        if (resp.data.teams) {
          this.teams = resp.data.teams;
        }
      } catch (error) {
        const $toast = useToast();
        $toast.error("Error fetching all teams!");
        console.error(error);
      }
    },
    deleteTeam: async function (id) {
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
        this.fetchData();
      } catch (error) {
        const $toast = useToast();
        $toast.error("Error deleting team!");
        console.error(error);
      }
    },
    toggleAddModal: function () {
      this.toggleAdd = !this.toggleAdd;
    },
  },
  created() {
    this.userUsername = localStorage.getItem('userUsername');
    this.id = localStorage.getItem('userId');
    this.EMAIL = localStorage.getItem('userEmail');
  },
  mounted() {
    this.fetchData();
  },
};
</script>

<style>
</style>
