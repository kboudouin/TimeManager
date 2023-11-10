<template>
  <div class="container mx-auto py-4">
    <h1 class="text-3xl font-semibold mb-4">Gestion des équipes</h1>

    <!-- Section "Mes équipes" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Mes équipes</h2>
      <div class="carousel w-full">
        <div
          v-for="(group, index) in groupedTeams"
          :key="index"
          :id="'slide' + (index + 1)"
          class="carousel-item relative w-full"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <div
              v-for="team in group"
              :key="team.id"
              class="bg-white p-4 rounded-lg shadow"
            >
              <h3 class="text-lg font-semibold">{{ team.leader }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button
                @click="editTeam(team.id)"
                class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
              >
                Modifier
              </button>
            </div>
          </div>
          <div
            class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2"
          >
            <a
              :href="
                '#slide' + (index === 0 ? groupedTeams.length - 1 : index - 1)
              "
              class="btn btn-circle"
              >❮</a
            >
            <a
              :href="
                '#slide' + (index === groupedTeams.length - 1 ? 0 : index + 1)
              "
              class="btn btn-circle"
              >❯</a
            >
          </div>
        </div>
      </div>
    </section>

    <!-- Section "Toutes les équipes" -->
    <section class="mb-8">
      <h2 class="text-xl font-semibold mb-4">Toutes les équipes</h2>

      <div class="carousel w-full">
        <div
          v-for="(team, index) in allTeams"
          :key="index"
          :id="'slide' + (index + 1)"
          class="carousel-item relative w-full"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <div class="bg-white p-4 rounded-lg shadow">
              <h3 class="text-lg font-semibold">{{ team.leader }}</h3>
              <p class="text-gray-500">{{ team.description }}</p>
              <button
                @click="editTeam(team.id)"
                class="mt-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
              >
                Modifier
              </button>
            </div>
            <!-- Add two more grid items for the other team members -->
            <!-- Repeat the structure for the other team members -->
          </div>
          <div
            class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2"
          >
            <a
              :href="
                '#slide' + (index === 0 ? allTeams.length - 1 : index - 1)
              "
              class="btn btn-circle"
              >❮</a
            >
            <a
              :href="
                '#slide' + (index === allTeams.length - 1 ? 0 : index + 1)
              "
              class="btn btn-circle"
              >❯</a
            >
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import axios from "axios";
import VueCookies from "vue-cookies";
import { useToast } from "vue-toast-notification";

export default {
  data() {
    return {
      userUsername: null,
      id: null,
      EMAIL: null,
      selectedMembers: [],
      LIST: [],
    };
  },
  created() {
    // Récupérez la valeur depuis le localStorage
    this.userUsername = localStorage.getItem("userUsername");
    this.id = localStorage.getItem("userId");
    this.EMAIL = localStorage.getItem("userEmail");
  },
  methods: {
  
  },

  setup() {
    const teams = [
      // Ajoutez d'autres équipes ici
    ];

    onMounted(() => {

    });

    return {
   
    };
  },
};
</script>
