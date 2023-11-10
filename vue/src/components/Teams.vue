<template>
  <div>
    <h1>TEAM</h1>
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>

    <div class="carousel rounded-box">
      <div class="carousel-item" v-for="team in teams" :key="team.id">
        <div class="flex flex-col w-full lg:flex-row">
          <div v-for="index in 3" :key="index" class="grid flex-grow h-32 card bg-base-300 rounded-box place-items-center">
            <template v-if="team.members">
              <h1>Equipe ID: {{ team.id }}</h1>
              <h2>Leader: {{ team.leader }}</h2>
              <h2>Membres: {{ team.members }}</h2>
            </template>
          </div>
          <div v-if="index !== 3" class="divider lg:divider-horizontal"></div>
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
      items: [
        { text: 'test testte 1' },
        { text: 'test testte 2' },
        { text: 'test testte 3' },
        { text: 'test testte 4' },
        { text: 'test testte 5' },
        { text: 'test testte 6' },
        { text: 'test testte 7' },
      ],
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
