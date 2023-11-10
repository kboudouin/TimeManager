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
  <div>
    <h1>TEAM</h1>
    <h1 class="text-3xl font-semibold mb-4">Team Management</h1>

    <!-- Section "Mes équipes" -->
    <h2 class="text-xl font-semibold mb-4">My teams (snap to see more)</h2>

    <div class="carousel rounded-box">
      <div class="carousel-item" v-for="team in teams" :key="team.id">
        <div class="flex flex-col w-full lg:flex-row">
          <div class="relative group grid flex-grow h-80 card bg-base-300 rounded-box place-items-center">
            <div class="absolute top-2 left-2 cursor-pointer text-red-500 opacity-0 group-hover:opacity-100 transition-opacity" @click="deleteTeam(team.id)">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
              </svg>
            </div>
            <h1>Equipe ID: {{ team.id }}</h1>
            <h2>Leader: {{ team.leader }}</h2>
            <h2>Membres: {{ team.members }}</h2>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      userUsername: null,
      id: null,
      EMAIL: null,
      selectedMembers: [],
      LIST: [],
      teams: [
        { id: 1, leader: 'John Doe', members: 'membres1' },
        { id: 2, leader: 'Jane Doe', members: 'membres2' },
        { id: 3, leader: 'Doe Doe', members: 'membres3' },
        // Add more teams as needed
      ],
    };
  },
  created() {
    // Récupérez la valeur depuis le localStorage
    this.userUsername = localStorage.getItem('userUsername');
    this.id = localStorage.getItem('userId');
    this.EMAIL = localStorage.getItem('userEmail');
  },
  methods: {
    getDividers(team) {
      // You can modify this function to select dividers based on your logic.
      return [
        { id: team.id, leader: team.leader, members: team.members },
        { id: team.id + 1, leader: team.leader + '1', members: team.members + '1' },
        { id: team.id + 2, leader: team.leader + '2', members: team.members + '2' },
      ];
    },
  },
};
</script>

<style>
</style>
