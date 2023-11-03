<script setup>
import { ref } from "vue";
import axios from "axios";
import { useToast } from "vue-toast-notification";
</script>

<template>
    <div class="container mx-auto py-4">
      <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>
  
      <!-- Affichage de toutes les équipes -->
      <section class="mb-8">
        <h2 class="text-xl font-semibold mb-4">Toutes les équipes</h2>
        <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <li v-for="team in teams" :key="team.id" class="bg-white p-4 rounded-lg shadow">
            <h3 class="text-lg font-semibold">{{ team.name }}</h3>
            <p class="text-gray-500">{{ team.description }}</p>
            <button @click="editTeam(team.id)" class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Modifier</button>
          </li>
        </ul>
      </section>
  
      <!-- Affichage des équipes de l'utilisateur connecté -->
      <section>
        <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>
        <ul class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <li v-for="team in myTeams" :key="team.id" class="bg-white p-4 rounded-lg shadow">
            <h3 class="text-lg font-semibold">{{ team.name }}</h3>
            <p class="text-gray-500">{{ team.description }}</p>
            <button @click="leaveTeam(team.id)" class="mt-4 bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600">Quitter</button>
          </li>
        </ul>
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
        ],
        myTeams: [
          { id: 1, name: 'Mon Équipe A', description: 'Ma description de l\'équipe A' },
        ],
      };
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
  