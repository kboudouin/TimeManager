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
            <div class="divider lg:divider-horizontal"></div>
          </div>
          <div v-if="index !== 1" class="divider lg:divider-horizontal"></div>
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
        { id: 1, leader: 'John Doe', members: 'membres' },
        { id: 2, leader: 'Jane Doe', members: 'membres' },
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
};
</script>

<style>
</style>
