<script setup>
import { ref } from "vue";
import axios from "axios";
import { useToast } from "vue-toast-notification";
</script>
<template>
  <div class="container mx-auto py-4">
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

  
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>
      <div class="carousel w-full">
        <div v-for="(group, index) in groupedTeams" :key="index" :id="'slide' + (index + 1)" class="carousel-item relative w-full">
          <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <li v-for="team in group" :key="team.id" class="bg-white p-4 rounded-lg shadow">
              <h3 class="text-lg font-semibold">{{ team.name }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button @click="editTeam(team.id)" class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Modifier</button>
            </li>
          </ul>
          <div class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2">
            <a :href="'#slide' + (index === 0 ? groupedTeams.length - 1 : index - 1)" class="btn btn-circle">❮</a>
            <a :href="'#slide' + (index === groupedTeams.length - 1 ? 0 : index + 1)" class="btn btn-circle">❯</a>
          </div>
        </div>
      </div>
    </section>
 
    
    
     <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Toutes les équipes</h2>
      <div class="carousel w-full">
        <div v-for="(group, index) in groupedTeams" :key="index" :id="'slide' + (index + 1)" class="carousel-item relative w-full">
          <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <li v-for="team in group" :key="team.id" class="bg-white p-4 rounded-lg shadow">
              <h3 class="text-lg font-semibold">{{ team.name }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button @click="editTeam(team.id)" class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Modifier</button>
            </li>
          </ul>
          <div class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2">
            <a :href="'#slide' + (index === 0 ? groupedTeams.length - 1 : index - 1)" class="btn btn-circle">❮</a>
            <a :href="'#slide' + (index === groupedTeams.length - 1 ? 0 : index + 1)" class="btn btn-circle">❯</a>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      teams: [
        { id: 1, name: 'Équipe A', description: 'Description de l\'équipe A' },
        { id: 2, name: 'Équipe B', description: 'Description de l\'équipe B' },
        { id: 3, name: 'Équipe C', description: 'Description de l\'équipe C' },
        { id: 1, name: 'Équipe D', description: 'Description de l\'équipe A' },
        { id: 2, name: 'Équipe E', description: 'Description de l\'équipe B' },
        { id: 3, name: 'Équipe F', description: 'Description de l\'équipe C' },
        { id: 1, name: 'Équipe G', description: 'Description de l\'équipe A' },
        { id: 2, name: 'Équipe H', description: 'Description de l\'équipe B' },
        { id: 3, name: 'Équipe I', description: 'Description de l\'équipe C' },
        // Ajoutez d'autres équipes ici
      ],
      myTeams: [
        { id: 1, name: 'Mon Équipe A', description: 'Ma description de l\'équipe A' },
        // Ajoutez d'autres équipes de l'utilisateur ici
      ],
    };
  },
  computed: {
    groupedTeams() {
      const chunkSize = 3; // Nombre d'équipes par groupe
      return this.teams.reduce((resultArray, item, index) => {
        const chunkIndex = Math.floor(index / chunkSize);
        if (!resultArray[chunkIndex]) {
          resultArray[chunkIndex] = [];
        }
        resultArray[chunkIndex].push(item);
        return resultArray;
      }, []);
    },
  },
  methods: {
    editTeam(teamId) {
      // Fonction pour éditer une équipe (à implémenter)
    },
    leaveTeam(teamId) {
      // Fonction pour quitter une équipe (à implémenter)
    },
  },
};
</script>