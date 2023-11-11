<template>
  <div>
    <h1>TEAM</h1>
    <h1 class="text-3xl font-semibold mb-4">Team Management</h1>

    <!-- Section "Mes équipes" -->
    <h2 class="text-xl font-semibold mb-4">My teams (snap to see more)</h2>

    <div class="carousel rounded-box">
      <div class="carousel-item" v-for="team in teams" :key="team.id">
        <div class="flex flex-col w-full lg:flex-row">
          <template v-for="(divider, index) in getDividers(team)" :key="index">
            <div
              class="relative group grid flex-grow h-80 card bg-base-300 rounded-box place-items-center"
            >
              <div
                class="absolute top-2 left-2 cursor-pointer text-red-500 opacity-0 group-hover:opacity-100 transition-opacity"
              >
                <svg
                  class="h-4 w-4"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M6 18L18 6M6 6l12 12"
                  ></path>
                </svg>
              </div>
              <template v-if="divider.members">
                <h1>Equipe ID: {{ divider.id }}</h1>
                <h2>Leader: {{ divider.leader }}</h2>
                <h2>Membres: {{ divider.members }}</h2>
              </template>
            </div>
            <div v-if="index !== 2" class="divider lg:divider-horizontal"></div>
          </template>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
<<<<<<< HEAD
=======
import { ref, watch, onMounted } from "vue";
import addTeamModal from "./adminTeamAdd.vue";
import { useToast } from "vue-toast-notification";
import axios from "axios";

>>>>>>> parent of d679915 (test)
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

<style></style>
